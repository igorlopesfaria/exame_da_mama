import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_validation/src/domain/failures/validation_failure.dart';
import 'package:commons_validation/src/domain/validators/email/i_email_validator.dart';
import 'package:fpdart/fpdart.dart';

class EmailValidator implements IEmailValidator {
  const EmailValidator();

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Either<Failure, String> validate(String value) {
    if (value.trim().isEmpty) return const Left(RequiredField());
    if (!_emailRegex.hasMatch(value.trim())) return const Left(InvalidFormat());
    return Right(value.trim());
  }
}
