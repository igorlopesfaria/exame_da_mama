import 'package:commons_infra/di/injection.dart';
import 'package:commons_observability/di/injection.dart';
import 'package:commons_security/di/injection.dart';
import 'package:commons_user/di/injection.dart';
import 'package:feature_account_validation/di/injection.dart';
import 'package:feature_initialization/di/injection.dart';
import 'package:feature_splash/di/injection.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initGetIt', preferRelativeImports: true)
Future<void> configureAppDependencies() async {
  await configureObservabilityDependencies();
  await configureInfraDependencies();
  await configureUserDependencies();
  await configureSecurityDependencies();
  await configureSplashDependencies();
  await configureInitializationDependencies();
  await configureAccountValidationDependencies();
}
