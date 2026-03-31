enum OtpChannel {
  email,
  phone;

  /// Body key and path segment used in API requests.
  String get key => name;

  /// POST /verification-codes/{email|phone}
  String get sendPath => '/verification-codes/$name';

  /// POST /verification-codes/{email|phone}/verify
  String get verifyPath => '/verification-codes/$name/verify';
}
