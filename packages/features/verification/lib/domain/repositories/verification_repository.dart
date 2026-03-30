import 'package:feature_verification/domain/failures/verification_failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class VerificationRepository {
  Future<Either<VerificationFailure, Unit>> sendEmailVerificationCode(String email);
  Future<Either<VerificationFailure, Unit>> sendPhoneVerificationCode(String phone);
  Future<Either<VerificationFailure, String>> verifyEmailCode({
    required String email,
    required String code,
  });
  Future<Either<VerificationFailure, String>> verifyPhoneCode({
    required String phone,
    required String code,
  });
}
