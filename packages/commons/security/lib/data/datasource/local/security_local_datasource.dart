import 'dart:convert';

import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/data/datasource/local/i_security_local_datasource.dart';
import 'package:commons_security/data/model/token_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _kTokenKey = 'token_cached';

@Injectable(as: ISecurityLocalDataSource)
class SecurityLocalDataSource implements ISecurityLocalDataSource {
  const SecurityLocalDataSource(this._storage, this._observability);

  final FlutterSecureStorage _storage;
  final IObservability _observability;

  @override
  Future<TokenDto?> fetchToken() async {
    try {
      final raw = await _storage.read(key: _kTokenKey);
      _observability.logger.info(
        'security.local.fetch_token',
        attributes: {'found': raw != null},
      );
      if (raw == null) return null;
      return TokenDto.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e, st) {
      _observability.logger.error(
        'security.local.fetch_token.failed',
        throwable: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> saveToken(TokenDto? dto) async {
    try {
      if (dto == null) {
        await _storage.delete(key: _kTokenKey);
      } else {
        await _storage.write(key: _kTokenKey, value: jsonEncode(dto.toJson()));
      }
      _observability.logger.info(
        'security.local.save_token',
        attributes: {'cleared': dto == null},
      );
    } catch (e, st) {
      _observability.logger.error(
        'security.local.save_token.failed',
        throwable: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
