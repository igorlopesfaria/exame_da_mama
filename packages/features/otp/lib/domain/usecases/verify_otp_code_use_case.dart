import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/model/verification_token.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyOtpCodeUseCase {
  const VerifyOtpCodeUseCase(this._repository, this._observability);

  final OtpRepository _repository;
  final IObservability _observability;

  Future<Either<Failure, OtpVerificationToken>> call(
    OtpChannel channel, {
    required String value,
    required String code,
  }) async {
    final result = await _repository.verifyCode(channel, value: value, code: code);
    return result.fold(
      (f) {
        final failure = _mapFailure(f);
        _observability.logger.error(
          'otp.verify_code.failed',
          attributes: {'channel': channel.name, 'failureType': failure.runtimeType.toString()},
        );
        return left(failure);
      },
      (token) {
        _observability.logger.info(
          'otp.verify_code.success',
          attributes: {'channel': channel.name},
        );
        return right(token);
      },
    );
  }

  Failure _mapFailure(Failure f) => switch (f) {
    BadRequestFailure()      => const InvalidCode(),
    TooManyRequestsFailure() => const TooManyAttempts(),
    _                        => f,
  };
}
