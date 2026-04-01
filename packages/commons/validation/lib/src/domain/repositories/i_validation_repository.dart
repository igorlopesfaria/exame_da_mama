import 'package:commons_infra/failures/app_failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IValidationRepository {
  Future<Either<Failure, Unit>> validateEmail(String email);
  Future<Either<Failure, Unit>> validatePhone(String phone);
  Future<Either<Failure, Unit>> validateCpf(String cpf);
}
