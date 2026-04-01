import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/repositories/i_validation_repository.dart';
import 'package:commons_validation/domain/usecases/validate_cpf_usecase.dart';
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
  late ValidateCpfUseCase useCase;

  // Known valid CPF: 529.982.247-25
  const validCpf = '52998224725';
  const validCpfMasked = '529.982.247-25';

  // Another known valid CPF: 111.444.777-35
  const validCpf2 = '11144477735';

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
    useCase = ValidateCpfUseCase(mockRepository, mockObservability);
  });

  group('ValidateCpfUseCase — offline', () {
    test('returns Right(digits) for valid CPF', () async {
      final result = await useCase(validCpf);
      expect(result, right(validCpf));
    });

    test('returns Right(digits) for another valid CPF', () async {
      final result = await useCase(validCpf2);
      expect(result, right(validCpf2));
    });

    test('strips mask and returns digits only', () async {
      final result = await useCase(validCpfMasked);
      expect(result, right(validCpf));
    });

    test('returns Left(RequiredField) for empty string', () async {
      final result = await useCase('');
      result.fold((f) => expect(f, isA<RequiredField>()), (_) => fail('expected Left'));
    });

    test('returns Left(RequiredField) for whitespace only', () async {
      final result = await useCase('   ');
      result.fold((f) => expect(f, isA<RequiredField>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for CPF with wrong length (10 digits)', () async {
      final result = await useCase('1234567890');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for CPF with wrong length (12 digits)', () async {
      final result = await useCase('123456789012');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for all-same-digit CPF (000.000.000-00)', () async {
      final result = await useCase('00000000000');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for all-same-digit CPF (111.111.111-11)', () async {
      final result = await useCase('11111111111');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) for CPF with correct length but wrong check digits', () async {
      final result = await useCase('52998224700'); // last 2 digits tampered
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('does not call repository when checkRemote is false', () async {
      await useCase(validCpf);
      verifyNever(() => mockRepository.validateCpf(any()));
    });
  });

  group('ValidateCpfUseCase — remote', () {
    test('returns Right(digits) when remote succeeds', () async {
      when(() => mockRepository.validateCpf(any()))
          .thenAnswer((_) async => right(unit));

      final result = await useCase(validCpf, checkRemote: true);
      expect(result, right(validCpf));
    });

    test('calls repository with stripped digits', () async {
      when(() => mockRepository.validateCpf(any()))
          .thenAnswer((_) async => right(unit));

      await useCase(validCpfMasked, checkRemote: true);
      verify(() => mockRepository.validateCpf(validCpf)).called(1);
    });

    test('returns Left(AlreadyInUse) when remote returns AlreadyInUse', () async {
      when(() => mockRepository.validateCpf(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));

      final result = await useCase(validCpf, checkRemote: true);
      result.fold((f) => expect(f, isA<AlreadyInUse>()), (_) => fail('expected Left'));
    });

    test('skips remote when offline validation fails', () async {
      await useCase('00000000000', checkRemote: true);
      verifyNever(() => mockRepository.validateCpf(any()));
    });
  });

  group('ValidateCpfUseCase — observability', () {
    test('logs success on valid CPF (offline)', () async {
      await useCase(validCpf);
      verify(() => mockLogger.info('validation.cpf.success')).called(1);
    });

    test('logs error with RequiredField on empty input', () async {
      await useCase('');
      verify(() => mockLogger.error(
        'validation.cpf.failed',
        attributes: {'failureType': 'RequiredField'},
      )).called(1);
    });

    test('logs error with InvalidFormat on invalid CPF', () async {
      await useCase('00000000000');
      verify(() => mockLogger.error(
        'validation.cpf.failed',
        attributes: {'failureType': 'InvalidFormat'},
      )).called(1);
    });

    test('logs success on remote success', () async {
      when(() => mockRepository.validateCpf(any()))
          .thenAnswer((_) async => right(unit));
      await useCase(validCpf, checkRemote: true);
      verify(() => mockLogger.info('validation.cpf.success')).called(1);
    });

    test('logs error on remote failure', () async {
      when(() => mockRepository.validateCpf(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));
      await useCase(validCpf, checkRemote: true);
      verify(() => mockLogger.error(
        'validation.cpf.failed',
        attributes: {'failureType': 'AlreadyInUse'},
      )).called(1);
    });
  });
}
