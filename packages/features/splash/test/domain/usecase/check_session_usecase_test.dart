import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/usecase/find_token_usecase.dart';
import 'package:commons_user/domain/model/gender.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:commons_user/domain/usecase/find_user_usecase.dart';
import 'package:feature_splash/domain/model/session_result.dart';
import 'package:feature_splash/domain/usecase/check_session_usecase.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockFindTokenUseCase extends Mock implements FindTokenUseCase {}
class MockFindUserUseCase extends Mock implements FindUserUseCase {}

void main() {
  late MockFindTokenUseCase mockFindToken;
  late MockFindUserUseCase mockFindUser;
  late CheckSessionUseCase useCase;

  const tToken = Token(accessToken: 'access-abc', refreshToken: 'refresh-xyz');
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
    mockFindToken = MockFindTokenUseCase();
    mockFindUser  = MockFindUserUseCase();
    useCase       = CheckSessionUseCase(mockFindToken, mockFindUser);
  });

  void _runWithDelay(Future<SessionResult> Function() body, void Function(SessionResult) verify) {
    fakeAsync((fake) {
      late SessionResult result;
      body().then((r) => result = r);
      fake.elapse(const Duration(seconds: 2));
      verify(result);
    });
  }

  group('CheckSessionUseCase', () {
    group('token failure', () {
      setUp(() {
        when(() => mockFindToken()).thenAnswer(
          (_) async => const Left(NetworkFailure()),
        );
      });

      test('returns SessionUnauthenticated', () {
        _runWithDelay(
          () => useCase.call(),
          (result) => expect(result, isA<SessionUnauthenticated>()),
        );
      });

      test('does not call FindUserUseCase', () {
        _runWithDelay(
          () => useCase.call(),
          (_) => verifyNever(() => mockFindUser(any())),
        );
      });
    });

    group('token is null', () {
      setUp(() {
        when(() => mockFindToken()).thenAnswer(
          (_) async => const Right(null),
        );
      });

      test('returns SessionUnauthenticated', () {
        _runWithDelay(
          () => useCase.call(),
          (result) => expect(result, isA<SessionUnauthenticated>()),
        );
      });

      test('does not call FindUserUseCase', () {
        _runWithDelay(
          () => useCase.call(),
          (_) => verifyNever(() => mockFindUser(any())),
        );
      });
    });

    group('token ok, user failure', () {
      setUp(() {
        when(() => mockFindToken()).thenAnswer(
          (_) async => const Right(tToken),
        );
        when(() => mockFindUser(any())).thenAnswer(
          (_) async => const Left(NetworkFailure()),
        );
      });

      test('returns SessionUnauthenticated', () {
        _runWithDelay(
          () => useCase.call(),
          (result) => expect(result, isA<SessionUnauthenticated>()),
        );
      });
    });

    group('token ok, user ok', () {
      setUp(() {
        when(() => mockFindToken()).thenAnswer(
          (_) async => const Right(tToken),
        );
        when(() => mockFindUser(any())).thenAnswer(
          (_) async => const Right(tUser),
        );
      });

      test('returns SessionAuthenticated with user', () {
        _runWithDelay(
          () => useCase.call(),
          (result) {
            expect(result, isA<SessionAuthenticated>());
            expect((result as SessionAuthenticated).user, tUser);
          },
        );
      });

      test('passes token accessToken to FindUserUseCase', () {
        _runWithDelay(
          () => useCase.call(),
          (_) => verify(() => mockFindUser(tToken.accessToken)).called(1),
        );
      });
    });
  });
}
