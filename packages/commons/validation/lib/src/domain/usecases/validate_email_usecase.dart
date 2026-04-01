import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_validation/src/domain/failures/validation_failure.dart';
import 'package:commons_validation/src/domain/repositories/i_validation_repository.dart';
import 'package:fpdart/fpdart.dart';

class ValidateEmailUseCase {
  const ValidateEmailUseCase({this.repository});

  final IValidationRepository? repository;

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  Future<Either<Failure, String>> call(
    String value, {
    bool checkRemote = false,
  }) async {
    if (value.trim().isEmpty) return const Left(RequiredField());
    if (!_emailRegex.hasMatch(value.trim())) return const Left(InvalidFormat());

    if (!checkRemote || repository == null) return Right(value.trim());

    final remoteResult = await repository!.validateEmail(value.trim());
    return remoteResult.map((_) => value.trim());
  }
}
