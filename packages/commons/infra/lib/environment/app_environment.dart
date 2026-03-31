abstract final class AppEnvironment {
  static const String name =
      String.fromEnvironment('ENVIRONMENT', defaultValue: 'mock');

  static const String baseUrl =
      String.fromEnvironment('URL_BASE', defaultValue: '');

  static void validate() {
    if (baseUrl.isEmpty) {
      throw StateError('URL_BASE is not set. Run with --dart-define-from-file=env/<environment>.json');
    }
  }

  static bool get isMock => name == 'mock';
  static bool get isStaging => name == 'staging';
  static bool get isProd => name == 'prod';
}
