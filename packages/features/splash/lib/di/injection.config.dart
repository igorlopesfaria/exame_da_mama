// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:commons_security/domain/usecase/find_token_usecase.dart'
    as _i300;
import 'package:commons_user/domain/usecase/find_user_usecase.dart' as _i301;
import 'package:feature_splash/domain/usecase/check_session_usecase.dart'
    as _i100;
import 'package:feature_splash/presentation/cubit/splash_cubit.dart' as _i200;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableSplashX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initSplash({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i100.CheckSessionUseCase>(
      () => _i100.CheckSessionUseCase(
        gh<_i300.FindTokenUseCase>(),
        gh<_i301.FindUserUseCase>(),
      ),
    );
    gh.factory<_i200.SplashCubit>(
      () => _i200.SplashCubit(gh<_i100.CheckSessionUseCase>()),
    );
    return this;
  }
}
