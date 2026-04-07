// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:feature_register/presentation/cubit/register_cubit.dart'
    as _i536;
import 'package:feature_register/presentation/pages/birthdate/cubit/register_birthdate_cubit.dart'
    as _i50;
import 'package:feature_register/presentation/pages/cpf/cubit/register_cpf_cubit.dart'
    as _i505;
import 'package:feature_register/presentation/pages/email/cubit/register_email_cubit.dart'
    as _i753;
import 'package:feature_register/presentation/pages/gender/cubit/register_gender_cubit.dart'
    as _i1043;
import 'package:feature_register/presentation/pages/name/cubit/register_name_cubit.dart'
    as _i410;
import 'package:feature_register/presentation/pages/password/cubit/register_password_cubit.dart'
    as _i673;
import 'package:feature_register/presentation/pages/phone/cubit/register_phone_cubit.dart'
    as _i901;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initRegister({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i536.RegisterCubit>(() => _i536.RegisterCubit());
    gh.factory<_i50.RegisterBirthdateCubit>(
      () => _i50.RegisterBirthdateCubit(),
    );
    gh.factory<_i505.RegisterCpfCubit>(() => _i505.RegisterCpfCubit());
    gh.factory<_i753.RegisterEmailCubit>(() => _i753.RegisterEmailCubit());
    gh.factory<_i1043.RegisterGenderCubit>(() => _i1043.RegisterGenderCubit());
    gh.factory<_i410.RegisterNameCubit>(() => _i410.RegisterNameCubit());
    gh.factory<_i673.RegisterPasswordCubit>(
      () => _i673.RegisterPasswordCubit(),
    );
    gh.factory<_i901.RegisterPhoneCubit>(() => _i901.RegisterPhoneCubit());
    return this;
  }
}
