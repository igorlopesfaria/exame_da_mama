import 'package:commons_observability/api/i_tracer.dart';
import 'package:commons_observability/model/log_event.dart';

/// Contract that every vendor SDK implementation must satisfy.
/// No vendor types leak beyond this boundary.
abstract interface class IVendorProvider {
  /// Sends a structured log entry (non-error).
  void log(LogEvent event);

  /// Reports an error or fatal crash with full context.
  void recordError(LogEvent event);

  /// Starts an instrumented span. Returns an opaque [SpanHandle].
  SpanHandle startSpan(String name, Map<String, Object?> attributes);

  /// Finishes the span identified by [handle].
  void finishSpan(SpanHandle handle);

  /// Marks a span as failed due to [throwable].
  void markSpanError(SpanHandle handle, Object throwable);

  /// Sets a stable user identifier for correlation.
  void setUserIdentifier(String hashedId);

  /// Sets a persistent key-value attribute on all subsequent reports.
  void setCustomKey(String key, Object value);

  /// Enables or disables crash report collection.
  /// Should be disabled in mock/debug environments to avoid polluting dashboards.
  void setCollectionEnabled(bool enabled);
}
