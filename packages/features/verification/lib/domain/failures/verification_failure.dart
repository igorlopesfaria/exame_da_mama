import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_failure.freezed.dart';

@freezed
sealed class VerificationFailure with _$VerificationFailure {
  const factory VerificationFailure.invalidCode() = InvalidCode;
  const factory VerificationFailure.expiredCode() = ExpiredCode;
  const factory VerificationFailure.tooManyAttempts() = TooManyAttempts;
  const factory VerificationFailure.serverError() = ServerError;
}
