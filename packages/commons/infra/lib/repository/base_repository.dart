import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/helpers/exception_mapper.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseRepository {
  const BaseRepository();
  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } on AppException catch (e) {
      return ExceptionMapper.mapExceptionToFailure(e);
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }
}
