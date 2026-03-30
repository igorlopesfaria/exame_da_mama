import 'dart:convert';

import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:commons_security/data/datasource/local/security_local_datasource.dart';
import 'package:commons_security/data/model/token_dto.dart';
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
  late SecurityLocalDataSource dataSource;

  const tDto = TokenDto(accessToken: 'access-abc', refreshToken: 'refresh-xyz');
  final tRaw = jsonEncode(tDto.toJson());

  setUp(() {
    mockStorage       = MockFlutterSecureStorage();
    mockLogger        = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.info(any(), attributes: any(named: 'attributes'))).thenReturn(null);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    dataSource = SecurityLocalDataSource(mockStorage, mockObservability);
  });

  group('SecurityLocalDataSource.fetchToken', () {
    test('returns TokenDto when token is stored', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => tRaw);

      final result = await dataSource.fetchToken();

      expect(result?.accessToken, tDto.accessToken);
      expect(result?.refreshToken, tDto.refreshToken);
    });

    test('returns null when no token is stored', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      final result = await dataSource.fetchToken();

      expect(result, isNull);
    });

    test('logs info with found=true when token exists', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => tRaw);

      await dataSource.fetchToken();

      verify(() => mockLogger.info(
        'security.local.fetch_token',
        attributes: {'found': true},
      )).called(1);
    });

    test('logs info with found=false when no token stored', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      await dataSource.fetchToken();

      verify(() => mockLogger.info(
        'security.local.fetch_token',
        attributes: {'found': false},
      )).called(1);
    });

    test('logs error and rethrows when storage throws', () async {
      final error = Exception('storage failure');
      when(() => mockStorage.read(key: any(named: 'key'))).thenThrow(error);

      await expectLater(() => dataSource.fetchToken(), throwsA(isA<Exception>()));

      verify(() => mockLogger.error(
        'security.local.fetch_token.failed',
        throwable: any(named: 'throwable'),
        attributes: any(named: 'attributes'),
        stackTrace: any(named: 'stackTrace'),
      )).called(1);
    });

    test('throws ParseException on malformed JSON', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => '{"wrong_key": "value"}');

      await expectLater(() => dataSource.fetchToken(), throwsA(isA<ParseException>()));
    });
  });

  group('SecurityLocalDataSource.saveToken', () {
    test('writes JSON when dto is provided', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await dataSource.saveToken(tDto);

      final captured = verify(
        () => mockStorage.write(key: any(named: 'key'), value: captureAny(named: 'value')),
      ).captured.single as String;
      final decoded = jsonDecode(captured) as Map<String, dynamic>;
      expect(decoded['access_token'], tDto.accessToken);
      expect(decoded['refresh_token'], tDto.refreshToken);
    });

    test('deletes token when dto is null', () async {
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await dataSource.saveToken(null);

      verify(() => mockStorage.delete(key: any(named: 'key'))).called(1);
      verifyNever(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')));
    });

    test('logs info with cleared=false when saving token', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await dataSource.saveToken(tDto);

      verify(() => mockLogger.info(
        'security.local.save_token',
        attributes: {'cleared': false},
      )).called(1);
    });

    test('logs info with cleared=true when clearing token', () async {
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await dataSource.saveToken(null);

      verify(() => mockLogger.info(
        'security.local.save_token',
        attributes: {'cleared': true},
      )).called(1);
    });

    test('logs error and rethrows when storage throws', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenThrow(Exception('write failure'));

      await expectLater(() => dataSource.saveToken(tDto), throwsA(isA<Exception>()));

      verify(() => mockLogger.error(
        'security.local.save_token.failed',
        throwable: any(named: 'throwable'),
        attributes: any(named: 'attributes'),
        stackTrace: any(named: 'stackTrace'),
      )).called(1);
    });
  });
}
