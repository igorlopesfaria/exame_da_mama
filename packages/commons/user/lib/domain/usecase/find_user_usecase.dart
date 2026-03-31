import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
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
    this._observability,
  );

  final IUserRemoteRepository _remoteRepository;
  final IUserLocalRepository _localRepository;
  final IObservability _observability;

  Future<Either<Failure, User>> call(String userId) async {
    final remoteResult = await _remoteRepository.loadUserById(userId);

    return remoteResult.fold(
      (failure) async {
        final localResult = await _localRepository.loadUser();
        return localResult.fold(
          (_) {
            _observability.logger.error(
              'user.find.failed',
              attributes: {'failureType': failure.runtimeType.toString()},
            );
            return Left(failure);
          },
          (user) {
            if (user != null) {
              _observability.logger.info(
                'user.find.success',
                attributes: {'source': 'local_cache'},
              );
              return Right(user);
            }
            _observability.logger.error(
              'user.find.failed',
              attributes: {'failureType': failure.runtimeType.toString()},
            );
            return Left(failure);
          },
        );
      },
      (user) async {
        await _localRepository.saveUser(user);
        _observability.logger.info(
          'user.find.success',
          attributes: {'source': 'remote'},
        );
        return Right(user);
      },
    );
  }
}
