import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/repository/base_repository.dart';
import 'package:commons_user/data/datasource/local/i_user_local_datasource.dart';
import 'package:commons_user/data/mapper/user_mapper.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:commons_user/domain/repository/i_user_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserLocalRepository)
class UserLocalRepository extends BaseRepository implements IUserLocalRepository {
  UserLocalRepository(this._dataSource);

  final IUserLocalDataSource _dataSource;

  @override
  Future<Either<Failure, User?>> loadUser() =>
      safeCall(() async {
        final dto = await _dataSource.fetchUser();
        return dto == null ? null : UserMapper.dtoToUser(dto);
      });

  @override
  Future<Either<Failure, Unit>> saveUser(User user) =>
      safeCall(() async {
        await _dataSource.saveUser(UserMapper.userToDto(user));
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> clearUser() =>
      safeCall(() async {
        await _dataSource.clearUser();
        return unit;
      });
}
