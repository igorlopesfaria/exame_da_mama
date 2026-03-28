import 'package:commons_security/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initSecurity')
Future<void> configureSecurityDependencies() async =>
    GetIt.instance.initSecurity();
