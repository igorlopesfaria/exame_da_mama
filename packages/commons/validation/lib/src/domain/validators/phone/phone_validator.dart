import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_validation/src/domain/failures/validation_failure.dart';
import 'package:commons_validation/src/domain/validators/phone/i_phone_validator.dart';
import 'package:fpdart/fpdart.dart';

class PhoneValidator implements IPhoneValidator {
  const PhoneValidator();

  static final _digitsOnly = RegExp(r'\D');

  @override
  Either<Failure, String> validate(String value) {
    if (value.trim().isEmpty) return const Left(RequiredField());

    final digits = value.replaceAll(_digitsOnly, '');

    if (digits.length != 10 && digits.length != 11) {
      return const Left(InvalidFormat());
    }

    return Right(digits);
  }
}
