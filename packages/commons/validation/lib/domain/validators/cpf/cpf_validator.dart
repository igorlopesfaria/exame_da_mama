import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/validators/cpf/i_cpf_validator.dart';
import 'package:fpdart/fpdart.dart';

class CpfValidator implements ICpfValidator {
  const CpfValidator();

  static final _digitsOnly = RegExp(r'\D');

  @override
  Either<Failure, String> validate(String value) {
    if (value.trim().isEmpty) return const Left(RequiredField());

    final digits = value.replaceAll(_digitsOnly, '');

    if (!_isValid(digits)) return const Left(InvalidFormat());

    return Right(digits);
  }

  /// Implements the official Brazilian two-digit CPF verification algorithm.
  static bool _isValid(String digits) {
    if (digits.length != 11) return false;

    // Reject sequences of identical digits (e.g. 000.000.000-00)
    if (digits.split('').toSet().length == 1) return false;

    // First check digit
    var sum = 0;
    for (var i = 0; i < 9; i++) {
      sum += int.parse(digits[i]) * (10 - i);
    }
    var remainder = sum % 11;
    final firstDigit = remainder < 2 ? 0 : 11 - remainder;
    if (firstDigit != int.parse(digits[9])) return false;

    // Second check digit
    sum = 0;
    for (var i = 0; i < 10; i++) {
      sum += int.parse(digits[i]) * (11 - i);
    }
    remainder = sum % 11;
    final secondDigit = remainder < 2 ? 0 : 11 - remainder;
    if (secondDigit != int.parse(digits[10])) return false;

    return true;
  }
}
