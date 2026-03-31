sealed class OtpFailure {
  const OtpFailure();
}

class InvalidCode extends OtpFailure {
  const InvalidCode();
}

class ExpiredCode extends OtpFailure {
  const ExpiredCode();
}

class TooManyAttempts extends OtpFailure {
  const TooManyAttempts();
}

class ServerError extends OtpFailure {
  const ServerError();
}
