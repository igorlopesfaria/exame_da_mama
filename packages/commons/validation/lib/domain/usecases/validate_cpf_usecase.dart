import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/repositories/i_validation_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidateCpfUseCase {
  const ValidateCpfUseCase(this._repository, this._observability);

  final IValidationRepository _repository;
  final IObservability _observability;

  static final _digitsOnly = RegExp(r'\D');

  Future<Either<Failure, String>> call(
    String value, {
    bool checkRemote = false,
  }) async {
    if (value.trim().isEmpty) {
      _observability.logger.error(
        'validation.cpf.failed',
        attributes: {'failureType': 'RequiredField'},
      );
      return const Left(RequiredField());
    }

    final digits = value.replaceAll(_digitsOnly, '');

    if (!_isValidCpf(digits)) {
      _observability.logger.error(
        'validation.cpf.failed',
        attributes: {'failureType': 'InvalidFormat'},
      );
      return const Left(InvalidFormat());
    }

    if (!checkRemote) {
      _observability.logger.info('validation.cpf.success');
      return Right(digits);
    }

    final remoteResult = await _repository.validateCpf(digits);
    return remoteResult.fold(
      (failure) {
        _observability.logger.error(
          'validation.cpf.failed',
          attributes: {'failureType': failure.runtimeType.toString()},
        );
        return Left(failure);
      },
      (_) {
        _observability.logger.info('validation.cpf.success');
        return Right(digits);
      },
    );
  }

  /// Official Brazilian two-digit CPF verification algorithm.
  static bool _isValidCpf(String digits) {
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
