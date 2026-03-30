import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_user/domain/model/gender.dart';
import 'package:commons_user/domain/model/user.dart';
import 'package:commons_user/domain/repository/i_user_local_repository.dart';
import 'package:commons_user/domain/repository/i_user_remote_repository.dart';
import 'package:commons_user/domain/usecase/find_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRemoteRepository extends Mock implements IUserRemoteRepository {}
class MockUserLocalRepository extends Mock implements IUserLocalRepository {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockUserRemoteRepository mockRemoteRepo;
  late MockUserLocalRepository mockLocalRepo;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late FindUserUseCase useCase;

  const tUser = User(
    id:        '1',
    cpf:       '12345678901',
    name:      'Test User',
    birthdate: '1990-01-01',
    gender:    Gender.female,
    email:     'test@test.com',
    phone:     '11999999999',
  );

  setUpAll(() {
    registerFallbackValue(tUser);
  });

  setUp(() {
    mockRemoteRepo    = MockUserRemoteRepository();
    mockLocalRepo     = MockUserLocalRepository();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    useCase = FindUserUseCase(mockRemoteRepo, mockLocalRepo, mockObservability);
  });

  group('FindUserUseCase', () {
    group('remote success', () {
      setUp(() {
        when(() => mockRemoteRepo.loadUserById(any()))
            .thenAnswer((_) async => const Right(tUser));
        when(() => mockLocalRepo.saveUser(any()))
            .thenAnswer((_) async => Right(unit));
      });

      test('returns Right(user)', () async {
        final result = await useCase.call('1');
        result.fold(
          (_) => fail('expected Right'),
          (user) => expect(user, tUser),
        );
      });

      test('saves user to local cache', () async {
        await useCase.call('1');
        verify(() => mockLocalRepo.saveUser(tUser)).called(1);
      });

      test('does not read from local cache', () async {
        await useCase.call('1');
        verifyNever(() => mockLocalRepo.loadUser());
      });
    });

    group('remote failure with cached user', () {
      setUp(() {
        when(() => mockRemoteRepo.loadUserById(any()))
            .thenAnswer((_) async => const Left(NetworkFailure()));
        when(() => mockLocalRepo.loadUser())
            .thenAnswer((_) async => const Right(tUser));
      });

      test('returns Right(cachedUser)', () async {
        final result = await useCase.call('1');
        result.fold(
          (_) => fail('expected Right'),
          (user) => expect(user, tUser),
        );
      });

      test('does not save to cache', () async {
        await useCase.call('1');
        verifyNever(() => mockLocalRepo.saveUser(any()));
      });
    });

    group('remote failure with empty cache', () {
      setUp(() {
        when(() => mockRemoteRepo.loadUserById(any()))
            .thenAnswer((_) async => const Left(NetworkFailure()));
        when(() => mockLocalRepo.loadUser())
            .thenAnswer((_) async => const Right<Failure, User?>(null));
      });

      test('returns Left with original remote failure', () async {
        final result = await useCase.call('1');
        result.fold(
          (f) => expect(f, isA<NetworkFailure>()),
          (_) => fail('expected Left'),
        );
      });
    });

    group('remote failure and local failure', () {
      setUp(() {
        when(() => mockRemoteRepo.loadUserById(any()))
            .thenAnswer((_) async => const Left(NetworkFailure()));
        when(() => mockLocalRepo.loadUser())
            .thenAnswer((_) async => const Left(ServerFailure('cache error')));
      });

      test('returns Left with original remote failure, not local failure', () async {
        final result = await useCase.call('1');
        result.fold(
          (f) => expect(f, isA<NetworkFailure>()),
          (_) => fail('expected Left'),
        );
      });
    });

    test('passes userId to remote repository', () async {
      when(() => mockRemoteRepo.loadUserById(any()))
          .thenAnswer((_) async => const Right(tUser));
      when(() => mockLocalRepo.saveUser(any()))
          .thenAnswer((_) async => Right(unit));

      await useCase.call('user-123');

      verify(() => mockRemoteRepo.loadUserById('user-123')).called(1);
    });
  });
}
