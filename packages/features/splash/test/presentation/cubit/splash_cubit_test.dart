import 'package:commons_user/domain/model/gender.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:feature_splash/domain/model/session_result.dart';
import 'package:feature_splash/domain/usecase/check_session_usecase.dart';
import 'package:feature_splash/presentation/cubit/splash_cubit.dart';
import 'package:feature_splash/presentation/cubit/splash_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckSessionUseCase extends Mock implements CheckSessionUseCase {}

void main() {
  late MockCheckSessionUseCase mockCheckSession;
  late SplashCubit cubit;

  const tUser = User(
    id:        '1',
    cpf:       '12345678901',
    name:      'Test User',
    birthdate: '1990-01-01',
    gender:    Gender.female,
    email:     'test@test.com',
    phone:     '11999999999',
  );

  setUp(() {
    mockCheckSession = MockCheckSessionUseCase();
    cubit            = SplashCubit(mockCheckSession);
  });

  tearDown(() => cubit.close());

  Future<List<SplashState>> _collectStates(Future<void> Function() action) async {
    final states = <SplashState>[];
    final subscription = cubit.stream.listen(states.add);
    await action();
    await Future<void>.delayed(Duration.zero);
    await subscription.cancel();
    return states;
  }

  group('SplashCubit', () {
    test('initial state is SplashInitial', () {
      expect(cubit.state, isA<SplashInitial>());
    });

    group('checkSession', () {
      test('emits [Loading, Navigate(home)] when SessionAuthenticated', () async {
        when(() => mockCheckSession()).thenAnswer(
          (_) async => SessionAuthenticated(tUser),
        );

        final states = await _collectStates(cubit.checkSession);

        expect(states, [
          isA<SplashLoading>(),
          isA<SplashNavigate>(),
        ]);
        expect((states.last as SplashNavigate).to, SplashDestination.home);
      });

      test('emits [Loading, Navigate(welcome)] when SessionUnauthenticated', () async {
        when(() => mockCheckSession()).thenAnswer(
          (_) async => const SessionUnauthenticated(),
        );

        final states = await _collectStates(cubit.checkSession);

        expect(states, [
          isA<SplashLoading>(),
          isA<SplashNavigate>(),
        ]);
        expect((states.last as SplashNavigate).to, SplashDestination.welcome);
      });

      test('emits [Loading, Navigate(terms)] when SessionPendingTerms', () async {
        when(() => mockCheckSession()).thenAnswer(
          (_) async => SessionPendingTerms(tUser),
        );

        final states = await _collectStates(cubit.checkSession);

        expect(states, [
          isA<SplashLoading>(),
          isA<SplashNavigate>(),
        ]);
        expect((states.last as SplashNavigate).to, SplashDestination.terms);
      });

      test('emits [Loading, Navigate(force_update)] when SessionForceUpdate', () async {
        when(() => mockCheckSession()).thenAnswer(
          (_) async => const SessionForceUpdate(),
        );

        final states = await _collectStates(cubit.checkSession);

        expect(states, [
          isA<SplashLoading>(),
          isA<SplashNavigate>(),
        ]);
        expect((states.last as SplashNavigate).to, SplashDestination.force_update);
      });

      test('always emits Loading as first state', () async {
        when(() => mockCheckSession()).thenAnswer(
          (_) async => const SessionUnauthenticated(),
        );

        final states = await _collectStates(cubit.checkSession);

        expect(states.first, isA<SplashLoading>());
      });
    });
  });
}
