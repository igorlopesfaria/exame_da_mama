import 'package:feature_initialization/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initInitialization')
Future<void> configureInitializationDependencies() async =>
    GetIt.instance.initInitialization();
