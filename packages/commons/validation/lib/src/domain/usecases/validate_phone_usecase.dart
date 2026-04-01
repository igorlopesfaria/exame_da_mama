import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_validation/src/domain/failures/validation_failure.dart';
import 'package:commons_validation/src/domain/repositories/i_validation_repository.dart';
import 'package:fpdart/fpdart.dart';

class ValidatePhoneUseCase {
  const ValidatePhoneUseCase({required this.repository});

  final IValidationRepository repository;

  static final _digitsOnly = RegExp(r'\D');

  Future<Either<Failure, String>> call(
    String value, {
    bool checkRemote = false,
  }) async {
    if (value.trim().isEmpty) return const Left(RequiredField());

    final digits = value.replaceAll(_digitsOnly, '');

    if (digits.length != 10 && digits.length != 11) {
      return const Left(InvalidFormat());
    }

    if (!checkRemote) return Right(digits);

    final remoteResult = await repository.validatePhone(digits);
    return remoteResult.map((_) => digits);
  }
}
