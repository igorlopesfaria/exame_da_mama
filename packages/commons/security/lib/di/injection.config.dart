// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:commons_infra/http/i_http_client.dart' as _i285;
import 'package:commons_observability/commons_observability.dart' as _i731;
import 'package:commons_security/data/datasource/local/i_security_local_datasource.dart'
    as _i911;
import 'package:commons_security/data/datasource/local/security_local_datasource.dart'
    as _i1051;
import 'package:commons_security/data/datasource/remote/i_security_remote_datasource.dart'
    as _i510;
import 'package:commons_security/data/datasource/remote/security_remote_datasource.dart'
    as _i177;
import 'package:commons_security/data/security_local_repository.dart' as _i860;
import 'package:commons_security/data/security_remote_repository.dart' as _i199;
import 'package:commons_security/domain/repository/i_security_local_repository.dart'
    as _i582;
import 'package:commons_security/domain/repository/i_security_remote_repository.dart'
    as _i441;
import 'package:commons_security/domain/usecase/authenticate_usecase.dart'
    as _i33;
import 'package:commons_security/domain/usecase/find_token_usecase.dart'
    as _i969;
import 'package:commons_security/domain/usecase/logout_usecase.dart' as _i985;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initSecurity({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i911.ISecurityLocalDataSource>(
      () => _i1051.SecurityLocalDataSource(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i731.IObservability>(),
      ),
    );
    gh.factory<_i582.ISecurityLocalRepository>(
      () => _i860.SecurityLocalRepository(gh<_i911.ISecurityLocalDataSource>()),
    );
    gh.factory<_i510.ISecurityRemoteDataSource>(
      () => _i177.SecurityRemoteDataSource(gh<_i285.IHttpClient>()),
    );
    gh.factory<_i969.FindTokenUseCase>(
      () => _i969.FindTokenUseCase(
        gh<_i582.ISecurityLocalRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    gh.factory<_i985.LogoutUseCase>(
      () => _i985.LogoutUseCase(
        gh<_i582.ISecurityLocalRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    gh.factory<_i441.ISecurityRemoteRepository>(
      () =>
          _i199.SecurityRemoteRepository(gh<_i510.ISecurityRemoteDataSource>()),
    );
    gh.factory<_i33.AuthenticateUseCase>(
      () => _i33.AuthenticateUseCase(
        gh<_i441.ISecurityRemoteRepository>(),
        gh<_i582.ISecurityLocalRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    return this;
  }
}
