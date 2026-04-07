import 'package:feature_register/presentation/pages/phone/cubit/register_phone_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterPhoneCubit extends Cubit<RegisterPhoneState> {
  RegisterPhoneCubit() : super(const RegisterPhoneIdle());
  // Logic to be implemented
}
