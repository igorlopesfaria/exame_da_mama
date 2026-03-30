// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:feature_verification/data/datasources/verification_remote_data_source.dart'
    as _i666;
import 'package:feature_verification/data/datasources/verification_remote_data_source_impl.dart'
    as _i613;
import 'package:feature_verification/data/repositories/verification_repository_impl.dart'
    as _i382;
import 'package:feature_verification/domain/repositories/verification_repository.dart'
    as _i934;
import 'package:feature_verification/domain/usecases/send_email_verification_code_use_case.dart'
    as _i684;
import 'package:feature_verification/domain/usecases/send_phone_verification_code_use_case.dart'
    as _i751;
import 'package:feature_verification/domain/usecases/verify_email_code_use_case.dart'
    as _i9;
import 'package:feature_verification/domain/usecases/verify_phone_code_use_case.dart'
    as _i820;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initVerification({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i666.VerificationRemoteDataSource>(
      () => _i613.VerificationRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i934.VerificationRepository>(
      () => _i382.VerificationRepositoryImpl(
        gh<_i666.VerificationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i684.SendEmailVerificationCodeUseCase>(
      () => _i684.SendEmailVerificationCodeUseCase(
        gh<_i934.VerificationRepository>(),
      ),
    );
    gh.lazySingleton<_i751.SendPhoneVerificationCodeUseCase>(
      () => _i751.SendPhoneVerificationCodeUseCase(
        gh<_i934.VerificationRepository>(),
      ),
    );
    gh.lazySingleton<_i9.VerifyEmailCodeUseCase>(
      () => _i9.VerifyEmailCodeUseCase(gh<_i934.VerificationRepository>()),
    );
    gh.lazySingleton<_i820.VerifyPhoneCodeUseCase>(
      () => _i820.VerifyPhoneCodeUseCase(gh<_i934.VerificationRepository>()),
    );
    return this;
  }
}
