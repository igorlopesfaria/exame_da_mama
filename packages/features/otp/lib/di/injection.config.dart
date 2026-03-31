// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:feature_otp/data/datasources/otp_remote_data_source.dart'
    as _i1068;
import 'package:feature_otp/data/datasources/otp_remote_data_source_impl.dart'
    as _i369;
import 'package:feature_otp/data/repositories/otp_repository_impl.dart'
    as _i352;
import 'package:feature_otp/domain/repositories/otp_repository.dart' as _i174;
import 'package:feature_otp/domain/usecases/send_otp_code_use_case.dart'
    as _i273;
import 'package:feature_otp/domain/usecases/verify_otp_code_use_case.dart'
    as _i388;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initOtp({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1068.OtpRemoteDataSource>(
      () => _i369.OtpRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i174.OtpRepository>(
      () => _i352.OtpRepositoryImpl(gh<_i1068.OtpRemoteDataSource>()),
    );
    gh.lazySingleton<_i273.SendOtpCodeUseCase>(
      () => _i273.SendOtpCodeUseCase(gh<_i174.OtpRepository>()),
    );
    gh.lazySingleton<_i388.VerifyOtpCodeUseCase>(
      () => _i388.VerifyOtpCodeUseCase(gh<_i174.OtpRepository>()),
    );
    return this;
  }
}
