import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/repositories/i_validation_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidatePhoneUseCase {
  const ValidatePhoneUseCase(this._repository, this._observability);

  final IValidationRepository _repository;
  final IObservability _observability;

  static final _digitsOnly = RegExp(r'\D');

  Future<Either<Failure, String>> call(
    String value, {
    bool checkRemote = false,
  }) async {
    if (value.trim().isEmpty) {
      _observability.logger.error(
        'validation.phone.failed',
        attributes: {'failureType': 'RequiredField'},
      );
      return const Left(RequiredField());
    }

    final digits = value.replaceAll(_digitsOnly, '');

    if (digits.length != 10 && digits.length != 11) {
      _observability.logger.error(
        'validation.phone.failed',
        attributes: {'failureType': 'InvalidFormat'},
      );
      return const Left(InvalidFormat());
    }

    if (!checkRemote) {
      _observability.logger.info('validation.phone.success');
      return Right(digits);
    }

    final remoteResult = await _repository.validatePhone(digits);
    return remoteResult.fold(
      (failure) {
        _observability.logger.error(
          'validation.phone.failed',
          attributes: {'failureType': failure.runtimeType.toString()},
        );
        return Left(failure);
      },
      (_) {
        _observability.logger.info('validation.phone.success');
        return Right(digits);
      },
    );
  }
}
