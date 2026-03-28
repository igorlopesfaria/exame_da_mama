import 'package:commons_infra/http/i_http_client.dart';
import 'package:commons_user/data/datasource/remote/i_user_remote_datasource.dart';
import 'package:commons_user/data/model/user_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserRemoteDataSource)
class UserRemoteDataSource implements IUserRemoteDataSource {
  const UserRemoteDataSource(this._httpClient);

  final IHttpClient _httpClient;

  @override
  Future<UserDto> fetchUserById(String userId) async {
    final json = await _httpClient.get('/users/$userId');
    return UserDto.fromJson(json);
  }
}
