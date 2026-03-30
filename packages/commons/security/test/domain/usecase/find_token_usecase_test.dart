import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:commons_security/domain/usecase/find_token_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityLocalRepository extends Mock implements ISecurityLocalRepository {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockSecurityLocalRepository mockLocalRepo;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late FindTokenUseCase useCase;

  const tToken = Token(accessToken: 'access-abc', refreshToken: 'refresh-xyz');

  setUp(() {
    mockLocalRepo     = MockSecurityLocalRepository();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    useCase = FindTokenUseCase(mockLocalRepo, mockObservability);
  });

  group('FindTokenUseCase', () {
    test('returns Right(token) when token exists', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(tToken));

      final result = await useCase.call();

      result.fold(
        (_) => fail('expected Right'),
        (token) => expect(token, tToken),
      );
    });

    test('returns Right(null) when no token is stored', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(null));

      final result = await useCase.call();

      result.fold(
        (_) => fail('expected Right'),
        (token) => expect(token, isNull),
      );
    });

    test('returns Left(failure) when repository fails', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Left(ServerFailure('storage error')));

      final result = await useCase.call();

      result.fold(
        (f) {
          expect(f, isA<ServerFailure>());
          expect(f.message, 'storage error');
        },
        (_) => fail('expected Left'),
      );
    });

    test('delegates to local repository', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(tToken));

      await useCase.call();

      verify(() => mockLocalRepo.findToken()).called(1);
    });

    test('logs success with hasToken=true when token found', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(tToken));

      await useCase.call();

      verify(() => mockLogger.info(
        'auth.find_token.success',
        attributes: {'hasToken': true},
      )).called(1);
    });

    test('logs success with hasToken=false when no token stored', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(null));

      await useCase.call();

      verify(() => mockLogger.info(
        'auth.find_token.success',
        attributes: {'hasToken': false},
      )).called(1);
    });

    test('logs error when repository fails', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Left(ServerFailure('storage error')));

      await useCase.call();

      verify(() => mockLogger.error(
        'auth.find_token.failed',
        attributes: any(named: 'attributes'),
        throwable: any(named: 'throwable'),
        stackTrace: any(named: 'stackTrace'),
      )).called(1);
    });
  });
}
