import 'package:commons_infra/failures/app_failures.dart';

final class InvalidFormat extends Failure {
  const InvalidFormat() : super('Invalid format');
}

final class RequiredField extends Failure {
  const RequiredField() : super('Required field');
}

/// Returned when the value is already registered (online check only).
final class AlreadyInUse extends Failure {
  const AlreadyInUse() : super('Already in use');
}

/// Returned when the remote validation call fails (online check only).
final class ServerError extends Failure {
  const ServerError() : super('Server error');
}
