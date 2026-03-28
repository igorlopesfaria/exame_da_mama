import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_security/data/model/token_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validJson = <String, dynamic>{
    'access_token':  'access-abc',
    'refresh_token': 'refresh-xyz',
  };

  group('TokenDto.fromJson', () {
    test('parses all fields correctly', () {
      final dto = TokenDto.fromJson(validJson);

      expect(dto.accessToken,  'access-abc');
      expect(dto.refreshToken, 'refresh-xyz');
    });

    for (final field in ['access_token', 'refresh_token']) {
      test('throws ParseException when "$field" is missing', () {
        final json = Map<String, dynamic>.from(validJson)..remove(field);
        expect(() => TokenDto.fromJson(json), throwsA(isA<ParseException>()));
      });

      test('throws ParseException when "$field" is empty string', () {
        final json = Map<String, dynamic>.from(validJson)..[field] = '';
        expect(() => TokenDto.fromJson(json), throwsA(isA<ParseException>()));
      });
    }
  });

  group('TokenDto.toJson', () {
    test('serializes all fields correctly', () {
      const dto = TokenDto(
        accessToken:  'access-abc',
        refreshToken: 'refresh-xyz',
      );

      expect(dto.toJson(), validJson);
    });

    test('fromJson and toJson are inverse operations', () {
      final dto = TokenDto.fromJson(validJson);
      expect(dto.toJson(), validJson);
    });
  });
}
