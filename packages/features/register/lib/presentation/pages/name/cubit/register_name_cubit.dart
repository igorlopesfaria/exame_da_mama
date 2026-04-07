import 'package:feature_register/presentation/pages/name/cubit/register_name_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterNameCubit extends Cubit<RegisterNameState> {
  RegisterNameCubit() : super(const RegisterNameIdle());
  // Logic to be implemented
}
