import 'package:commons_infra/environment/app_environment.dart';
import 'package:commons_infra/http/http_log_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InfraModule {
  @singleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEnvironment.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(const HttpLogInterceptor());
    }
    return dio;
  }

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
