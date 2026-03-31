import 'package:commons_observability/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initObservability')
Future<void> configureObservabilityDependencies() async =>
    GetIt.instance.initObservability();
