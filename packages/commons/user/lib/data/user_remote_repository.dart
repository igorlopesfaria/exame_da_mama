import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/repository/base_repository.dart';
import 'package:commons_user/data/datasource/remote/i_user_remote_datasource.dart';
import 'package:commons_user/data/mapper/user_mapper.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:commons_user/domain/repository/i_user_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserRemoteRepository)
class UserRemoteRepository extends BaseRepository implements IUserRemoteRepository {

  UserRemoteRepository(this._dataSource);

  final IUserRemoteDataSource _dataSource;

  @override
  Future<Either<Failure, User>> loadUserById(String userId) =>
      safeCall(() async {
        final dto = await _dataSource.fetchUserById(userId);
        return UserMapper.dtoToUser(dto);
      });
}
