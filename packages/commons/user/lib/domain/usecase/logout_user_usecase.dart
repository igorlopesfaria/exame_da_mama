import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_user/domain/repository/i_user_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUserUseCase {
  const LogoutUserUseCase(this._localRepository);

  final IUserLocalRepository _localRepository;

  Future<Either<Failure, Unit>> call() => _localRepository.clearUser();
}
