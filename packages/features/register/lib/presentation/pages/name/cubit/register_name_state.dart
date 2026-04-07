sealed class RegisterNameState {
  const RegisterNameState();
}

class RegisterNameIdle extends RegisterNameState {
  const RegisterNameIdle();
}
// Future states: RegisterNameLoading, RegisterNameSuccess, RegisterNameError
