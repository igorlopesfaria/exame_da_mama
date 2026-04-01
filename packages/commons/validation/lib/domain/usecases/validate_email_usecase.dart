import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/repositories/i_validation_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidateEmailUseCase {
  const ValidateEmailUseCase(this._repository, this._observability);

  final IValidationRepository _repository;
  final IObservability _observability;

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  Future<Either<Failure, String>> call(
    String value, {
    bool checkRemote = false,
  }) async {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      _observability.logger.error(
        'validation.email.failed',
        attributes: {'failureType': 'RequiredField'},
      );
      return const Left(RequiredField());
    }

    if (!_emailRegex.hasMatch(trimmed)) {
      _observability.logger.error(
        'validation.email.failed',
        attributes: {'failureType': 'InvalidFormat'},
      );
      return const Left(InvalidFormat());
    }

    if (!checkRemote) {
      _observability.logger.info('validation.email.success');
      return Right(trimmed);
    }

    final remoteResult = await _repository.validateEmail(trimmed);
    return remoteResult.fold(
      (failure) {
        _observability.logger.error(
          'validation.email.failed',
          attributes: {'failureType': failure.runtimeType.toString()},
        );
        return Left(failure);
      },
      (_) {
        _observability.logger.info('validation.email.success');
        return Right(trimmed);
      },
    );
  }
}
