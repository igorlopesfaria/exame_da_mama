import 'package:commons_user/data/model/user_dto.dart';

abstract class IUserLocalDataSource {
  Future<UserDto?> fetchUser();
  Future<void> saveUser(UserDto dto);
  Future<void> clearUser();
}
