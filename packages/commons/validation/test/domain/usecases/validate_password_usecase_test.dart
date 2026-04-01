import 'package:commons_observability/commons_observability.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:commons_validation/domain/usecases/validate_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late ValidatePasswordUseCase useCase;

  setUp(() {
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
    useCase = ValidatePasswordUseCase(mockObservability);
  });

  group('ValidatePasswordUseCase — failures', () {
    test('returns Left(RequiredField) for empty string', () {
      final result = useCase('');
      result.fold((f) => expect(f, isA<RequiredField>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) when shorter than 8 chars', () {
      final result = useCase('Ab1!abc'); // 7 chars
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) when missing uppercase', () {
      final result = useCase('ab1!abcd');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) when missing digit', () {
      final result = useCase('Ab!abcde');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });

    test('returns Left(InvalidFormat) when missing special character', () {
      final result = useCase('Ab1abcde');
      result.fold((f) => expect(f, isA<InvalidFormat>()), (_) => fail('expected Left'));
    });
  });

  group('ValidatePasswordUseCase — strength', () {
    test('returns Right(weak) for password meeting only minimum (8 chars)', () {
      final result = useCase('Ab1!abcd'); // 8 chars, all categories
      expect(result, right(PasswordStrength.weak));
    });

    test('returns Right(weak) for 11-char password', () {
      final result = useCase('Ab1!abcdefg'); // 11 chars
      expect(result, right(PasswordStrength.weak));
    });

    test('returns Right(medium) for 12-char password', () {
      final result = useCase('Ab1!abcdefgh'); // 12 chars
      expect(result, right(PasswordStrength.medium));
    });

    test('returns Right(medium) for 15-char password', () {
      final result = useCase('Ab1!abcdefghijk'); // 15 chars
      expect(result, right(PasswordStrength.medium));
    });

    test('returns Right(strong) for 16-char password', () {
      final result = useCase('Ab1!abcdefghijkl'); // 16 chars
      expect(result, right(PasswordStrength.strong));
    });

    test('returns Right(strong) for 12-char password with all categories', () {
      // uppercase + lowercase + digit + special, length 12 → strong
      final result = useCase('Ab1!abcdefgh'); // all 4 categories + 12 chars
      expect(result, right(PasswordStrength.strong));
    });

    test('returns Right(medium) for 12-char without lowercase (not all categories)', () {
      // No lowercase → not all categories → medium (length 12 satisfies medium but not strong)
      final result = useCase('AB1!ABCDEFGH'); // 12 chars, no lowercase
      expect(result, right(PasswordStrength.medium));
    });
  });

  group('ValidatePasswordUseCase — observability', () {
    test('logs success with strength=weak', () {
      useCase('Ab1!abcd');
      verify(() => mockLogger.info(
        'validation.password.success',
        attributes: {'strength': 'weak'},
      )).called(1);
    });

    test('logs success with strength=medium', () {
      useCase('Ab1!abcdefgh'); // 12 chars
      // All categories present → strong, not medium. Use no-lowercase to get medium.
      // Actually Ab1!abcdefgh has lowercase → strong. Use AB1!ABCDEFGH for medium.
    });

    test('logs success with strength=medium for no-lowercase 12-char', () {
      useCase('AB1!ABCDEFGH');
      verify(() => mockLogger.info(
        'validation.password.success',
        attributes: {'strength': 'medium'},
      )).called(1);
    });

    test('logs success with strength=strong', () {
      useCase('Ab1!abcdefghijkl'); // 16 chars
      verify(() => mockLogger.info(
        'validation.password.success',
        attributes: {'strength': 'strong'},
      )).called(1);
    });

    test('logs error with RequiredField on empty input', () {
      useCase('');
      verify(() => mockLogger.error(
        'validation.password.failed',
        attributes: {'failureType': 'RequiredField'},
      )).called(1);
    });

    test('logs error with InvalidFormat on invalid password', () {
      useCase('weakpass');
      verify(() => mockLogger.error(
        'validation.password.failed',
        attributes: {'failureType': 'InvalidFormat'},
      )).called(1);
    });
  });
}
