sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({required this.errorCode})
      : super(errorCode);
  final String errorCode;
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure([super.message = 'Too many requests']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

class ParseFailure extends Failure {
  const ParseFailure([super.message = 'Failed to parse response']);
}
