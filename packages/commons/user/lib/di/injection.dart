import 'package:commons_user/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initUser')
Future<void> configureUserDependencies() async => GetIt.instance.initUser();
