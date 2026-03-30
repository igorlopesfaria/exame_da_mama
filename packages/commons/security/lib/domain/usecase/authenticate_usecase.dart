import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:commons_security/domain/repository/i_security_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthenticateUseCase {
  const AuthenticateUseCase(
    this._remoteRepository,
    this._localRepository,
    this._observability,
  );

  final ISecurityRemoteRepository _remoteRepository;
  final ISecurityLocalRepository _localRepository;
  final IObservability _observability;

  Future<Either<Failure, Token>> call(String cpf, String password) async {
    final result = await _remoteRepository.authenticate(cpf, password);

    return result.fold(
      (failure) {
        _observability.logger.error(
          'auth.authenticate.failed',
          attributes: {'failureType': failure.runtimeType.toString()},
        );
        return Left(failure);
      },
      (token) async {
        await _localRepository.saveToken(token);
        _observability.logger.info('auth.authenticate.success');
        return Right(token);
      },
    );
  }
}
