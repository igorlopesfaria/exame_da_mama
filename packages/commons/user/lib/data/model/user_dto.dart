import 'package:commons_infra/exceptions/app_exceptions.dart';

class UserDto {
  const UserDto({
    required this.id,
    required this.cpf,
    required this.name,
    required this.birthdate,
    required this.gender,
    required this.email,
    required this.phone,
  });

  final String id;
  final String cpf;
  final String name;
  final String birthdate;
  final String gender;
  final String email;
  final String phone;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    String require(String key) {
      final value = json[key] as String?;
      if (value == null || value.isEmpty) {
        throw ParseException('Missing required field: "$key"');
      }
      return value;
    }

    return UserDto(
      id:        require('id'),
      cpf:       require('cpf'),
      name:      require('name'),
      birthdate: require('birthdate'),
      gender:    require('gender'),
      email:     require('email'),
      phone:     require('phone'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id':        id,
        'cpf':       cpf,
        'name':      name,
        'birthdate': birthdate,
        'gender':    gender,
        'email':     email,
        'phone':     phone,
      };
}
