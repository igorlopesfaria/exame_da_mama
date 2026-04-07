import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/failures/app_failures.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/data/models/request/otp_send_code_request.dart';
import 'package:feature_otp/data/models/request/otp_verify_code_request.dart';
import 'package:feature_otp/data/models/response/otp_send_code_response.dart';
import 'package:feature_otp/data/models/response/otp_verify_code_response.dart';
import 'package:feature_otp/data/repositories/otp_repository_impl.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockOtpRemoteDataSource extends Mock implements OtpRemoteDataSource {}

class FakeOtpSendCodeRequest extends Fake implements OtpSendCodeRequest {}

class FakeOtpVerifyCodeRequest extends Fake implements OtpVerifyCodeRequest {}

void main() {
  late MockOtpRemoteDataSource mockDataSource;
  late OtpRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeOtpSendCodeRequest());
    registerFallbackValue(FakeOtpVerifyCodeRequest());
  });

  setUp(() {
    mockDataSource = MockOtpRemoteDataSource();
    repository = OtpRepositoryImpl(mockDataSource);
  });

  group('OtpRepositoryImpl.sendCode', () {
    const tNextRequestIn = 60;
    const tResponse = OtpSendCodeResponse(otpNextRequestIn: tNextRequestIn);

    test('returns Right(nextRequestIn) on success', () async {
      when(() => mockDataSource.sendCode(any()))
          .thenAnswer((_) async => tResponse);

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      expect(result, right(tNextRequestIn));
    });

    test('returns Left(NetworkFailure) on NetworkException', () async {
      when(() => mockDataSource.sendCode(any()))
          .thenThrow(const NetworkException());

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      result.fold(
        (f) => expect(f, isA<NetworkFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(GenericFailure) on ServerException', () async {
      when(() => mockDataSource.sendCode(any()))
          .thenThrow(const ServerException(message: 'Internal error'));

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      result.fold(
        (f) => expect(f, isA<GenericFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('OtpRepositoryImpl.verifyCode', () {
    const tToken = 'verification-token-abc';

    test('returns Right(token) on success', () async {
      when(() => mockDataSource.verifyCode(any()))
          .thenAnswer((_) async => OtpVerifyCodeResponse(verificationToken: tToken));

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '123456',
      );

      result.fold(
        (_) => fail('expected Right'),
        (token) => expect(token, tToken),
      );
    });

    test('returns Left(NetworkFailure) on NetworkException', () async {
      when(() => mockDataSource.verifyCode(any()))
          .thenThrow(const NetworkException());

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '123456',
      );

      result.fold(
        (f) => expect(f, isA<NetworkFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(GenericFailure) on ServerException', () async {
      when(() => mockDataSource.verifyCode(any()))
          .thenThrow(const ServerException(message: 'Bad request'));

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '000000',
      );

      result.fold(
        (f) => expect(f, isA<GenericFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(ParseFailure) on ParseException', () async {
      when(() => mockDataSource.verifyCode(any()))
          .thenThrow(const ParseException());

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '123456',
      );

      result.fold(
        (f) => expect(f, isA<ParseFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });
}
