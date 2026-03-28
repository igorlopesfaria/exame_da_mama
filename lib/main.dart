import 'package:exames_da_mama_app/di/app_injection.dart';
import 'package:exames_da_mama_app/start.dart';
import 'package:flutter/material.dart';
import 'package:flora/flora.dart';
import 'package:flutter/services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await configureAppDependencies();
  FloraThemeProvider.instance.setDesignSystemTheme();

  runApp(StartWidget());
}


