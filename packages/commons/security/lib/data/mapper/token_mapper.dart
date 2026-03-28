import 'package:commons_security/data/model/token_dto.dart';
import 'package:commons_security/domain/model/token.dart';

abstract final class TokenMapper {
  static Token dtoToToken(TokenDto dto) => Token(
        accessToken:  dto.accessToken,
        refreshToken: dto.refreshToken,
      );

  static TokenDto tokenToDto(Token token) => TokenDto(
        accessToken:  token.accessToken,
        refreshToken: token.refreshToken,
      );
}
