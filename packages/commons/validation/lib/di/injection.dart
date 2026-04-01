import 'package:commons_validation/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initValidation')
Future<void> configureValidationDependencies() async =>
    GetIt.instance.initValidation();
