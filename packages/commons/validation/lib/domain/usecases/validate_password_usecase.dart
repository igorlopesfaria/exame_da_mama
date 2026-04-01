import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Indicates the strength of a validated password.
///
/// - [weak]   — meets only the minimum requirements (≥8 chars, 1 uppercase,
///              1 digit, 1 special character).
/// - [medium] — meets minimum requirements AND length ≥ 12.
/// - [strong] — meets minimum requirements AND (length ≥ 16, OR all character
///              categories present with length ≥ 12).
enum PasswordStrength { weak, medium, strong }

@injectable
class ValidatePasswordUseCase {
  const ValidatePasswordUseCase(this._observability);

  final IObservability _observability;

  static final _uppercase = RegExp(r'[A-Z]');
  static final _lowercase = RegExp(r'[a-z]');
  static final _digit = RegExp(r'[0-9]');
  static final _special = RegExp(r'[!@#$%^&*()\-_=+\[\]{};:,.<>?/\\|`~"' "'" r'@]');

  Either<Failure, PasswordStrength> call(String value) {
    if (value.isEmpty) {
      _observability.logger.error(
        'validation.password.failed',
        attributes: {'failureType': 'RequiredField'},
      );
      return const Left(RequiredField());
    }

    final meetsMinimum = value.length >= 8 &&
        _uppercase.hasMatch(value) &&
        _digit.hasMatch(value) &&
        _special.hasMatch(value);

    if (!meetsMinimum) {
      _observability.logger.error(
        'validation.password.failed',
        attributes: {'failureType': 'InvalidFormat'},
      );
      return const Left(InvalidFormat());
    }

    final strength = _computeStrength(value);
    _observability.logger.info(
      'validation.password.success',
      attributes: {'strength': strength.name},
    );
    return Right(strength);
  }

  static PasswordStrength _computeStrength(String value) {
    final hasAllCategories = _uppercase.hasMatch(value) &&
        _lowercase.hasMatch(value) &&
        _digit.hasMatch(value) &&
        _special.hasMatch(value);

    if (value.length >= 16 || (hasAllCategories && value.length >= 12)) {
      return PasswordStrength.strong;
    }
    if (value.length >= 12) return PasswordStrength.medium;
    return PasswordStrength.weak;
  }
}
