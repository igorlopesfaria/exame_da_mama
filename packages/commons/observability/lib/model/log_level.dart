enum LogLevel {
  verbose,
  debug,
  info,
  warn,
  error,
  fatal;

  bool operator >=(LogLevel other) => index >= other.index;
}
