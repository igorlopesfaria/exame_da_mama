import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCpfCubit extends Cubit<RegisterCpfState> {
  RegisterCpfCubit() : super(const RegisterCpfIdle());
  // Logic to be implemented
}
