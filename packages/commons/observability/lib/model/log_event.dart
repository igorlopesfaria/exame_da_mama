import 'package:commons_observability/model/log_level.dart';

class LogEvent {
  LogEvent({
    required this.level,
    required this.event,
    required this.attributes,
    this.throwable,
    this.stackTrace,
  }) : timestampMs = DateTime.now().millisecondsSinceEpoch;

  final LogLevel level;
  final String event;
  final Map<String, Object?> attributes;
  final Object? throwable;
  final StackTrace? stackTrace;
  final int timestampMs;
}
