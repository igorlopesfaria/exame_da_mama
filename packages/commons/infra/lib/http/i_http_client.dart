abstract class IHttpClient {
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? params});
  Future<Map<String, dynamic>> post(String path, {Object? data});
  Future<Map<String, dynamic>> put(String path, {Object? data});
  Future<Map<String, dynamic>> delete(String path, {Object? data});
}
