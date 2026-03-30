import 'package:feature_account_validation/domain/model/account_validation_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ValidateAccountUseCase {
  const ValidateAccountUseCase();

  Future<AccountValidationResult> call() async {
    return const AccountValidated();
  }
}
