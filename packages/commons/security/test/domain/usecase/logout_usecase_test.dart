import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:commons_security/domain/usecase/logout_usecase.dart';
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
  late LogoutUseCase useCase;

  setUpAll(() {
    registerFallbackValue(const Token(accessToken: 'a', refreshToken: 'r'));
  });

  setUp(() {
    mockLocalRepo     = MockSecurityLocalRepository();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    useCase = LogoutUseCase(mockLocalRepo, mockObservability);
  });

  group('LogoutUseCase', () {
    test('calls saveToken(null) on local repository', () async {
      when(() => mockLocalRepo.saveToken(null))
          .thenAnswer((_) async => Right(unit));

      await useCase.call();

      verify(() => mockLocalRepo.saveToken(null)).called(1);
    });

    test('returns Right(unit) on success', () async {
      when(() => mockLocalRepo.saveToken(null))
          .thenAnswer((_) async => Right(unit));

      final result = await useCase.call();

      result.fold(
        (_) => fail('expected Right'),
        (u) => expect(u, unit),
      );
    });

    test('returns Left(failure) when saveToken fails', () async {
      when(() => mockLocalRepo.saveToken(null))
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
  });
}
