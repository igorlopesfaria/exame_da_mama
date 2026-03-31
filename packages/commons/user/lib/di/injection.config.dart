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
import 'package:commons_user/data/datasource/local/i_user_local_datasource.dart'
    as _i1033;
import 'package:commons_user/data/datasource/local/user_local_datasource.dart'
    as _i2;
import 'package:commons_user/data/datasource/remote/i_user_remote_datasource.dart'
    as _i432;
import 'package:commons_user/data/datasource/remote/user_remote_datasource.dart'
    as _i50;
import 'package:commons_user/data/user_local_repository.dart' as _i94;
import 'package:commons_user/data/user_remote_repository.dart' as _i1022;
import 'package:commons_user/domain/repository/i_user_local_repository.dart'
    as _i173;
import 'package:commons_user/domain/repository/i_user_remote_repository.dart'
    as _i455;
import 'package:commons_user/domain/usecase/find_user_usecase.dart' as _i940;
import 'package:commons_user/domain/usecase/logout_user_usecase.dart' as _i464;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initUser({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1033.IUserLocalDataSource>(
      () => _i2.UserLocalDataSource(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i731.IObservability>(),
      ),
    );
    gh.factory<_i173.IUserLocalRepository>(
      () => _i94.UserLocalRepository(gh<_i1033.IUserLocalDataSource>()),
    );
    gh.factory<_i432.IUserRemoteDataSource>(
      () => _i50.UserRemoteDataSource(gh<_i285.IHttpClient>()),
    );
    gh.factory<_i464.LogoutUserUseCase>(
      () => _i464.LogoutUserUseCase(
        gh<_i173.IUserLocalRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    gh.factory<_i455.IUserRemoteRepository>(
      () => _i1022.UserRemoteRepository(gh<_i432.IUserRemoteDataSource>()),
    );
    gh.factory<_i940.FindUserUseCase>(
      () => _i940.FindUserUseCase(
        gh<_i455.IUserRemoteRepository>(),
        gh<_i173.IUserLocalRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    return this;
  }
}
