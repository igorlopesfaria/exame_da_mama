import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/repositories/i_validation_repository.dart';
import 'package:commons_validation/domain/usecases/validate_phone_usecase.dart';
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
  late ValidatePhoneUseCase useCase;

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
    useCase = ValidatePhoneUseCase(mockRepository, mockObservability);
  });

  group('ValidatePhoneUseCase — offline', () {
    test('returns Right(digits) for valid 11-digit mobile phone', () async {
      final result = await useCase('11999887766');
      expect(result, right('11999887766'));
    });

    test('returns Right(digits) for valid 10-digit landline phone', () async {
      final result = await useCase('1133334444');
      expect(result, right('1133334444'));
    });

    test('strips mask characters and returns only digits', () async {
      final result = await useCase('(11) 99988-7766');
      expect(result, right('11999887766'));
    });

    test('strips mask from 10-digit landline', () async {
      final result = await useCase('(11) 3333-4444');
      expect(result, right('1133334444'));
    });

    test('returns Left(RequiredField) for empty string', () async {
      final result = await useCase('');
      result.fold((f) => expect(f, isA<RequiredField>()), (_) => fail('expected Left'));
    });

    test('returns Left(RequiredField) for whitespace only', () async {
      final result = await useCase('   ');
      result.fold((f) => expect(f, isA<RequiredField>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for 9-digit number', () async {
      final result = await useCase('119998877');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for 12-digit number', () async {
      final result = await useCase('119998877661');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('does not call repository when checkRemote is false', () async {
      await useCase('11999887766');
      verifyNever(() => mockRepository.validatePhone(any()));
    });
  });

  group('ValidatePhoneUseCase — remote', () {
    test('returns Right(digits) when remote succeeds', () async {
      when(() => mockRepository.validatePhone(any()))
          .thenAnswer((_) async => right(unit));

      final result = await useCase('11999887766', checkRemote: true);
      expect(result, right('11999887766'));
    });

    test('calls repository with stripped digits', () async {
      when(() => mockRepository.validatePhone(any()))
          .thenAnswer((_) async => right(unit));

      await useCase('(11) 99988-7766', checkRemote: true);
      verify(() => mockRepository.validatePhone('11999887766')).called(1);
    });

    test('returns Left(AlreadyInUse) when remote returns AlreadyInUse', () async {
      when(() => mockRepository.validatePhone(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));

      final result = await useCase('11999887766', checkRemote: true);
      result.fold((f) => expect(f, isA<AlreadyInUse>()), (_) => fail('expected Left'));
    });

    test('skips remote when offline validation fails', () async {
      await useCase('123', checkRemote: true);
      verifyNever(() => mockRepository.validatePhone(any()));
    });
  });

  group('ValidatePhoneUseCase — observability', () {
    test('logs success on valid phone (offline)', () async {
      await useCase('11999887766');
      verify(() => mockLogger.info('validation.phone.success')).called(1);
    });

    test('logs error with RequiredField on empty input', () async {
      await useCase('');
      verify(() => mockLogger.error(
        'validation.phone.failed',
        attributes: {'failureType': 'RequiredField'},
      )).called(1);
    });

    test('logs error with InvalidFormat on wrong length', () async {
      await useCase('123');
      verify(() => mockLogger.error(
        'validation.phone.failed',
        attributes: {'failureType': 'InvalidFormat'},
      )).called(1);
    });

    test('logs success on remote success', () async {
      when(() => mockRepository.validatePhone(any()))
          .thenAnswer((_) async => right(unit));
      await useCase('11999887766', checkRemote: true);
      verify(() => mockLogger.info('validation.phone.success')).called(1);
    });

    test('logs error on remote failure', () async {
      when(() => mockRepository.validatePhone(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));
      await useCase('11999887766', checkRemote: true);
      verify(() => mockLogger.error(
        'validation.phone.failed',
        attributes: {'failureType': 'AlreadyInUse'},
      )).called(1);
    });
  });
}
