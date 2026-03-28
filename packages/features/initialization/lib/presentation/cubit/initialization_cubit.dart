import 'package:feature_initialization/presentation/cubit/initialization_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitializationCubit extends Cubit<InitializationState> {
  InitializationCubit() : super(const InitializationInitial());

  void goToRegister() =>
      emit(const InitializationNavigate(InitializationDestination.register));

  void goToLogin() =>
      emit(const InitializationNavigate(InitializationDestination.login));
}
