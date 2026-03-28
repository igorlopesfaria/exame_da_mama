import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:fpdart/fpdart.dart';

abstract class ISecurityLocalRepository {
  Future<Either<Failure, Token?>> findToken();

  /// Saves [token] locally. If [token] is null, clears any stored token.
  Future<Either<Failure, Unit>> saveToken(Token? token);
}
