import 'package:commons_infra/failures/app_failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ICpfValidator {
  Either<Failure, String> validate(String value);
}
