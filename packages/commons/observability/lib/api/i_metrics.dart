abstract interface class IMetrics {
  /// Increments a counter metric. Use for discrete events (success, error, etc).
  void counter(String name, {double value = 1.0, Map<String, String> tags = const {}});

  /// Records a point-in-time value. Use for queue size, active connections, etc.
  void gauge(String name, {required double value, Map<String, String> tags = const {}});

  /// Records a distribution value. Use for latency, request duration, payload size.
  void histogram(String name, {required double value, Map<String, String> tags = const {}});
}
