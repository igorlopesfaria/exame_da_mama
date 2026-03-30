import 'package:feature_verification/domain/failures/verification_failure.dart';
import 'package:feature_verification/domain/repositories/verification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyPhoneCodeUseCase {
  const VerifyPhoneCodeUseCase(this._repository);

  final VerificationRepository _repository;

  Future<Either<VerificationFailure, String>> call({
    required String phone,
    required String code,
  }) =>
      _repository.verifyPhoneCode(phone: phone, code: code);
}
