import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_user/data/mapper/user_mapper.dart';
import 'package:commons_user/data/model/user_dto.dart';
import 'package:commons_user/domain/model/gender.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tDto = UserDto(
    id:        '1',
    cpf:       '12345678901',
    name:      'Test User',
    birthdate: '1990-01-01',
    gender:    'female',
    email:     'test@test.com',
    phone:     '11999999999',
  );

  const tUser = User(
    id:        '1',
    cpf:       '12345678901',
    name:      'Test User',
    birthdate: '1990-01-01',
    gender:    Gender.female,
    email:     'test@test.com',
    phone:     '11999999999',
  );

  group('UserMapper.dtoToUser', () {
    test('maps all fields correctly', () {
      final user = UserMapper.dtoToUser(tDto);

      expect(user.id,        tDto.id);
      expect(user.cpf,       tDto.cpf);
      expect(user.name,      tDto.name);
      expect(user.birthdate, tDto.birthdate);
      expect(user.email,     tDto.email);
      expect(user.phone,     tDto.phone);
    });

    test('"female" → Gender.female', () {
      final user = UserMapper.dtoToUser(tDto);
      expect(user.gender, Gender.female);
    });

    test('"male" → Gender.male', () {
      final user = UserMapper.dtoToUser(const UserDto(
        id: '1', cpf: '1', name: 'N', birthdate: '2000-01-01',
        gender: 'male', email: 'e@e.com', phone: '1',
      ));
      expect(user.gender, Gender.male);
    });

    test('gender matching is case-insensitive', () {
      final user = UserMapper.dtoToUser(const UserDto(
        id: '1', cpf: '1', name: 'N', birthdate: '2000-01-01',
        gender: 'FEMALE', email: 'e@e.com', phone: '1',
      ));
      expect(user.gender, Gender.female);
    });

    test('unknown gender value throws ParseException', () {
      expect(
        () => UserMapper.dtoToUser(const UserDto(
          id: '1', cpf: '1', name: 'N', birthdate: '2000-01-01',
          gender: 'other', email: 'e@e.com', phone: '1',
        )),
        throwsA(isA<ParseException>()),
      );
    });
  });

  group('UserMapper.userToDto', () {
    test('maps all fields correctly', () {
      final dto = UserMapper.userToDto(tUser);

      expect(dto.id,        tUser.id);
      expect(dto.cpf,       tUser.cpf);
      expect(dto.name,      tUser.name);
      expect(dto.birthdate, tUser.birthdate);
      expect(dto.email,     tUser.email);
      expect(dto.phone,     tUser.phone);
    });

    test('Gender.female → "female"', () {
      final dto = UserMapper.userToDto(tUser);
      expect(dto.gender, 'female');
    });

    test('Gender.male → "male"', () {
      final dto = UserMapper.userToDto(tUser.copyWith(gender: Gender.male));
      expect(dto.gender, 'male');
    });
  });

  group('round-trip', () {
    test('dtoToUser → userToDto preserves all fields', () {
      final user = UserMapper.dtoToUser(tDto);
      final dto  = UserMapper.userToDto(user);

      expect(dto.id,        tDto.id);
      expect(dto.cpf,       tDto.cpf);
      expect(dto.name,      tDto.name);
      expect(dto.birthdate, tDto.birthdate);
      expect(dto.gender,    tDto.gender);
      expect(dto.email,     tDto.email);
      expect(dto.phone,     tDto.phone);
    });
  });
}
