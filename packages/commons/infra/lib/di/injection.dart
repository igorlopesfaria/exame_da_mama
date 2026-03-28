import 'package:commons_infra/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
Future<void> configureInfraDependencies() async => GetIt.instance.init();
