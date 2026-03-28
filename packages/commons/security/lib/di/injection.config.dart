// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:commons_infra/http/i_http_client.dart' as _i285;
import 'package:commons_security/data/datasource/local/i_security_local_datasource.dart'
    as _i100;
import 'package:commons_security/data/datasource/local/security_local_datasource.dart'
    as _i101;
import 'package:commons_security/data/datasource/remote/i_security_remote_datasource.dart'
    as _i200;
import 'package:commons_security/data/datasource/remote/security_remote_datasource.dart'
    as _i201;
import 'package:commons_security/data/security_local_repository.dart' as _i301;
import 'package:commons_security/data/security_remote_repository.dart'
    as _i302;
import 'package:commons_security/domain/repository/i_security_local_repository.dart'
    as _i500;
import 'package:commons_security/domain/repository/i_security_remote_repository.dart'
    as _i501;
import 'package:commons_security/domain/usecase/authenticate_usecase.dart'
    as _i600;
import 'package:commons_security/domain/usecase/find_token_usecase.dart'
    as _i601;
import 'package:commons_security/domain/usecase/logout_usecase.dart' as _i602;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i700;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableSecurityX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initSecurity({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i100.ISecurityLocalDataSource>(
      () => _i101.SecurityLocalDataSource(gh<_i700.FlutterSecureStorage>()),
    );
    gh.factory<_i200.ISecurityRemoteDataSource>(
      () => _i201.SecurityRemoteDataSource(gh<_i285.IHttpClient>()),
    );
    gh.factory<_i500.ISecurityLocalRepository>(
      () => _i301.SecurityLocalRepository(gh<_i100.ISecurityLocalDataSource>()),
    );
    gh.factory<_i501.ISecurityRemoteRepository>(
      () =>
          _i302.SecurityRemoteRepository(gh<_i200.ISecurityRemoteDataSource>()),
    );
    gh.factory<_i600.AuthenticateUseCase>(
      () => _i600.AuthenticateUseCase(
        gh<_i501.ISecurityRemoteRepository>(),
        gh<_i500.ISecurityLocalRepository>(),
      ),
    );
    gh.factory<_i601.FindTokenUseCase>(
      () => _i601.FindTokenUseCase(gh<_i500.ISecurityLocalRepository>()),
    );
    gh.factory<_i602.LogoutUseCase>(
      () => _i602.LogoutUseCase(gh<_i500.ISecurityLocalRepository>()),
    );
    return this;
  }
}
