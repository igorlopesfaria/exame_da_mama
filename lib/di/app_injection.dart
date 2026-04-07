import 'package:commons_infra/di/injection.dart';
import 'package:commons_observability/di/injection.dart';
import 'package:commons_security/di/injection.dart';
import 'package:commons_user/di/injection.dart';
import 'package:commons_validation/di/injection.dart';
import 'package:feature_initialization/di/injection.dart';
import 'package:feature_otp/di/injection.dart';
import 'package:feature_register/di/injection.dart';
import 'package:feature_splash/di/injection.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initGetIt', preferRelativeImports: true)
Future<void> configureAppDependencies() async {
  // commons
  await configureObservabilityDependencies();
  await configureInfraDependencies();
  await configureValidationDependencies();
  await configureOtpDependencies();
  await configureUserDependencies();
  await configureSecurityDependencies();

  // features
  await configureSplashDependencies();
  await configureInitializationDependencies();
  await configureRegisterDependencies();
}
