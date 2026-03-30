import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/helpers/exception_mapper.dart';
import 'package:commons_infra/http/i_http_client.dart';
import 'package:commons_observability/commons_observability.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IHttpClient)
class HttpClient implements IHttpClient {
  const HttpClient(this._dio, this._observability);

  final Dio _dio;
  final IObservability _observability;

  @override
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? params}) =>
      _request(() => _dio.get(path, queryParameters: params), path, 'GET');

  @override
  Future<Map<String, dynamic>> post(String path, {Object? data}) =>
      _request(() => _dio.post(path, data: data), path, 'POST');

  @override
  Future<Map<String, dynamic>> put(String path, {Object? data}) =>
      _request(() => _dio.put(path, data: data), path, 'PUT');

  @override
  Future<Map<String, dynamic>> delete(String path, {Object? data}) =>
      _request(() => _dio.delete(path, data: data), path, 'DELETE');

  Future<Map<String, dynamic>> _request(
    Future<Response> Function() call,
    String path,
    String method,
  ) async {
    try {
      final response = await call();
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const ParseException();
      }
      return data;
    } on DioException catch (e) {
      final exception = ExceptionMapper.fromDioException(e);
      _observability.logger.error(
        'http.request.failed',
        throwable: exception,
        attributes: {
          'path': path,
          'method': method,
          'statusCode': e.response?.statusCode,
        },
      );
      throw exception;
    } catch (e) {
      if (e is AppException) rethrow;
      final exception = ServerException(message: e.toString());
      _observability.logger.error(
        'http.request.failed',
        throwable: exception,
        attributes: {'path': path, 'method': method},
      );
      throw exception;
    }
  }
}
