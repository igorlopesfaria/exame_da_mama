import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendOtpCodeUseCase {
  const SendOtpCodeUseCase(this._repository, this._observability);

  final OtpRepository _repository;
  final IObservability _observability;

  Future<Either<OtpFailure, Unit>> call(OtpChannel channel, String value) async {
    final result = await _repository.sendCode(channel, value);
    return result.fold(
      (f) {
        final failure = _mapFailure(f);
        _observability.logger.error(
          'otp.send_code.failed',
          attributes: {'channel': channel.name, 'failureType': failure.runtimeType.toString()},
        );
        return left(failure);
      },
      (v) {
        _observability.logger.info(
          'otp.send_code.success',
          attributes: {'channel': channel.name},
        );
        return right(v);
      },
    );
  }

  OtpFailure _mapFailure(Failure f) => switch (f) {
    TooManyRequestsFailure() => const TooManyAttempts(),
    _                        => const ServerError(),
  };
}
