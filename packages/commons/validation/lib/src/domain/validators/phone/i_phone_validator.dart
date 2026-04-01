import 'package:commons_infra/failures/app_failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IPhoneValidator {
  Either<Failure, String> validate(String value);
}
