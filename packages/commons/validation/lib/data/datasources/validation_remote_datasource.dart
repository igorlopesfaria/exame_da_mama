import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/http/i_http_client.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

abstract interface class IValidationRemoteDatasource {
  Future<Either<Failure, Unit>> validateEmail(String email);
  Future<Either<Failure, Unit>> validatePhone(String phone);
  Future<Either<Failure, Unit>> validateCpf(String cpf);
}

@Injectable(as: IValidationRemoteDatasource)
class ValidationRemoteDatasource implements IValidationRemoteDatasource {
  const ValidationRemoteDatasource(this._httpClient);

  final IHttpClient _httpClient;

  @override
  Future<Either<Failure, Unit>> validateEmail(String email) async {
    // TODO: implement endpoint
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> validatePhone(String phone) async {
    // TODO: implement endpoint
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> validateCpf(String cpf) async {
    // TODO: implement endpoint
    throw UnimplementedError();
  }
}
