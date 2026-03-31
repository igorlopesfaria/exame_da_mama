import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:commons_security/domain/repository/i_security_remote_repository.dart';
import 'package:commons_security/domain/usecase/authenticate_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityRemoteRepository extends Mock implements ISecurityRemoteRepository {}
class MockSecurityLocalRepository extends Mock implements ISecurityLocalRepository {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockSecurityRemoteRepository mockRemoteRepo;
  late MockSecurityLocalRepository mockLocalRepo;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late AuthenticateUseCase useCase;

  const tCpf      = '12345678901';
  const tPassword = 'secret123';
  const tToken    = Token(accessToken: 'access-abc', refreshToken: 'refresh-xyz');

  setUpAll(() {
    registerFallbackValue(tToken);
  });

  setUp(() {
    mockRemoteRepo    = MockSecurityRemoteRepository();
    mockLocalRepo     = MockSecurityLocalRepository();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    useCase = AuthenticateUseCase(mockRemoteRepo, mockLocalRepo, mockObservability);
  });

  group('AuthenticateUseCase', () {
    group('remote success', () {
      setUp(() {
        when(() => mockRemoteRepo.authenticate(any(), any()))
            .thenAnswer((_) async => const Right(tToken));
        when(() => mockLocalRepo.saveToken(any()))
            .thenAnswer((_) async => Right(unit));
      });

      test('returns Right(token)', () async {
        final result = await useCase.call(tCpf, tPassword);
        result.fold(
          (_) => fail('expected Right'),
          (token) => expect(token, tToken),
        );
      });

      test('saves token to local storage', () async {
        await useCase.call(tCpf, tPassword);
        verify(() => mockLocalRepo.saveToken(tToken)).called(1);
      });

      test('passes cpf and password to remote repository', () async {
        await useCase.call(tCpf, tPassword);
        verify(() => mockRemoteRepo.authenticate(tCpf, tPassword)).called(1);
      });
    });

    group('remote failure', () {
      setUp(() {
        when(() => mockRemoteRepo.authenticate(any(), any()))
            .thenAnswer((_) async => const Left(UnauthorizedFailure()));
      });

      test('returns Left with remote failure', () async {
        final result = await useCase.call(tCpf, tPassword);
        result.fold(
          (f) => expect(f, isA<UnauthorizedFailure>()),
          (_) => fail('expected Left'),
        );
      });

      test('does not save token to local storage', () async {
        await useCase.call(tCpf, tPassword);
        verifyNever(() => mockLocalRepo.saveToken(any()));
      });
    });
  });
}
