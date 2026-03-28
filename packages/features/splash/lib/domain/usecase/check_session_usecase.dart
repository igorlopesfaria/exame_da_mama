import 'package:commons_security/domain/usecase/find_token_usecase.dart';
import 'package:commons_user/domain/usecase/find_user_usecase.dart';
import 'package:feature_splash/domain/model/session_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckSessionUseCase {
  const CheckSessionUseCase(
    this._findToken,
    this._findUser,
  );

  final FindTokenUseCase _findToken;
  final FindUserUseCase _findUser;

  Future<SessionResult> call() async {
    await Future.delayed(const Duration(seconds: 2));

    final tokenResult = await _findToken();

    final token = tokenResult.fold(
      (_) => null,
      (t) => t,
    );

    if (token == null) return const SessionUnauthenticated();

    final userResult = await _findUser(token.accessToken);

    return userResult.fold(
      (_) => const SessionUnauthenticated(),
      (user) => SessionAuthenticated(user),
    );
  }
}
