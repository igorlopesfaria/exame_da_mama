import 'dart:convert';

import 'package:commons_security/data/datasource/local/i_security_local_datasource.dart';
import 'package:commons_security/data/model/token_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _kTokenKey = 'token_cached';

@Injectable(as: ISecurityLocalDataSource)
class SecurityLocalDataSource implements ISecurityLocalDataSource {
  const SecurityLocalDataSource(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<TokenDto?> fetchToken() async {
    final raw = await _storage.read(key: _kTokenKey);
    if (raw == null) return null;
    return TokenDto.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> saveToken(TokenDto? dto) async {
    if (dto == null) {
      await _storage.delete(key: _kTokenKey);
    } else {
      await _storage.write(key: _kTokenKey, value: jsonEncode(dto.toJson()));
    }
  }
}
