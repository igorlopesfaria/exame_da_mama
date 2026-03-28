import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  const LogoutUseCase(this._localRepository);

  final ISecurityLocalRepository _localRepository;

  Future<Either<Failure, Unit>> call() => _localRepository.saveToken(null);
}
