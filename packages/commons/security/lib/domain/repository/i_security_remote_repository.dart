import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:fpdart/fpdart.dart';

abstract class ISecurityRemoteRepository {
  Future<Either<Failure, Token>> authenticate(String cpf, String password);
}
