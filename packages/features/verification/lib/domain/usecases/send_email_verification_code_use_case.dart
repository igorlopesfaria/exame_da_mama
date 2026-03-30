import 'package:feature_verification/domain/failures/verification_failure.dart';
import 'package:feature_verification/domain/repositories/verification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendEmailVerificationCodeUseCase {
  const SendEmailVerificationCodeUseCase(this._repository);

  final VerificationRepository _repository;

  Future<Either<VerificationFailure, Unit>> call(String email) =>
      _repository.sendEmailVerificationCode(email);
}
