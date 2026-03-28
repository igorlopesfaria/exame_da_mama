import 'package:feature_splash/domain/model/session_result.dart';
import 'package:feature_splash/domain/usecase/check_session_usecase.dart';
import 'package:feature_splash/presentation/cubit/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._checkSession) : super(const SplashInitial());

  final CheckSessionUseCase _checkSession;

  Future<void> checkSession() async {
    emit(const SplashLoading());

    final result = await _checkSession();

    switch (result) {
      case SessionAuthenticated():
        emit(const SplashNavigate(SplashDestination.home));
      case SessionPendingTerms():
        emit(const SplashNavigate(SplashDestination.terms));
      case SessionForceUpdate():
        emit(const SplashNavigate(SplashDestination.force_update));
      case SessionUnauthenticated():
        emit(const SplashNavigate(SplashDestination.welcome));
    }
  }
}
