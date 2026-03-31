import 'package:dio/dio.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/data/models/otp_code_response.dart';
import 'package:feature_otp/data/repositories/otp_repository_impl.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockOtpRemoteDataSource extends Mock implements OtpRemoteDataSource {}

DioException _dioWithResponse(String errorCode) => DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        data: {'error': errorCode},
        statusCode: 400,
      ),
    );

DioException _dioNoResponse() => DioException(
      requestOptions: RequestOptions(path: ''),
    );

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
    test('returns Right(unit) on success', () async {
      when(() => mockDataSource.sendCode(any(), any())).thenAnswer((_) async {});

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      expect(result, const Right(unit));
    });

    test('delegates channel and value to data source', () async {
      when(() => mockDataSource.sendCode(any(), any())).thenAnswer((_) async {});

      await repository.sendCode(OtpChannel.phone, '+5511999999999');

      verify(() => mockDataSource.sendCode(OtpChannel.phone, '+5511999999999')).called(1);
    });

    test('returns Left(ServerError) when DioException has no response', () async {
      when(() => mockDataSource.sendCode(any(), any())).thenThrow(_dioNoResponse());

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      result.fold(
        (f) => expect(f, isA<ServerError>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(ServerError) on unknown API error', () async {
      when(() => mockDataSource.sendCode(any(), any()))
          .thenThrow(_dioWithResponse('UNKNOWN_ERROR'));

      final result = await repository.sendCode(OtpChannel.email, 'user@test.com');

      result.fold(
        (f) => expect(f, isA<ServerError>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('OtpRepositoryImpl.verifyCode', () {
    const tToken = 'verification-token-abc';

    test('returns Right(token) on success', () async {
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => const OtpCodeResponse(verificationToken: tToken));

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

    test('returns Left(InvalidCode) on INVALID_CODE error', () async {
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenThrow(_dioWithResponse('INVALID_CODE'));

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '000000',
      );

      result.fold(
        (f) => expect(f, isA<InvalidCode>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(ExpiredCode) on EXPIRED_CODE error', () async {
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenThrow(_dioWithResponse('EXPIRED_CODE'));

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '123456',
      );

      result.fold(
        (f) => expect(f, isA<ExpiredCode>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(TooManyAttempts) on TOO_MANY_ATTEMPTS error', () async {
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenThrow(_dioWithResponse('TOO_MANY_ATTEMPTS'));

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '123456',
      );

      result.fold(
        (f) => expect(f, isA<TooManyAttempts>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(ServerError) when DioException has no response', () async {
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenThrow(_dioNoResponse());

      final result = await repository.verifyCode(
        OtpChannel.phone,
        value: '+5511999999999',
        code: '123456',
      );

      result.fold(
        (f) => expect(f, isA<ServerError>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns Left(ServerError) on unknown API error', () async {
      when(() => mockDataSource.verifyCode(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenThrow(_dioWithResponse('UNKNOWN_ERROR'));

      final result = await repository.verifyCode(
        OtpChannel.email,
        value: 'user@test.com',
        code: '123456',
      );

      result.fold(
        (f) => expect(f, isA<ServerError>()),
        (_) => fail('expected Left'),
      );
    });
  });
}
