import 'package:commons_user/data/model/user_dto.dart';

abstract class IUserRemoteDataSource {
  Future<UserDto> fetchUserById(String userId);
}
