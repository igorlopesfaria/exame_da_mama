import 'package:feature_account_validation/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initAccountValidation')
Future<void> configureAccountValidationDependencies() async =>
    GetIt.instance.initAccountValidation();
