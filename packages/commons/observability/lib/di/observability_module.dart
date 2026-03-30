import 'package:commons_observability/api/i_observability.dart';
import 'package:commons_observability/impl/observability_impl.dart';
import 'package:commons_observability/vendor/crashlytics_provider.dart';
import 'package:commons_observability/vendor/i_vendor_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ObservabilityModule {
  @singleton
  IVendorProvider get vendorProvider =>
      CrashlyticsProvider(FirebaseCrashlytics.instance);

  @singleton
  IObservability observability(IVendorProvider vendor) =>
      ObservabilityImpl(vendor: vendor);
}
