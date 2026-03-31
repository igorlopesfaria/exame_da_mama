import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_failure.freezed.dart';

@freezed
sealed class OtpFailure with _$OtpFailure {
  const factory OtpFailure.invalidCode() = InvalidCode;
  const factory OtpFailure.expiredCode() = ExpiredCode;
  const factory OtpFailure.tooManyAttempts() = TooManyAttempts;
  const factory OtpFailure.serverError() = ServerError;
}
