import 'package:feature_register/presentation/pages/gender/cubit/register_gender_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterGenderCubit extends Cubit<RegisterGenderState> {
  RegisterGenderCubit() : super(const RegisterGenderIdle());
  // Logic to be implemented
}
