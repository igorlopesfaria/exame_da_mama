import 'dart:convert';

import 'package:commons_user/data/datasource/local/i_user_local_datasource.dart';
import 'package:commons_user/data/model/user_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const _kUserKey = 'user_cached';

@Injectable(as: IUserLocalDataSource)
class UserLocalDataSource implements IUserLocalDataSource {
  const UserLocalDataSource(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<UserDto?> fetchUser() async {
    final raw = await _storage.read(key: _kUserKey);
    if (raw == null) return null;
    return UserDto.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> saveUser(UserDto dto) => _storage.write(
        key: _kUserKey,
        value: jsonEncode(dto.toJson()),
      );

  @override
  Future<void> clearUser() => _storage.delete(key: _kUserKey);
}
