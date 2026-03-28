import 'package:commons_security/data/model/token_dto.dart';

abstract class ISecurityRemoteDataSource {
  Future<TokenDto> authenticate(String cpf, String password);
}
