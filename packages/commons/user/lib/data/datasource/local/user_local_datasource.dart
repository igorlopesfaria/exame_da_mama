import 'dart:convert';

import 'package:commons_observability/commons_observability.dart';
import 'package:commons_user/data/datasource/local/i_user_local_datasource.dart';
import 'package:commons_user/data/model/user_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _kUserKey = 'user_cached';

@Injectable(as: IUserLocalDataSource)
class UserLocalDataSource implements IUserLocalDataSource {
  const UserLocalDataSource(this._storage, this._observability);

  final FlutterSecureStorage _storage;
  final IObservability _observability;

  @override
  Future<UserDto?> fetchUser() async {
    try {
      final raw = await _storage.read(key: _kUserKey);
      _observability.logger.info(
        'user.local.fetch_user',
        attributes: {'found': raw != null},
      );
      if (raw == null) return null;
      return UserDto.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e, st) {
      _observability.logger.error(
        'user.local.fetch_user.failed',
        throwable: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> saveUser(UserDto dto) async {
    try {
      await _storage.write(key: _kUserKey, value: jsonEncode(dto.toJson()));
      _observability.logger.info('user.local.save_user');
    } catch (e, st) {
      _observability.logger.error(
        'user.local.save_user.failed',
        throwable: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _storage.delete(key: _kUserKey);
      _observability.logger.info('user.local.clear_user');
    } catch (e, st) {
      _observability.logger.error(
        'user.local.clear_user.failed',
        throwable: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
