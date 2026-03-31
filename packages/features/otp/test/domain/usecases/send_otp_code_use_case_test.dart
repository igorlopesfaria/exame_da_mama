import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:feature_otp/domain/usecases/send_otp_code_use_case.dart';
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
  late SendOtpCodeUseCase useCase;

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
    useCase = SendOtpCodeUseCase(mockRepository, mockObservability);
  });

  group('SendOtpCodeUseCase', () {
    test('returns Right(unit) on success', () async {
      when(() => mockRepository.sendCode(any(), any()))
          .thenAnswer((_) async => right(unit));

      final result = await useCase.call(OtpChannel.email, 'user@test.com');

      expect(result, right(unit));
    });

    test('delegates channel and value to repository', () async {
      when(() => mockRepository.sendCode(any(), any()))
          .thenAnswer((_) async => right(unit));

      await useCase.call(OtpChannel.phone, '+5511999999999');

      verify(() => mockRepository.sendCode(OtpChannel.phone, '+5511999999999')).called(1);
    });

    test('returns Left(TooManyAttempts) on TooManyRequestsFailure', () async {
      when(() => mockRepository.sendCode(any(), any()))
          .thenAnswer((_) async => left(const TooManyRequestsFailure()));

      final result = await useCase.call(OtpChannel.email, 'user@test.com');

      result.fold(
        (f) => expect(f, isA<TooManyAttempts>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(ServerError) on any other failure', () async {
      when(() => mockRepository.sendCode(any(), any()))
          .thenAnswer((_) async => left(const NetworkFailure()));

      final result = await useCase.call(OtpChannel.email, 'user@test.com');

      result.fold(
        (f) => expect(f, isA<ServerError>()),
        (_) => fail('expected Left'),
      );
    });

    test('logs success with channel on Right', () async {
      when(() => mockRepository.sendCode(any(), any()))
          .thenAnswer((_) async => right(unit));

      await useCase.call(OtpChannel.email, 'user@test.com');

      verify(() => mockLogger.info(
        'otp.send_code.success',
        attributes: {'channel': 'email'},
      )).called(1);
    });

    test('logs error with channel and failureType on Left', () async {
      when(() => mockRepository.sendCode(any(), any()))
          .thenAnswer((_) async => left(const TooManyRequestsFailure()));

      await useCase.call(OtpChannel.phone, '+5511999999999');

      verify(() => mockLogger.error(
        'otp.send_code.failed',
        attributes: {'channel': 'phone', 'failureType': 'TooManyAttempts'},
      )).called(1);
    });
  });
}
