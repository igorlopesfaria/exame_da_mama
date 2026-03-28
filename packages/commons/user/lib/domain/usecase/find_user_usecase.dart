import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:commons_user/domain/repository/i_user_local_repository.dart';
import 'package:commons_user/domain/repository/i_user_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class FindUserUseCase {
  const FindUserUseCase(
    this._remoteRepository,
    this._localRepository,
  );

  final IUserRemoteRepository _remoteRepository;
  final IUserLocalRepository _localRepository;

  Future<Either<Failure, User>> call(String userId) async {
    final remoteResult = await _remoteRepository.loadUserById(userId);

    return remoteResult.fold(
      (failure) async {
        final localResult = await _localRepository.loadUser();
        return localResult.fold(
          (_) => Left(failure),
          (user) => user != null ? Right(user) : Left(failure),
        );
      },
      (user) async {
        await _localRepository.saveUser(user);
        return Right(user);
      },
    );
  }
}
