class RegisterState {
  const RegisterState({
    this.currentStep = 0,
    this.cpf,
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.birthdate,
  });

  static const int totalSteps = 7;

  final int currentStep;
  final String? cpf;
  final String? name;
  final String? phone;
  final String? email;
  final String? gender;
  final String? birthdate;

  RegisterState copyWith({
    int? currentStep,
    String? cpf,
    String? name,
    String? phone,
    String? email,
    String? gender,
    String? birthdate,
  }) =>
      RegisterState(
        currentStep: currentStep ?? this.currentStep,
        cpf: cpf ?? this.cpf,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        birthdate: birthdate ?? this.birthdate,
      );
}
