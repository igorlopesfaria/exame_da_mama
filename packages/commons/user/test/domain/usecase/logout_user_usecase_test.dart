import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_user/domain/repository/i_user_local_repository.dart';
import 'package:commons_user/domain/usecase/logout_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockUserLocalRepository extends Mock implements IUserLocalRepository {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockUserLocalRepository mockLocalRepo;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late LogoutUserUseCase useCase;

  setUp(() {
    mockLocalRepo     = MockUserLocalRepository();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    useCase = LogoutUserUseCase(mockLocalRepo, mockObservability);
  });

  group('LogoutUserUseCase', () {
    test('calls clearUser on local repository', () async {
      when(() => mockLocalRepo.clearUser())
          .thenAnswer((_) async => Right(unit));

      await useCase.call();

      verify(() => mockLocalRepo.clearUser()).called(1);
    });

    test('returns Right(unit) on success', () async {
      when(() => mockLocalRepo.clearUser())
          .thenAnswer((_) async => Right(unit));

      final result = await useCase.call();

      result.fold(
        (_) => fail('expected Right'),
        (u) => expect(u, unit),
      );
    });

    test('returns Left(failure) when clearUser fails', () async {
      when(() => mockLocalRepo.clearUser())
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
