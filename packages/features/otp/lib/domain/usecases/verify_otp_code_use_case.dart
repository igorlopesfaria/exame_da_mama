import 'package:commons_observability/commons_observability.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyOtpCodeUseCase {
  const VerifyOtpCodeUseCase(this._repository, this._observability);

  final OtpRepository _repository;
  final IObservability _observability;

  Future<Either<OtpFailure, String>> call(
    OtpChannel channel, {
    required String value,
    required String code,
  }) async {
    final result = await _repository.verifyCode(channel, value: value, code: code);
    result.fold(
      (f) => _observability.logger.error(
        'otp.verify_code.failed',
        attributes: {'channel': channel.name, 'failureType': f.runtimeType.toString()},
      ),
      (_) => _observability.logger.info(
        'otp.verify_code.success',
        attributes: {'channel': channel.name},
      ),
    );
    return result;
  }
}
