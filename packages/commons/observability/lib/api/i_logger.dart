import 'package:commons_observability/model/log_level.dart';

abstract interface class ILogger {
  void log(
    LogLevel level,
    String event, {
    Map<String, Object?> attributes = const {},
    Object? throwable,
    StackTrace? stackTrace,
  });

  void verbose(String event, {Map<String, Object?> attributes = const {}});

  void debug(String event, {Map<String, Object?> attributes = const {}});

  void info(String event, {Map<String, Object?> attributes = const {}});

  void warn(String event, {Map<String, Object?> attributes = const {}});

  void error(
    String event, {
    Map<String, Object?> attributes = const {},
    Object? throwable,
    StackTrace? stackTrace,
  });

  void fatal(
    String event, {
    Map<String, Object?> attributes = const {},
    Object? throwable,
    StackTrace? stackTrace,
  });
}
