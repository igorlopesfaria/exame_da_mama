import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/usecases/validate_cpf_usecase.dart';
import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCpfCubit extends Cubit<RegisterCpfState> {
  RegisterCpfCubit(this._validateCpf) : super(const RegisterCpfState());

  final ValidateCpfUseCase _validateCpf;

  Future<void> onCpfChanged(String cpf) async {
    final result = await _validateCpf(cpf, checkRemote: false);
    result.fold(
      (failure) => emit(state.copyWith(cpf: cpf, isButtonEnabled: false)),
      (validCpf) => emit(state.copyWith(cpf: validCpf, isButtonEnabled: true)),
    );
  }

  Future<void> submit() async {
    if (!state.isButtonEnabled || state.isLoading) return;

    emit(state.copyWith(validationState: const RegisterCpfValidationLoading()));

    try {
      final result = await _validateCpf(state.cpf, checkRemote: true);
      result.fold(
        (failure) {
          if (failure is AlreadyInUse) {
            // TODO: handle "CPF already registered" flow
            emit(state.copyWith(validationState: const RegisterCpfValidationIdle()));
          } else {
            emit(state.copyWith(validationState: RegisterCpfValidationError(failure)));
          }
        },
        (cpf) => emit(state.copyWith(validationState: RegisterCpfValidationSuccess(cpf))),
      );
    } catch (_) {
      emit(state.copyWith(
        validationState: const RegisterCpfValidationError(GenericFailure('Unexpected error')),
      ));
    }
  }

  void resetValidation() {
    emit(state.copyWith(validationState: const RegisterCpfValidationIdle()));
  }
}
