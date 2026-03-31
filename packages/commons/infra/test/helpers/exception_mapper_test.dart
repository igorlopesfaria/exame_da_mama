import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/helpers/exception_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final requestOptions = RequestOptions(path: '/test');

  group('ExceptionMapper.fromDioException', () {
    group('network errors', () {
      test('connectionError → NetworkException', () {
        final e = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: requestOptions,
        );
        expect(ExceptionMapper.fromDioException(e), isA<NetworkException>());
      });

      test('connectionTimeout → NetworkException', () {
        final e = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: requestOptions,
        );
        expect(ExceptionMapper.fromDioException(e), isA<NetworkException>());
      });

      test('receiveTimeout → NetworkException', () {
        final e = DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: requestOptions,
        );
        expect(ExceptionMapper.fromDioException(e), isA<NetworkException>());
      });

      test('sendTimeout → NetworkException', () {
        final e = DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: requestOptions,
        );
        expect(ExceptionMapper.fromDioException(e), isA<NetworkException>());
      });
    });

    group('badResponse', () {
      test('401 → UnauthorizedException', () {
        final e = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: requestOptions,
          response: Response(requestOptions: requestOptions, statusCode: 401),
        );
        expect(ExceptionMapper.fromDioException(e), isA<UnauthorizedException>());
      });

      test('404 → NotFoundException', () {
        final e = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: requestOptions,
          response: Response(requestOptions: requestOptions, statusCode: 404),
        );
        expect(ExceptionMapper.fromDioException(e), isA<NotFoundException>());
      });

      test('500 with message → ServerException carries message and statusCode', () {
        final e = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: requestOptions,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 500,
            data: {'message': 'Internal Server Error'},
          ),
        );
        final result = ExceptionMapper.fromDioException(e) as ServerException;
        expect(result.statusCode, 500);
        expect(result.message, 'Internal Server Error');
      });

      test('500 without message → ServerException with default message', () {
        final e = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: requestOptions,
          response: Response(requestOptions: requestOptions, statusCode: 500),
        );
        final result = ExceptionMapper.fromDioException(e) as ServerException;
        expect(result.message, 'Server error');
      });

      test('500 with null statusCode → ServerException with null statusCode', () {
        final e = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: requestOptions,
          response: Response(requestOptions: requestOptions),
        );
        final result = ExceptionMapper.fromDioException(e) as ServerException;
        expect(result.statusCode, isNull);
      });
    });

    group('unknown / cancel', () {
      test('unknown type with message → ServerException carries message', () {
        final e = DioException(
          type: DioExceptionType.unknown,
          requestOptions: requestOptions,
          message: 'Something went wrong',
        );
        final result = ExceptionMapper.fromDioException(e) as ServerException;
        expect(result.message, 'Something went wrong');
      });

      test('unknown type with null message → ServerException with fallback', () {
        final e = DioException(
          type: DioExceptionType.unknown,
          requestOptions: requestOptions,
        );
        final result = ExceptionMapper.fromDioException(e) as ServerException;
        expect(result.message, 'Unknown error');
      });

      test('cancel type → ServerException', () {
        final e = DioException(
          type: DioExceptionType.cancel,
          requestOptions: requestOptions,
          message: 'Cancelled',
        );
        expect(ExceptionMapper.fromDioException(e), isA<ServerException>());
      });
    });
  });

  group('ExceptionMapper.mapExceptionToFailure', () {
    test('NetworkException → Left(NetworkFailure)', () {
      final result = ExceptionMapper.mapExceptionToFailure(const NetworkException());
      result.fold(
        (f) => expect(f, isA<NetworkFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('UnauthorizedException → Left(UnauthorizedFailure)', () {
      final result = ExceptionMapper.mapExceptionToFailure(const UnauthorizedException());
      result.fold(
        (f) => expect(f, isA<UnauthorizedFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('NotFoundException → Left(NotFoundFailure)', () {
      final result = ExceptionMapper.mapExceptionToFailure(const NotFoundException());
      result.fold(
        (f) => expect(f, isA<NotFoundFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('ParseException → Left(ParseFailure)', () {
      final result = ExceptionMapper.mapExceptionToFailure(const ParseException());
      result.fold(
        (f) => expect(f, isA<ParseFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('ServerException → Left(ServerFailure) with message', () {
      const exception = ServerException(message: 'DB timeout');
      final result = ExceptionMapper.mapExceptionToFailure(exception);
      result.fold(
        (f) {
          expect(f, isA<GenericFailure>());
          expect(f.message, 'DB timeout');
        },
        (_) => fail('expected Left'),
      );
    });
  });
}
