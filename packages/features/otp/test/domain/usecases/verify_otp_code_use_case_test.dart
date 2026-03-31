import 'package:commons_observability/commons_observability.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:feature_otp/domain/usecases/verify_otp_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockOtpRepository extends Mock implements OtpRepository {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockOtpRepository mockRepository;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late VerifyOtpCodeUseCase useCase;

  const tToken = 'verification-token-abc';

  setUpAll(() {
    registerFallbackValue(OtpChannel.email);
  });

  setUp(() {
    mockRepository    = MockOtpRepository();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.error(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    useCase = VerifyOtpCodeUseCase(mockRepository, mockObservability);
  });

  group('VerifyOtpCodeUseCase', () {
    test('returns Right(token) on success', () async {
      when(() => mockRepository.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => right(tToken));

      final result = await useCase.call(OtpChannel.email, value: 'user@test.com', code: '123456');

      result.fold(
        (_) => fail('expected Right'),
        (token) => expect(token, tToken),
      );
    });

    test('delegates all parameters to repository', () async {
      when(() => mockRepository.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => right(tToken));

      await useCase.call(OtpChannel.phone, value: '+5511999999999', code: '654321');

      verify(() => mockRepository.verifyCode(
        OtpChannel.phone,
        value: '+5511999999999',
        code: '654321',
      )).called(1);
    });

    test('returns Left(InvalidCode) on InvalidCode failure', () async {
      when(() => mockRepository.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => left(const InvalidCode()));

      final result = await useCase.call(OtpChannel.email, value: 'user@test.com', code: '000000');

      result.fold(
        (f) => expect(f, isA<InvalidCode>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(ExpiredCode) on ExpiredCode failure', () async {
      when(() => mockRepository.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => left(const ExpiredCode()));

      final result = await useCase.call(OtpChannel.email, value: 'user@test.com', code: '123456');

      result.fold(
        (f) => expect(f, isA<ExpiredCode>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(TooManyAttempts) on TooManyAttempts failure', () async {
      when(() => mockRepository.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => left(const TooManyAttempts()));

      final result = await useCase.call(OtpChannel.email, value: 'user@test.com', code: '123456');

      result.fold(
        (f) => expect(f, isA<TooManyAttempts>()),
        (_) => fail('expected Left'),
      );
    });

    test('logs success with channel on Right', () async {
      when(() => mockRepository.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => right(tToken));

      await useCase.call(OtpChannel.email, value: 'user@test.com', code: '123456');

      verify(() => mockLogger.info(
        'otp.verify_code.success',
        attributes: {'channel': 'email'},
      )).called(1);
    });

    test('logs error with channel and failureType on Left', () async {
      when(() => mockRepository.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => left(const InvalidCode()));

      await useCase.call(OtpChannel.phone, value: '+5511999999999', code: '000000');

      verify(() => mockLogger.error(
        'otp.verify_code.failed',
        attributes: {'channel': 'phone', 'failureType': 'InvalidCode'},
      )).called(1);
    });
  });
}
