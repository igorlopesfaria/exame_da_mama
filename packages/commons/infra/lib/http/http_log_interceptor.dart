import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Prints detailed HTTP request/response info to the console.
/// Only registered in debug mode (see infra_module.dart) — never active in release builds.
class HttpLogInterceptor extends Interceptor {
  const HttpLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln('┌── HTTP REQUEST ─────────────────────────')
      ..writeln('│ ${options.method} ${options.uri}')
      ..writeln('│ Headers: ${options.headers}');
    if (options.data != null) {
      buffer.writeln('│ Body: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      buffer.writeln('│ Params: ${options.queryParameters}');
    }
    buffer.write('└─────────────────────────────────────────');
    debugPrint(buffer.toString());
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln('┌── HTTP RESPONSE ────────────────────────')
      ..writeln('│ ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri}')
      ..writeln('│ Body: ${response.data}')
      ..write('└─────────────────────────────────────────');
    debugPrint(buffer.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln('┌── HTTP ERROR ───────────────────────────')
      ..writeln('│ ${err.requestOptions.method} ${err.requestOptions.uri}')
      ..writeln('│ Type: ${err.type}')
      ..writeln('│ Status: ${err.response?.statusCode}')
      ..writeln('│ Message: ${err.message}');
    if (err.response?.data != null) {
      buffer.writeln('│ Body: ${err.response?.data}');
    }
    buffer.write('└─────────────────────────────────────────');
    debugPrint(buffer.toString());
    handler.next(err);
  }
}
