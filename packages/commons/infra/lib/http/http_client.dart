import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/helpers/exception_mapper.dart';
import 'package:commons_infra/http/i_http_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IHttpClient)
class HttpClient implements IHttpClient {
  const HttpClient(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? params}) =>
      _request(() => _dio.get(path, queryParameters: params));

  @override
  Future<Map<String, dynamic>> post(String path, {Object? data}) =>
      _request(() => _dio.post(path, data: data));

  @override
  Future<Map<String, dynamic>> put(String path, {Object? data}) =>
      _request(() => _dio.put(path, data: data));

  @override
  Future<Map<String, dynamic>> delete(String path, {Object? data}) =>
      _request(() => _dio.delete(path, data: data));

  Future<Map<String, dynamic>> _request(Future<Response> Function() call) async {
    try {
      final response = await call();
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const ParseException();
      }
      return data;
    } on DioException catch (e) {
      throw ExceptionMapper.fromDioException(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
