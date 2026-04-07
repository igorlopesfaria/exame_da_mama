import 'package:feature_register/presentation/pages/birthdate/cubit/register_birthdate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterBirthdateCubit extends Cubit<RegisterBirthdateState> {
  RegisterBirthdateCubit() : super(const RegisterBirthdateIdle());
  // Logic to be implemented
}
