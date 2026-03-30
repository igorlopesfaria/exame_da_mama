import 'package:commons_infra/commons_infra.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:exames_da_mama_app/di/app_injection.dart';
import 'package:exames_da_mama_app/firebase_options.dart';
import 'package:exames_da_mama_app/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flora/flora.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late final FirebaseApp app;
  try {
    app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    app = Firebase.app();
  }
  AppEnvironment.validate();
  debugPrint('[App] Environment: ${AppEnvironment.name} | baseUrl: ${AppEnvironment.baseUrl}');
  debugPrint('[Firebase] Connected ✓ — project: ${app.options.projectId}');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await configureAppDependencies();

  _setupCrashReporting();

  FloraThemeProvider.instance.setDesignSystemTheme();
  runApp(StartWidget());
}

void _setupCrashReporting() {
  final observability = GetIt.instance<IObservability>();

  // Disable Crashlytics in mock/debug so reports don't pollute the dashboard.
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    !AppEnvironment.isMock && !kDebugMode,
  );

  observability.setCustomKey('environment', AppEnvironment.name);

  // Catch errors thrown inside the Flutter framework (widget build, layout, etc).
  FlutterError.onError = (details) {
    observability.logger.fatal(
      'flutter.framework_error',
      throwable: details.exception,
      stackTrace: details.stack,
      attributes: {'context': details.context?.toDescription() ?? 'unknown'},
    );
  };

  // Catch async errors that escape the Flutter zone (platform channels, isolates).
  PlatformDispatcher.instance.onError = (error, stack) {
    observability.logger.fatal(
      'flutter.platform_error',
      throwable: error,
      stackTrace: stack,
    );
    return true;
  };
}
