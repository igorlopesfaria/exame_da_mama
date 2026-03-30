import 'package:commons_observability/api/i_logger.dart';
import 'package:commons_observability/api/i_metrics.dart';
import 'package:commons_observability/api/i_tracer.dart';

/// Single access point to all observability functionality.
/// Feature modules depend only on this interface — no vendor types leak out.
abstract interface class IObservability {
  ILogger get logger;
  ITracer get tracer;
  IMetrics get metrics;

  /// Sets a stable user identifier for crash correlation.
  /// Must be hashed — never a raw email or username.
  void setUserIdentifier(String hashedId);

  /// Sets a persistent key-value pair attached to all subsequent reports.
  /// Use for session context, app variant, or feature flags.
  void setCustomKey(String key, Object value);
}
