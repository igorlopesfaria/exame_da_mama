import 'package:commons_infra/failures/app_failures.dart';
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
  );

  final ISecurityRemoteRepository _remoteRepository;
  final ISecurityLocalRepository _localRepository;

  Future<Either<Failure, Token>> call(String cpf, String password) async {
    final result = await _remoteRepository.authenticate(cpf, password);

    return result.fold(
      Left.new,
      (token) async {
        await _localRepository.saveToken(token);
        return Right(token);
      },
    );
  }
}
