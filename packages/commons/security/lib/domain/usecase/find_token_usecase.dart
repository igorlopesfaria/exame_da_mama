import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class FindTokenUseCase {
  const FindTokenUseCase(this._localRepository);

  final ISecurityLocalRepository _localRepository;

  Future<Either<Failure, Token?>> call() => _localRepository.findToken();
}
