/// Typed fallback exception used when [ILogger.error] / [ILogger.fatal]
/// is called without a [throwable]. Ensures Crashlytics groups reports
/// by a meaningful type instead of displaying a bare String as the exception.
class ObservabilityError implements Exception {
  const ObservabilityError(this.event);

  final String event;

  @override
  String toString() => 'ObservabilityError: $event';
}
