sealed class AccountValidationResult {
  const AccountValidationResult();
}

class AccountValidated extends AccountValidationResult {
  const AccountValidated();
}

class AccountValidationFailed extends AccountValidationResult {
  const AccountValidationFailed(this.message);
  final String message;
}
