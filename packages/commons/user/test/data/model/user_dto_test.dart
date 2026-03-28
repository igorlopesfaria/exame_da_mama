import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_user/data/model/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validJson = <String, dynamic>{
    'id':        '1',
    'cpf':       '12345678901',
    'name':      'Test User',
    'birthdate': '1990-01-01',
    'gender':    'female',
    'email':     'test@test.com',
    'phone':     '11999999999',
  };

  group('UserDto.fromJson', () {
    test('parses all fields correctly', () {
      final dto = UserDto.fromJson(validJson);

      expect(dto.id,        '1');
      expect(dto.cpf,       '12345678901');
      expect(dto.name,      'Test User');
      expect(dto.birthdate, '1990-01-01');
      expect(dto.gender,    'female');
      expect(dto.email,     'test@test.com');
      expect(dto.phone,     '11999999999');
    });

    for (final field in ['id', 'cpf', 'name', 'birthdate', 'gender', 'email', 'phone']) {
      test('throws ParseException when "$field" is missing', () {
        final json = Map<String, dynamic>.from(validJson)..remove(field);
        expect(() => UserDto.fromJson(json), throwsA(isA<ParseException>()));
      });

      test('throws ParseException when "$field" is empty string', () {
        final json = Map<String, dynamic>.from(validJson)..[field] = '';
        expect(() => UserDto.fromJson(json), throwsA(isA<ParseException>()));
      });
    }
  });

  group('UserDto.toJson', () {
    test('serializes all fields correctly', () {
      const dto = UserDto(
        id:        '1',
        cpf:       '12345678901',
        name:      'Test User',
        birthdate: '1990-01-01',
        gender:    'female',
        email:     'test@test.com',
        phone:     '11999999999',
      );

      expect(dto.toJson(), validJson);
    });

    test('fromJson and toJson are inverse operations', () {
      final dto = UserDto.fromJson(validJson);
      expect(dto.toJson(), validJson);
    });
  });
}
