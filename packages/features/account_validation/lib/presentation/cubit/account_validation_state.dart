sealed class AccountValidationState {
  const AccountValidationState();
}

class AccountValidationInitial extends AccountValidationState {
  const AccountValidationInitial();
}

class AccountValidationLoading extends AccountValidationState {
  const AccountValidationLoading();
}

class AccountValidationSuccess extends AccountValidationState {
  const AccountValidationSuccess();
}

class AccountValidationError extends AccountValidationState {
  const AccountValidationError(this.message);
  final String message;
}
