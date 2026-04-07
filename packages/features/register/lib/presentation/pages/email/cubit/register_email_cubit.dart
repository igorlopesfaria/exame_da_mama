import 'package:feature_register/presentation/pages/email/cubit/register_email_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterEmailCubit extends Cubit<RegisterEmailState> {
  RegisterEmailCubit() : super(const RegisterEmailIdle());
  // Logic to be implemented
}
