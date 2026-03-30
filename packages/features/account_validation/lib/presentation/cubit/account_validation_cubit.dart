import 'package:feature_account_validation/domain/model/account_validation_result.dart';
import 'package:feature_account_validation/domain/usecase/validate_account_usecase.dart';
import 'package:feature_account_validation/presentation/cubit/account_validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountValidationCubit extends Cubit<AccountValidationState> {
  AccountValidationCubit(this._validateAccount) : super(const AccountValidationInitial());

  final ValidateAccountUseCase _validateAccount;

  Future<void> validate() async {
    emit(const AccountValidationLoading());

    final result = await _validateAccount();

    switch (result) {
      case AccountValidated():
        emit(const AccountValidationSuccess());
      case AccountValidationFailed(:final message):
        emit(AccountValidationError(message));
    }
  }
}
