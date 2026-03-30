import 'package:feature_verification/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initVerification')
Future<void> configureVerificationDependencies() async =>
    GetIt.instance.initVerification();
