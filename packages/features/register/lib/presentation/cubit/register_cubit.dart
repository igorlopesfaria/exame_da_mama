import 'package:feature_register/presentation/cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void completeCpf(String cpf) {
    emit(state.copyWith(currentStep: 1, cpf: cpf));
  }

  void completeName(String name) {
    emit(state.copyWith(currentStep: 2, name: name));
  }

  void completePhone(String phone) {
    emit(state.copyWith(currentStep: 3, phone: phone));
  }

  void completeEmail(String email) {
    emit(state.copyWith(currentStep: 4, email: email));
  }

  void completeGender(String gender) {
    emit(state.copyWith(currentStep: 5, gender: gender));
  }

  void completeBirthdate(String birthdate) {
    emit(state.copyWith(currentStep: 6, birthdate: birthdate));
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }
}
