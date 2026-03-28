import 'package:commons_infra/http/i_http_client.dart';
import 'package:commons_security/data/datasource/remote/i_security_remote_datasource.dart';
import 'package:commons_security/data/model/token_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ISecurityRemoteDataSource)
class SecurityRemoteDataSource implements ISecurityRemoteDataSource {
  const SecurityRemoteDataSource(this._httpClient);

  final IHttpClient _httpClient;

  @override
  Future<TokenDto> authenticate(String cpf, String password) async {
    final json = await _httpClient.post(
      '/auth/login',
      data: {'cpf': cpf, 'password': password},
    );
    return TokenDto.fromJson(json);
  }
}
