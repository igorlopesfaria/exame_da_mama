sealed class RegisterPasswordState {
  const RegisterPasswordState();
}

class RegisterPasswordIdle extends RegisterPasswordState {
  const RegisterPasswordIdle();
}
// Future states: RegisterPasswordLoading, RegisterPasswordSuccess, RegisterPasswordError
