import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/failures/app_failures.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

abstract final class ExceptionMapper {
  static AppException fromDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        const NetworkException(),

      DioExceptionType.badResponse => switch (e.response?.statusCode) {
          401 => const UnauthorizedException(),
          404 => const NotFoundException(),
          _ => ServerException(
              statusCode: e.response?.statusCode,
              message: e.response?.data?['message'] as String? ?? 'Server error',
            ),
        },

      _ => ServerException(message: e.message ?? 'Unknown error'),
    };
  }

  static Either<Failure, T> mapExceptionToFailure<T>(AppException e) {
    return Left(switch (e) {
      UnauthorizedException() => const UnauthorizedFailure(),
      NotFoundException()     => const NotFoundFailure(),
      NetworkException()      => const NetworkFailure(),
      ParseException()        => const ParseFailure(),
      ServerException()       => ServerFailure(e.message),
    });
  }
}
