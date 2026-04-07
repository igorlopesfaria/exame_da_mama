import 'package:feature_register/presentation/pages/password/cubit/register_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterPasswordCubit extends Cubit<RegisterPasswordState> {
  RegisterPasswordCubit() : super(const RegisterPasswordIdle());
  // Logic to be implemented
}
