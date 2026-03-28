import 'package:commons_security/data/model/token_dto.dart';

abstract class ISecurityLocalDataSource {
  Future<TokenDto?> fetchToken();

  /// Saves [dto] locally. If [dto] is null, clears the stored token.
  Future<void> saveToken(TokenDto? dto);
}
