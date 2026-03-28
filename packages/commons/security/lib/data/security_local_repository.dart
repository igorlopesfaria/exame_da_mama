import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/repository/base_repository.dart';
import 'package:commons_security/data/datasource/local/i_security_local_datasource.dart';
import 'package:commons_security/data/mapper/token_mapper.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ISecurityLocalRepository)
class SecurityLocalRepository extends BaseRepository
    implements ISecurityLocalRepository {
  const SecurityLocalRepository(this._dataSource);

  final ISecurityLocalDataSource _dataSource;

  @override
  Future<Either<Failure, Token?>> findToken() => safeCall(() async {
        final dto = await _dataSource.fetchToken();
        return dto == null ? null : TokenMapper.dtoToToken(dto);
      });

  @override
  Future<Either<Failure, Unit>> saveToken(Token? token) =>
      safeCall(() async {
        await _dataSource.saveToken(
          token == null ? null : TokenMapper.tokenToDto(token),
        );
        return unit;
      });
}
