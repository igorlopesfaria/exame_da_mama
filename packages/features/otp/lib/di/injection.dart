import 'package:feature_otp/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initOtp')
Future<void> configureOtpDependencies() async =>
    GetIt.instance.initOtp();
