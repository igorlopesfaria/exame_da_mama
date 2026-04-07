import 'package:commons_infra/failures/app_failures.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/model/otp_next_request_in.dart';
import 'package:feature_otp/domain/model/verification_token.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OtpRepository {
  Future<Either<Failure, OtpNextRequestIn>> sendCode(OtpChannel channel, String value);
  Future<Either<Failure, OtpVerificationToken>> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  });
}
