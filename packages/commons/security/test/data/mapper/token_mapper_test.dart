import 'package:commons_security/data/mapper/token_mapper.dart';
import 'package:commons_security/data/model/token_dto.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tDto = TokenDto(
    accessToken:  'access-abc',
    refreshToken: 'refresh-xyz',
  );

  const tToken = Token(
    accessToken:  'access-abc',
    refreshToken: 'refresh-xyz',
  );

  group('TokenMapper.dtoToToken', () {
    test('maps all fields correctly', () {
      final token = TokenMapper.dtoToToken(tDto);

      expect(token.accessToken,  tDto.accessToken);
      expect(token.refreshToken, tDto.refreshToken);
    });
  });

  group('TokenMapper.tokenToDto', () {
    test('maps all fields correctly', () {
      final dto = TokenMapper.tokenToDto(tToken);

      expect(dto.accessToken,  tToken.accessToken);
      expect(dto.refreshToken, tToken.refreshToken);
    });
  });

  group('round-trip', () {
    test('dtoToToken → tokenToDto preserves all fields', () {
      final token = TokenMapper.dtoToToken(tDto);
      final dto   = TokenMapper.tokenToDto(token);

      expect(dto.accessToken,  tDto.accessToken);
      expect(dto.refreshToken, tDto.refreshToken);
    });
  });
}
