import 'package:feature_register/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initRegister')
Future<void> configureRegisterDependencies() async =>
    GetIt.instance.initRegister();
