import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyOtpCodeUseCase {
  const VerifyOtpCodeUseCase(this._repository);

  final OtpRepository _repository;

  Future<Either<OtpFailure, String>> call(
    OtpChannel channel, {
    required String value,
    required String code,
  }) =>
      _repository.verifyCode(channel, value: value, code: code);
}
