import 'package:commons_navigation/commons_navigation.dart';
import 'package:feature_initialization/presentation/string/initialization_localizations.dart';
import 'package:feature_otp/presentation/string/otp_localizations.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';

import 'router/app_router.dart';

class StartWidget extends StatefulWidget {
  const StartWidget({super.key});

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  @override
  void initState() {
    super.initState();
    FloraThemeProvider.instance.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    FloraThemeProvider.instance.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FloraThemeProvider.instance.theme,
      navigatorKey: AppNavigator.key,
      initialRoute: AppPaths.splashRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
      localizationsDelegates: [
        ...InitializationLocalizations.localizationsDelegates,
        OtpLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt'), Locale('en')],
      builder: (context, child) => FloraToastOverlay(child: child!),
    );
  }
}
