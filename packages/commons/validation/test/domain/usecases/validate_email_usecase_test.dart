import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/repositories/i_validation_repository.dart';
import 'package:commons_validation/domain/usecases/validate_email_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockValidationRepository extends Mock implements IValidationRepository {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockValidationRepository mockRepository;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late ValidateEmailUseCase useCase;

  setUp(() {
    mockRepository = MockValidationRepository();
    mockLogger = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes')))
        .thenReturn(null);
    when(() => mockLogger.error(any(),
            attributes: any(named: 'attributes'),
            throwable: any(named: 'throwable'),
            stackTrace: any(named: 'stackTrace')))
        .thenReturn(null);
    useCase = ValidateEmailUseCase(mockRepository, mockObservability);
  });

  group('ValidateEmailUseCase — offline', () {
    test('returns Right(email) for valid email', () async {
      final result = await useCase('user@example.com');
      expect(result, right('user@example.com'));
    });

    test('trims leading and trailing whitespace', () async {
      final result = await useCase('  user@example.com  ');
      expect(result, right('user@example.com'));
    });

    test('returns Left(RequiredField) for empty string', () async {
      final result = await useCase('');
      expect(result.isLeft(), true);
      result.fold((f) => expect(f, isA<RequiredField>()), (_) => fail('expected Left'));
    });

    test('returns Left(RequiredField) for whitespace only', () async {
      final result = await useCase('   ');
      expect(result.isLeft(), true);
      result.fold((f) => expect(f, isA<RequiredField>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for missing @', () async {
      final result = await useCase('userexample.com');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for missing domain', () async {
      final result = await useCase('user@');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for missing TLD', () async {
      final result = await useCase('user@example');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('does not call repository when checkRemote is false', () async {
      await useCase('user@example.com');
      verifyNever(() => mockRepository.validateEmail(any()));
    });
  });

  group('ValidateEmailUseCase — remote', () {
    test('returns Right(email) when remote succeeds', () async {
      when(() => mockRepository.validateEmail(any()))
          .thenAnswer((_) async => right(unit));

      final result = await useCase('user@example.com', checkRemote: true);
      expect(result, right('user@example.com'));
    });

    test('returns Left(AlreadyInUse) when remote returns AlreadyInUse', () async {
      when(() => mockRepository.validateEmail(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));

      final result = await useCase('user@example.com', checkRemote: true);
      result.fold((f) => expect(f, isA<AlreadyInUse>()), (_) => fail('expected Left'));
    });

    test('calls repository with trimmed email', () async {
      when(() => mockRepository.validateEmail(any()))
          .thenAnswer((_) async => right(unit));

      await useCase('  user@example.com  ', checkRemote: true);
      verify(() => mockRepository.validateEmail('user@example.com')).called(1);
    });

    test('skips remote when offline validation fails', () async {
      await useCase('not-an-email', checkRemote: true);
      verifyNever(() => mockRepository.validateEmail(any()));
    });
  });

  group('ValidateEmailUseCase — observability', () {
    test('logs success on valid email (offline)', () async {
      await useCase('user@example.com');
      verify(() => mockLogger.info('validation.email.success')).called(1);
    });

    test('logs error with RequiredField on empty input', () async {
      await useCase('');
      verify(() => mockLogger.error(
        'validation.email.failed',
        attributes: {'failureType': 'RequiredField'},
      )).called(1);
    });

    test('logs error with InvalidFormat on bad email', () async {
      await useCase('bad-email');
      verify(() => mockLogger.error(
        'validation.email.failed',
        attributes: {'failureType': 'InvalidFormat'},
      )).called(1);
    });

    test('logs success on remote success', () async {
      when(() => mockRepository.validateEmail(any()))
          .thenAnswer((_) async => right(unit));
      await useCase('user@example.com', checkRemote: true);
      verify(() => mockLogger.info('validation.email.success')).called(1);
    });

    test('logs error on remote failure', () async {
      when(() => mockRepository.validateEmail(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));
      await useCase('user@example.com', checkRemote: true);
      verify(() => mockLogger.error(
        'validation.email.failed',
        attributes: {'failureType': 'AlreadyInUse'},
      )).called(1);
    });
  });
}
