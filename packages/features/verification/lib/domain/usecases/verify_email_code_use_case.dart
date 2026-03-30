import 'package:feature_verification/domain/failures/verification_failure.dart';
import 'package:feature_verification/domain/repositories/verification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyEmailCodeUseCase {
  const VerifyEmailCodeUseCase(this._repository);

  final VerificationRepository _repository;

  Future<Either<VerificationFailure, String>> call({
    required String email,
    required String code,
  }) =>
      _repository.verifyEmailCode(email: email, code: code);
}
