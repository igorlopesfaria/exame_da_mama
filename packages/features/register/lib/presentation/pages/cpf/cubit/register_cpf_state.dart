sealed class RegisterCpfState {
  const RegisterCpfState();
}

class RegisterCpfIdle extends RegisterCpfState {
  const RegisterCpfIdle();
}
// Future states: RegisterCpfLoading, RegisterCpfSuccess, RegisterCpfError
