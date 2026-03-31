import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class FindTokenUseCase {
  const FindTokenUseCase(this._localRepository, this._observability);

  final ISecurityLocalRepository _localRepository;
  final IObservability _observability;

  Future<Either<Failure, Token?>> call() async {
    final result = await _localRepository.findToken();
    result.fold(
      (f) => _observability.logger.error(
        'auth.find_token.failed',
        attributes: {'failureType': f.runtimeType.toString()},
      ),
      (token) => _observability.logger.info(
        'auth.find_token.success',
        attributes: {'hasToken': token != null},
      ),
    );
    return result;
  }
}
