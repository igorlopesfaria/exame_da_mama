import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/http/http_client.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}
class MockObservability extends Mock implements IObservability {}
class MockLogger extends Mock implements ILogger {}

void main() {
  late MockDio mockDio;
  late MockObservability mockObservability;
  late MockLogger mockLogger;
  late HttpClient client;

  final requestOptions = RequestOptions(path: '/test');
  final successData = <String, dynamic>{'id': 1, 'name': 'test'};
  final successResponse = Response<dynamic>(
    requestOptions: requestOptions,
    statusCode: 200,
    data: successData,
  );

  setUp(() {
    mockDio = MockDio();
    mockLogger = MockLogger();
    mockObservability = MockObservability();
    when(() => mockObservability.logger).thenReturn(mockLogger);
    when(() => mockLogger.error(any(), throwable: any(named: 'throwable'), attributes: any(named: 'attributes'), stackTrace: any(named: 'stackTrace'))).thenReturn(null);
    client = HttpClient(mockDio, mockObservability);
  });

  DioException _dioError(DioExceptionType type, {int? statusCode, Map<String, dynamic>? data}) {
    return DioException(
      type: type,
      requestOptions: requestOptions,
      response: statusCode != null
          ? Response(requestOptions: requestOptions, statusCode: statusCode, data: data)
          : null,
    );
  }

  group('HttpClient.get', () {
    test('returns parsed map on success', () async {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => successResponse);

      final result = await client.get('/test');
      expect(result, successData);
    });

    test('passes queryParameters to Dio', () async {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => successResponse);

      await client.get('/test', params: {'page': '1'});

      final captured = verify(
        () => mockDio.get<dynamic>(any(), queryParameters: captureAny(named: 'queryParameters')),
      ).captured.single;
      expect(captured, {'page': '1'});
    });

    test('throws ParseException when response data is a list', () {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(requestOptions: requestOptions, data: [1, 2, 3]));

      expect(() => client.get('/test'), throwsA(isA<ParseException>()));
    });

    test('throws ParseException when response data is a string', () {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(requestOptions: requestOptions, data: 'plain string'));

      expect(() => client.get('/test'), throwsA(isA<ParseException>()));
    });

    test('throws NetworkException on connectionError', () {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(_dioError(DioExceptionType.connectionError));

      expect(() => client.get('/test'), throwsA(isA<NetworkException>()));
    });

    test('throws NetworkException on connectionTimeout', () {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(_dioError(DioExceptionType.connectionTimeout));

      expect(() => client.get('/test'), throwsA(isA<NetworkException>()));
    });

    test('throws UnauthorizedException on 401', () {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(_dioError(DioExceptionType.badResponse, statusCode: 401));

      expect(() => client.get('/test'), throwsA(isA<UnauthorizedException>()));
    });

    test('throws NotFoundException on 404', () {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(_dioError(DioExceptionType.badResponse, statusCode: 404));

      expect(() => client.get('/test'), throwsA(isA<NotFoundException>()));
    });

    test('throws ServerException on 500', () {
      when(() => mockDio.get<dynamic>(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(_dioError(
            DioExceptionType.badResponse,
            statusCode: 500,
            data: {'message': 'Internal error'},
          ));

      expect(() => client.get('/test'), throwsA(isA<ServerException>()));
    });
  });

  group('HttpClient.post', () {
    test('returns parsed map on success', () async {
      when(() => mockDio.post<dynamic>(any(), data: any(named: 'data')))
          .thenAnswer((_) async => successResponse);

      final result = await client.post('/test', data: {'key': 'value'});
      expect(result, successData);
    });

    test('throws ParseException when response data is not a map', () {
      when(() => mockDio.post<dynamic>(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(requestOptions: requestOptions, data: 'not a map'));

      expect(() => client.post('/test'), throwsA(isA<ParseException>()));
    });

    test('throws NetworkException on receiveTimeout', () {
      when(() => mockDio.post<dynamic>(any(), data: any(named: 'data')))
          .thenThrow(_dioError(DioExceptionType.receiveTimeout));

      expect(() => client.post('/test'), throwsA(isA<NetworkException>()));
    });
  });

  group('HttpClient.put', () {
    test('returns parsed map on success', () async {
      when(() => mockDio.put<dynamic>(any(), data: any(named: 'data')))
          .thenAnswer((_) async => successResponse);

      final result = await client.put('/test', data: {'key': 'value'});
      expect(result, successData);
    });

    test('throws UnauthorizedException on 401', () {
      when(() => mockDio.put<dynamic>(any(), data: any(named: 'data')))
          .thenThrow(_dioError(DioExceptionType.badResponse, statusCode: 401));

      expect(() => client.put('/test'), throwsA(isA<UnauthorizedException>()));
    });
  });

  group('HttpClient.delete', () {
    test('returns parsed map on success', () async {
      when(() => mockDio.delete<dynamic>(any(), data: any(named: 'data')))
          .thenAnswer((_) async => successResponse);

      final result = await client.delete('/test');
      expect(result, successData);
    });

    test('throws NotFoundException on 404', () {
      when(() => mockDio.delete<dynamic>(any(), data: any(named: 'data')))
          .thenThrow(_dioError(DioExceptionType.badResponse, statusCode: 404));

      expect(() => client.delete('/test'), throwsA(isA<NotFoundException>()));
    });
  });
}
