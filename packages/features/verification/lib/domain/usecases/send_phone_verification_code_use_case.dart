import 'package:feature_verification/domain/failures/verification_failure.dart';
import 'package:feature_verification/domain/repositories/verification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendPhoneVerificationCodeUseCase {
  const SendPhoneVerificationCodeUseCase(this._repository);

  final VerificationRepository _repository;

  Future<Either<VerificationFailure, Unit>> call(String phone) =>
      _repository.sendPhoneVerificationCode(phone);
}
