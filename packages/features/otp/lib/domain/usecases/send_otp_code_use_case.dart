import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendOtpCodeUseCase {
  const SendOtpCodeUseCase(this._repository);

  final OtpRepository _repository;

  Future<Either<OtpFailure, Unit>> call(OtpChannel channel, String value) =>
      _repository.sendCode(channel, value);
}
