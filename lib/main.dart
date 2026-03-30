import 'package:commons_infra/commons_infra.dart';
import 'package:exames_da_mama_app/di/app_injection.dart';
import 'package:exames_da_mama_app/firebase_options.dart';
import 'package:exames_da_mama_app/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late final FirebaseApp app;
  try {
    app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    app = Firebase.app();
  }
  debugPrint('[App] Environment: ${AppEnvironment.name} | baseUrl: ${AppEnvironment.baseUrl}');
  debugPrint('[Firebase] Connected ✓ — project: ${app.options.projectId}');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await configureAppDependencies();
  FloraThemeProvider.instance.setDesignSystemTheme();
  runApp(StartWidget());
}
