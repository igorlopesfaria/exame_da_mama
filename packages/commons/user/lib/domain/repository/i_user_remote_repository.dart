import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class IUserRemoteRepository {
  Future<Either<Failure, User>> loadUserById(String userId);
}
