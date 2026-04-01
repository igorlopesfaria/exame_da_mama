import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_validation/src/data/datasources/validation_remote_datasource.dart';
import 'package:commons_validation/src/domain/repositories/i_validation_repository.dart';
import 'package:fpdart/fpdart.dart';

class ValidationRepositoryImpl implements IValidationRepository {
  const ValidationRepositoryImpl(this._datasource);

  final IValidationRemoteDatasource _datasource;

  @override
  Future<Either<Failure, Unit>> validateEmail(String email) =>
      _datasource.validateEmail(email);

  @override
  Future<Either<Failure, Unit>> validatePhone(String phone) =>
      _datasource.validatePhone(phone);

  @override
  Future<Either<Failure, Unit>> validateCpf(String cpf) =>
      _datasource.validateCpf(cpf);
}
