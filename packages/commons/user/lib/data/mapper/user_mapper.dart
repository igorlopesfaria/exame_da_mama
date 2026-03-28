import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_user/data/model/user_dto.dart';
import 'package:commons_user/domain/model/gender.dart';
import 'package:commons_user/domain/model/user.dart';

abstract final class UserMapper {
  static User dtoToUser(UserDto dto) => User(
        id:        dto.id,
        cpf:       dto.cpf,
        name:      dto.name,
        birthdate: dto.birthdate,
        gender:    _genderFromString(dto.gender),
        email:     dto.email,
        phone:     dto.phone,
      );

  static UserDto userToDto(User user) => UserDto(
        id:        user.id,
        cpf:       user.cpf,
        name:      user.name,
        birthdate: user.birthdate,
        gender:    _genderToString(user.gender),
        email:     user.email,
        phone:     user.phone,
      );

  static Gender _genderFromString(String value) => switch (value.toLowerCase()) {
        'female' => Gender.female,
        'male'   => Gender.male,
        _        => throw ParseException('Unknown gender value: "$value"'),
      };

  static String _genderToString(Gender gender) => switch (gender) {
        Gender.male   => 'male',
        Gender.female => 'female',
      };
}
