/// Opaque handle for a span lifecycle. Provider-owned and type-safe.
abstract interface class SpanHandle {}

abstract interface class ITracer {
  /// Wraps [block] in a trace span. The span always finishes even on exception.
  T trace<T>(
    String name, {
    Map<String, Object?> attributes = const {},
    required T Function() block,
  });

  /// Starts a span manually. Must be paired with [finishSpan].
  /// Use this for long-lived operations that span multiple callbacks.
  SpanHandle startSpan(String name, {Map<String, Object?> attributes = const {}});

  void finishSpan(SpanHandle handle);
}
