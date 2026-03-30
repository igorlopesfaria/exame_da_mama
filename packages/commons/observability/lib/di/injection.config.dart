// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:commons_observability/api/i_observability.dart' as _i445;
import 'package:commons_observability/di/observability_module.dart' as _i464;
import 'package:commons_observability/vendor/i_vendor_provider.dart' as _i80;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initObservability({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final observabilityModule = _$ObservabilityModule();
    gh.singleton<_i141.FirebaseCrashlytics>(
      () => observabilityModule.crashlytics,
    );
    gh.singleton<_i80.IVendorProvider>(
      () => observabilityModule.vendorProvider(gh<_i141.FirebaseCrashlytics>()),
    );
    gh.singleton<_i445.IObservability>(
      () => observabilityModule.observability(gh<_i80.IVendorProvider>()),
    );
    return this;
  }
}

class _$ObservabilityModule extends _i464.ObservabilityModule {}
