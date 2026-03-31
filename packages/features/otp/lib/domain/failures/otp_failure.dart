sealed class OtpFailure { const OtpFailure(); }
class InvalidCode extends OtpFailure { const InvalidCode(); }
class TooManyAttempts extends OtpFailure { const TooManyAttempts(); }
class ServerError extends OtpFailure { const ServerError(); }
