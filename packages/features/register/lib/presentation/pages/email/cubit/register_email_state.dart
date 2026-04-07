sealed class RegisterEmailState {
  const RegisterEmailState();
}

class RegisterEmailIdle extends RegisterEmailState {
  const RegisterEmailIdle();
}
// Future states: RegisterEmailLoading, RegisterEmailSuccess, RegisterEmailError
