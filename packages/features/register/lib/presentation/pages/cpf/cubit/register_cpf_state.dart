import 'package:commons_infra/failures/app_failures.dart';

class RegisterCpfState {
  const RegisterCpfState({
    this.cpf = '',
    this.isButtonEnabled = false,
    this.validationState = const RegisterCpfValidationIdle(),
  });

  final String cpf;
  final bool isButtonEnabled;
  final RegisterCpfValidationState validationState;

  bool get isLoading => validationState is RegisterCpfValidationLoading;
  bool get isInvalidField => !isButtonEnabled && cpf.length == 14;

  RegisterCpfState copyWith({
    String? cpf,
    bool? isButtonEnabled,
    RegisterCpfValidationState? validationState,
  }) =>
      RegisterCpfState(
        cpf: cpf ?? this.cpf,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
        validationState: validationState ?? this.validationState,
      );
}

sealed class RegisterCpfValidationState {
  const RegisterCpfValidationState();
}

class RegisterCpfValidationIdle extends RegisterCpfValidationState {
  const RegisterCpfValidationIdle();
}

class RegisterCpfValidationLoading extends RegisterCpfValidationState {
  const RegisterCpfValidationLoading();
}

class RegisterCpfValidationSuccess extends RegisterCpfValidationState {
  const RegisterCpfValidationSuccess(this.cpf);
  final String cpf;
}

class RegisterCpfValidationError extends RegisterCpfValidationState {
  const RegisterCpfValidationError(this.failure);
  final Failure failure;
}
