import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/repository/base_repository.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/data/models/request/otp_send_code_request.dart';
import 'package:feature_otp/data/models/request/otp_verify_code_request.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/model/otp_next_request_in.dart';
import 'package:feature_otp/domain/model/verification_token.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtpRepository)
class OtpRepositoryImpl extends BaseRepository implements OtpRepository {
  const OtpRepositoryImpl(this._dataSource);

  final OtpRemoteDataSource _dataSource;

  @override
  Future<Either<Failure, OtpNextRequestIn>> sendCode(OtpChannel channel, String value) =>
      safeCall(() => _dataSource
          .sendCode(OtpSendCodeRequest(channel: channel, value: value))
          .then((r) => r.otpNextRequestIn));

  @override
  Future<Either<Failure, OtpVerificationToken>> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  }) =>
      safeCall(() => _dataSource
          .verifyCode(OtpVerifyCodeRequest(
            channel: channel,
            value: value,
            code: code,
          ))
          .then((r) => r.otpVerificationToken));
}
