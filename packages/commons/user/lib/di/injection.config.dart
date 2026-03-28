// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:commons_infra/http/i_http_client.dart' as _i285;
import 'package:commons_user/data/datasource/local/i_user_local_datasource.dart'
    as _i100;
import 'package:commons_user/data/datasource/local/user_local_datasource.dart'
    as _i101;
import 'package:commons_user/data/datasource/remote/i_user_remote_datasource.dart'
    as _i200;
import 'package:commons_user/data/datasource/remote/user_remote_datasource.dart'
    as _i201;
import 'package:commons_user/data/user_local_repository.dart' as _i301;
import 'package:commons_user/data/user_remote_repository.dart' as _i302;
import 'package:commons_user/domain/repository/i_user_local_repository.dart'
    as _i500;
import 'package:commons_user/domain/repository/i_user_remote_repository.dart'
    as _i501;
import 'package:commons_user/domain/usecase/find_user_usecase.dart' as _i600;
import 'package:commons_user/domain/usecase/logout_user_usecase.dart' as _i601;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i700;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableUserX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initUser({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i100.IUserLocalDataSource>(
      () => _i101.UserLocalDataSource(gh<_i700.FlutterSecureStorage>()),
    );
    gh.factory<_i200.IUserRemoteDataSource>(
      () => _i201.UserRemoteDataSource(gh<_i285.IHttpClient>()),
    );
    gh.factory<_i500.IUserLocalRepository>(
      () => _i301.UserLocalRepository(gh<_i100.IUserLocalDataSource>()),
    );
    gh.factory<_i501.IUserRemoteRepository>(
      () => _i302.UserRemoteRepository(gh<_i200.IUserRemoteDataSource>()),
    );
    gh.factory<_i600.FindUserUseCase>(
      () => _i600.FindUserUseCase(
        gh<_i501.IUserRemoteRepository>(),
        gh<_i500.IUserLocalRepository>(),
      ),
    );
    gh.factory<_i601.LogoutUserUseCase>(
      () => _i601.LogoutUserUseCase(gh<_i500.IUserLocalRepository>()),
    );
    return this;
  }
}
