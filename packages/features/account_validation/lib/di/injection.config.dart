// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:feature_account_validation/domain/usecase/validate_account_usecase.dart'
    as _i856;
import 'package:feature_account_validation/presentation/cubit/account_validation_cubit.dart'
    as _i146;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initAccountValidation({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i856.ValidateAccountUseCase>(
      () => const _i856.ValidateAccountUseCase(),
    );
    gh.factory<_i146.AccountValidationCubit>(
      () => _i146.AccountValidationCubit(gh<_i856.ValidateAccountUseCase>()),
    );
    return this;
  }
}
