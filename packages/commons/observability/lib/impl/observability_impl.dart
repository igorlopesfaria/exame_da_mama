import 'package:commons_observability/api/i_logger.dart';
import 'package:commons_observability/api/i_metrics.dart';
import 'package:commons_observability/api/i_observability.dart';
import 'package:commons_observability/api/i_tracer.dart';
import 'package:commons_observability/model/log_event.dart';
import 'package:commons_observability/model/log_level.dart';
import 'package:commons_observability/vendor/i_vendor_provider.dart';

class ObservabilityImpl implements IObservability {
  ObservabilityImpl({
    required IVendorProvider vendor,
    LogLevel minLogLevel = LogLevel.info,
    Set<String> piiKeys = const {
      'password',
      'token',
      'authorization',
      'email',
      'phone',
      'user_id',
      'cpf',
      'secret',
    },
  })  : logger = _LoggerImpl(vendor, minLogLevel, piiKeys),
        tracer = _TracerImpl(vendor),
        metrics = const _MetricsImpl(),
        _vendor = vendor;

  @override
  final ILogger logger;

  @override
  final ITracer tracer;

  @override
  final IMetrics metrics;

  final IVendorProvider _vendor;

  @override
  void setUserIdentifier(String hashedId) => _vendor.setUserIdentifier(hashedId);

  @override
  void setCustomKey(String key, Object value) => _vendor.setCustomKey(key, value);

  @override
  void setCollectionEnabled(bool enabled) => _vendor.setCollectionEnabled(enabled);
}

// ---------------------------------------------------------------------------
// Logger
// ---------------------------------------------------------------------------

class _LoggerImpl implements ILogger {
  const _LoggerImpl(this._vendor, this._minLevel, this._piiKeys);

  final IVendorProvider _vendor;
  final LogLevel _minLevel;
  final Set<String> _piiKeys;

  @override
  void log(
    LogLevel level,
    String event, {
    Map<String, Object?> attributes = const {},
    Object? throwable,
    StackTrace? stackTrace,
  }) {
    if (level < _minLevel) return;

    final sanitized = _sanitize(attributes);
    final logEvent = LogEvent(
      level: level,
      event: event,
      attributes: sanitized,
      throwable: throwable,
      stackTrace: stackTrace,
    );

    if (level >= LogLevel.error) {
      _vendor.recordError(logEvent);
    } else {
      _vendor.log(logEvent);
    }
  }

  @override
  void debug(String event, {Map<String, Object?> attributes = const {}}) =>
      log(LogLevel.debug, event, attributes: attributes);

  @override
  void info(String event, {Map<String, Object?> attributes = const {}}) =>
      log(LogLevel.info, event, attributes: attributes);

  @override
  void warn(String event, {Map<String, Object?> attributes = const {}}) =>
      log(LogLevel.warn, event, attributes: attributes);

  @override
  void error(
    String event, {
    Map<String, Object?> attributes = const {},
    Object? throwable,
    StackTrace? stackTrace,
  }) =>
      log(LogLevel.error, event, attributes: attributes, throwable: throwable, stackTrace: stackTrace);

  @override
  void fatal(
    String event, {
    Map<String, Object?> attributes = const {},
    Object? throwable,
    StackTrace? stackTrace,
  }) =>
      log(LogLevel.fatal, event, attributes: attributes, throwable: throwable, stackTrace: stackTrace);

  Map<String, Object?> _sanitize(Map<String, Object?> attributes) {
    return Map.fromEntries(
      attributes.entries
          .where((e) => !_piiKeys.any((pii) => e.key.toLowerCase().contains(pii)))
          .map((e) {
            final v = e.value;
            final truncated = v is String ? v.substring(0, v.length.clamp(0, 512)) : v;
            return MapEntry(e.key, truncated);
          }),
    );
  }
}

// ---------------------------------------------------------------------------
// Tracer — no-op (Crashlytics has no APM/distributed tracing)
// ---------------------------------------------------------------------------

class _TracerImpl implements ITracer {
  const _TracerImpl(this._vendor);

  final IVendorProvider _vendor;

  @override
  T trace<T>(
    String name, {
    Map<String, Object?> attributes = const {},
    required T Function() block,
  }) {
    final handle = _vendor.startSpan(name, attributes);
    try {
      return block();
    } catch (e) {
      _vendor.markSpanError(handle, e);
      rethrow;
    } finally {
      _vendor.finishSpan(handle);
    }
  }

  @override
  SpanHandle startSpan(String name, {Map<String, Object?> attributes = const {}}) =>
      _vendor.startSpan(name, attributes);

  @override
  void finishSpan(SpanHandle handle) => _vendor.finishSpan(handle);
}

// ---------------------------------------------------------------------------
// Metrics — no-op (Crashlytics has no metric aggregation)
// ---------------------------------------------------------------------------

class _MetricsImpl implements IMetrics {
  const _MetricsImpl();

  @override
  void counter(String name, {double value = 1.0, Map<String, String> tags = const {}}) {
    // No-op: Crashlytics does not support metric counters.
  }

  @override
  void gauge(String name, {required double value, Map<String, String> tags = const {}}) {
    // No-op: Crashlytics does not support gauge metrics.
  }

  @override
  void histogram(String name, {required double value, Map<String, String> tags = const {}}) {
    // No-op: Crashlytics does not support histogram metrics.
  }
}
