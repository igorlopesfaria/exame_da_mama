import 'package:commons_user/domain/model/gender.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
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
  final Gender gender;
  final String email;
  final String phone;

  User copyWith({
    String? id,
    String? cpf,
    String? name,
    String? birthdate,
    Gender? gender,
    String? email,
    String? phone,
  }) =>
      User(
        id:        id        ?? this.id,
        cpf:       cpf       ?? this.cpf,
        name:      name      ?? this.name,
        birthdate: birthdate ?? this.birthdate,
        gender:    gender    ?? this.gender,
        email:     email     ?? this.email,
        phone:     phone     ?? this.phone,
      );

  @override
  List<Object> get props => [id, cpf, name, birthdate, gender, email, phone];
}
