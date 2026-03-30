import 'package:commons_observability/api/i_tracer.dart';
import 'package:commons_observability/model/log_event.dart';
import 'package:commons_observability/model/log_level.dart';
import 'package:commons_observability/vendor/i_vendor_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Crashlytics does not support distributed tracing or metrics.
/// This handle is a no-op placeholder to satisfy the [ITracer] contract.
class _NoOpSpanHandle implements SpanHandle {
  const _NoOpSpanHandle();
}

/// Maps the observability API to Firebase Crashlytics.
///
/// What Crashlytics supports:
///   ✅ log()              → breadcrumb messages visible in crash reports
///   ✅ recordError()      → non-fatal and fatal error reporting with stack trace
///   ✅ setCustomKey()     → persistent key-value context on every report
///   ✅ setUserIdentifier()→ hashed user ID for crash correlation
///   ❌ Traces / spans     → no-op (Crashlytics has no APM tracing)
///   ❌ Metrics            → no-op (Crashlytics has no metric aggregation)
class CrashlyticsProvider implements IVendorProvider {
  const CrashlyticsProvider(this._crashlytics);

  final FirebaseCrashlytics _crashlytics;

  @override
  void log(LogEvent event) {
    final buffer = StringBuffer('[${event.level.name.toUpperCase()}] ${event.event}');
    if (event.attributes.isNotEmpty) {
      final attrs = event.attributes.entries.map((e) => '${e.key}=${e.value}').join(', ');
      buffer.write(' | $attrs');
    }
    _crashlytics.log(buffer.toString());
  }

  @override
  void recordError(LogEvent event) {
    final information = event.attributes.entries
        .map((e) => '${e.key}: ${e.value}')
        .toList();

    _crashlytics.recordError(
      event.throwable ?? event.event,
      event.stackTrace,
      reason: event.event,
      information: information,
      fatal: event.level == LogLevel.fatal,
      printDetails: false,
    );
  }

  @override
  SpanHandle startSpan(String name, Map<String, Object?> attributes) {
    return const _NoOpSpanHandle();
  }

  @override
  void finishSpan(SpanHandle handle) {
    // No-op: Crashlytics does not support APM spans.
  }

  @override
  void markSpanError(SpanHandle handle, Object throwable) {
    // No-op: errors are reported via recordError().
  }

  @override
  void setUserIdentifier(String hashedId) {
    _crashlytics.setUserIdentifier(hashedId);
  }

  @override
  void setCustomKey(String key, Object value) {
    switch (value) {
      case final String v:
        _crashlytics.setCustomKey(key, v);
      case final int v:
        _crashlytics.setCustomKey(key, v);
      case final double v:
        _crashlytics.setCustomKey(key, v);
      case final bool v:
        _crashlytics.setCustomKey(key, v);
      default:
        _crashlytics.setCustomKey(key, value.toString());
    }
  }
}
