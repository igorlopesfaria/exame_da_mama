sealed class AppException implements Exception {
  const AppException({this.code, required this.message});
  final String? code;
  final String message;
}

class NetworkException extends AppException {
  const NetworkException([String message = 'No internet connection'])
      : super(message: message);
}

class ServerException extends AppException {
  const ServerException({this.statusCode, required super.message});
  final int? statusCode;
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String message = 'Unauthorized'])
      : super(message: message);
}

class NotFoundException extends AppException {
  const NotFoundException([String message = 'Resource not found'])
      : super(message: message);
}

class ParseException extends AppException {
  const ParseException([String message = 'Failed to parse response'])
      : super(message: message);
}
