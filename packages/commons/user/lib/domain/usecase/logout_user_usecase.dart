import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_user/domain/repository/i_user_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUserUseCase {
  const LogoutUserUseCase(this._localRepository, this._observability);

  final IUserLocalRepository _localRepository;
  final IObservability _observability;

  Future<Either<Failure, Unit>> call() async {
    final result = await _localRepository.clearUser();
    result.fold(
      (failure) => _observability.logger.error(
        'user.logout.failed',
        attributes: {'failureType': failure.runtimeType.toString()},
      ),
      (_) => _observability.logger.info('user.logout.success'),
    );
    return result;
  }
}
