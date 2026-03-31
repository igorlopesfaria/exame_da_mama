import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/failures/app_failures.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/data/models/otp_verify_code_response.dart';
import 'package:feature_otp/data/repositories/otp_repository_impl.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockOtpRemoteDataSource extends Mock implements OtpRemoteDataSource {}

void main() {
  late MockOtpRemoteDataSource mockDataSource;
  late OtpRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(OtpChannel.email);
  });

  setUp(() {
    mockDataSource = MockOtpRemoteDataSource();
    repository = OtpRepositoryImpl(mockDataSource);
  });

  group('OtpRepositoryImpl.sendCode', () {
    const tNextRequestIn = 60;

    test('returns Right(nextRequestIn) on success', () async {
      when(() => mockDataSource.sendCode(any(), any()))
          .thenAnswer((_) async => tNextRequestIn);

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      expect(result, right(tNextRequestIn));
    });

    test('delegates channel and value to data source', () async {
      when(() => mockDataSource.sendCode(any(), any()))
          .thenAnswer((_) async => tNextRequestIn);

      await repository.sendCode(OtpChannel.phone, '+5511999999999');

      verify(() => mockDataSource.sendCode(OtpChannel.phone, '+5511999999999')).called(1);
    });

    test('returns Left(NetworkFailure) on NetworkException', () async {
      when(() => mockDataSource.sendCode(any(), any()))
          .thenThrow(const NetworkException());

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      result.fold(
        (f) => expect(f, isA<NetworkFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(GenericFailure) on ServerException', () async {
      when(() => mockDataSource.sendCode(any(), any()))
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
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => const OtpVerifyCodeResponse(verificationToken: tToken));

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
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
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
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
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
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
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
