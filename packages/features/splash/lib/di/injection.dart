import 'package:feature_splash/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initSplash')
Future<void> configureSplashDependencies() async =>
    GetIt.instance.initSplash();
