import 'package:commons_user/domain/model/user.dart';

sealed class SessionResult {
  const SessionResult();
}

class SessionAuthenticated extends SessionResult {
  const SessionAuthenticated(this.user);
  final User user;
}

class SessionPendingTerms extends SessionResult {
  const SessionPendingTerms(this.user);
  final User user;
}

class SessionForceUpdate extends SessionResult {
  const SessionForceUpdate();
}

class SessionUnauthenticated extends SessionResult {
  const SessionUnauthenticated();
}
