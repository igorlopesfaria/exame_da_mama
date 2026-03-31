import 'dart:convert';

import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_user/data/datasource/local/user_local_datasource.dart';
import 'package:commons_user/data/model/user_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late UserLocalDataSource dataSource;

  const tDto = UserDto(
    id:        '1',
    cpf:       '12345678901',
    name:      'Test User',
    birthdate: '1990-01-01',
    gender:    'female',
    email:     'test@test.com',
    phone:     '11999999999',
  );
  final tRaw = jsonEncode(tDto.toJson());

  setUp(() {
    mockStorage       = MockFlutterSecureStorage();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.info(any())).thenReturn(null);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    dataSource = UserLocalDataSource(mockStorage, mockObservability);
  });

  group('UserLocalDataSource.fetchUser', () {
    test('returns UserDto when user is stored', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => tRaw);

      final result = await dataSource.fetchUser();

      expect(result?.id, tDto.id);
      expect(result?.name, tDto.name);
    });

    test('returns null when no user is stored', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      final result = await dataSource.fetchUser();

      expect(result, isNull);
    });

    test('logs info with found=true when user exists', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => tRaw);

      await dataSource.fetchUser();

      verify(() => mockLogger.info(
        'user.local.fetch_user',
        attributes: {'found': true},
      )).called(1);
    });

    test('logs info with found=false when no user stored', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      await dataSource.fetchUser();

      verify(() => mockLogger.info(
        'user.local.fetch_user',
        attributes: {'found': false},
      )).called(1);
    });

    test('logs error and rethrows when storage throws', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenThrow(Exception('storage failure'));

      await expectLater(() => dataSource.fetchUser(), throwsA(isA<Exception>()));

      verify(() => mockLogger.error(
        'user.local.fetch_user.failed',
        throwable: any(named: 'throwable'),
        attributes: any(named: 'attributes'),
        stackTrace: any(named: 'stackTrace'),
      )).called(1);
    });

    test('throws ParseException on malformed JSON', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => '{"wrong_key": "value"}');

      await expectLater(() => dataSource.fetchUser(), throwsA(isA<ParseException>()));
    });
  });

  group('UserLocalDataSource.saveUser', () {
    test('writes JSON to storage', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await dataSource.saveUser(tDto);

      final captured = verify(
        () => mockStorage.write(key: any(named: 'key'), value: captureAny(named: 'value')),
      ).captured.single as String;
      final decoded = jsonDecode(captured) as Map<String, dynamic>;
      expect(decoded['id'], tDto.id);
      expect(decoded['name'], tDto.name);
    });

    test('logs info on success', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await dataSource.saveUser(tDto);

      verify(() => mockLogger.info('user.local.save_user')).called(1);
    });

    test('logs error and rethrows when storage throws', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenThrow(Exception('write failure'));

      await expectLater(() => dataSource.saveUser(tDto), throwsA(isA<Exception>()));

      verify(() => mockLogger.error(
        'user.local.save_user.failed',
        throwable: any(named: 'throwable'),
        attributes: any(named: 'attributes'),
        stackTrace: any(named: 'stackTrace'),
      )).called(1);
    });
  });

  group('UserLocalDataSource.clearUser', () {
    test('deletes user from storage', () async {
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await dataSource.clearUser();

      verify(() => mockStorage.delete(key: any(named: 'key'))).called(1);
    });

    test('logs info on success', () async {
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await dataSource.clearUser();

      verify(() => mockLogger.info('user.local.clear_user')).called(1);
    });

    test('logs error and rethrows when storage throws', () async {
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenThrow(Exception('delete failure'));

      await expectLater(() => dataSource.clearUser(), throwsA(isA<Exception>()));

      verify(() => mockLogger.error(
        'user.local.clear_user.failed',
        throwable: any(named: 'throwable'),
        attributes: any(named: 'attributes'),
        stackTrace: any(named: 'stackTrace'),
      )).called(1);
    });
  });
}
