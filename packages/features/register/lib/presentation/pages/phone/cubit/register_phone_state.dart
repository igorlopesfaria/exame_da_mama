sealed class RegisterPhoneState {
  const RegisterPhoneState();
}

class RegisterPhoneIdle extends RegisterPhoneState {
  const RegisterPhoneIdle();
}
// Future states: RegisterPhoneLoading, RegisterPhoneSuccess, RegisterPhoneError
