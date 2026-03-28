import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class IUserLocalRepository {
  Future<Either<Failure, User?>> loadUser();
  Future<Either<Failure, Unit>> saveUser(User user);
  Future<Either<Failure, Unit>> clearUser();
}
