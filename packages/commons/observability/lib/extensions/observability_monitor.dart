import 'package:commons_observability/api/i_observability.dart';
import 'package:commons_observability/model/log_level.dart';

extension ObservabilityMonitor on IObservability {
  /// Wraps [block] with a full observability envelope:
  /// - trace span (no-op on Crashlytics)
  /// - duration histogram (no-op on Crashlytics)
  /// - success / error counters (no-op on Crashlytics)
  /// - structured log at INFO on success, ERROR on failure
  ///
  /// Usage:
  /// ```dart
  /// observability.monitor('catalog.list') {
  ///   productRepository.fetchProducts()
  /// }
  /// ```
  T monitor<T>(
    String operation, {
    Map<String, Object?> attributes = const {},
    required T Function() block,
  }) {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    final span = tracer.startSpan(operation, attributes: attributes);

    try {
      final result = block();
      final duration = DateTime.now().millisecondsSinceEpoch - startTime;

      metrics.histogram('$operation.duration', value: duration.toDouble());
      metrics.counter('$operation.success');
      logger.log(LogLevel.info, '$operation.success', attributes: attributes);

      tracer.finishSpan(span);
      return result;
    } catch (e, st) {
      final duration = DateTime.now().millisecondsSinceEpoch - startTime;

      metrics.histogram('$operation.duration', value: duration.toDouble());
      metrics.counter('$operation.error');
      logger.error(
        '$operation.failed',
        attributes: {
          ...attributes,
          'errorMessage': e.toString(),
          'exceptionType': e.runtimeType.toString(),
        },
        throwable: e,
        stackTrace: st,
      );

      tracer.finishSpan(span);
      rethrow;
    }
  }
}
