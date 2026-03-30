import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  const LogoutUseCase(this._localRepository, this._observability);

  final ISecurityLocalRepository _localRepository;
  final IObservability _observability;

  Future<Either<Failure, Unit>> call() async {
    final result = await _localRepository.saveToken(null);
    result.fold(
      (failure) => _observability.logger.error(
        'auth.logout.failed',
        attributes: {'failureType': failure.runtimeType.toString()},
      ),
      (_) => _observability.logger.info('auth.logout.success'),
    );
    return result;
  }
}
