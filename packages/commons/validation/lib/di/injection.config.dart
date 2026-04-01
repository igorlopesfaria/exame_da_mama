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
import 'package:commons_validation/data/datasources/validation_remote_datasource.dart'
    as _i398;
import 'package:commons_validation/data/repositories/validation_repository_impl.dart'
    as _i1066;
import 'package:commons_validation/domain/repositories/i_validation_repository.dart'
    as _i1065;
import 'package:commons_validation/domain/usecases/validate_cpf_usecase.dart'
    as _i888;
import 'package:commons_validation/domain/usecases/validate_email_usecase.dart'
    as _i895;
import 'package:commons_validation/domain/usecases/validate_password_usecase.dart'
    as _i247;
import 'package:commons_validation/domain/usecases/validate_phone_usecase.dart'
    as _i609;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initValidation({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i247.ValidatePasswordUseCase>(
      () => _i247.ValidatePasswordUseCase(gh<_i731.IObservability>()),
    );
    gh.factory<_i398.IValidationRemoteDatasource>(
      () => _i398.ValidationRemoteDatasource(gh<_i285.IHttpClient>()),
    );
    gh.factory<_i1065.IValidationRepository>(
      () => _i1066.ValidationRepositoryImpl(
        gh<_i398.IValidationRemoteDatasource>(),
      ),
    );
    gh.factory<_i888.ValidateCpfUseCase>(
      () => _i888.ValidateCpfUseCase(
        gh<_i1065.IValidationRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    gh.factory<_i895.ValidateEmailUseCase>(
      () => _i895.ValidateEmailUseCase(
        gh<_i1065.IValidationRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    gh.factory<_i609.ValidatePhoneUseCase>(
      () => _i609.ValidatePhoneUseCase(
        gh<_i1065.IValidationRepository>(),
        gh<_i731.IObservability>(),
      ),
    );
    return this;
  }
}
