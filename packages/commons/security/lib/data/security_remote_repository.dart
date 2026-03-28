import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/repository/base_repository.dart';
import 'package:commons_security/data/datasource/remote/i_security_remote_datasource.dart';
import 'package:commons_security/data/mapper/token_mapper.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ISecurityRemoteRepository)
class SecurityRemoteRepository extends BaseRepository
    implements ISecurityRemoteRepository {
  const SecurityRemoteRepository(this._dataSource);

  final ISecurityRemoteDataSource _dataSource;

  @override
  Future<Either<Failure, Token>> authenticate(
    String cpf,
    String password,
  ) => safeCall(() async {
        final dto = await _dataSource.authenticate(cpf, password);
        return TokenMapper.dtoToToken(dto);
      });
}
