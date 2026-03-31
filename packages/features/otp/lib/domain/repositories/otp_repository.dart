import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/model/verification_token.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OtpRepository {
  Future<Either<OtpFailure, Unit>> sendCode(OtpChannel channel, String value);
  Future<Either<OtpFailure, VerificationToken>> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  });
}
