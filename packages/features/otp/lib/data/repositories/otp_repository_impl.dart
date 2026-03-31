import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/repository/base_repository.dart';
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/model/verification_token.dart';
import 'package:feature_otp/domain/repositories/otp_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OtpRepository)
class OtpRepositoryImpl extends BaseRepository implements OtpRepository {
  const OtpRepositoryImpl(this._dataSource);

  final OtpRemoteDataSource _dataSource;

  @override
  Future<Either<Failure, int>> sendCode(OtpChannel channel, String value) =>
      safeCall(() => _dataSource.sendCode(channel, value));

  @override
  Future<Either<Failure, VerificationToken>> verifyCode(
    OtpChannel channel, {
    required String value,
    required String code,
  }) =>
      safeCall(() => _dataSource
          .verifyCode(channel, value: value, code: code)
          .then((r) => r.verificationToken));
}
