/// lib/services/api/api_service.dart
/// UPDATED – Dio is now public (dio instead of _dio)

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // CHANGED: _dio → dio (public)
  late final Dio dio;

  static const String _baseUrl = 'https://dummyjson.com';

  void init() {
    dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    // Error handling
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        debugPrint('API Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  // HTTP methods
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    return await dio.post<T>(path, data: data);
  }
}

final apiService = ApiService();

void setupApiService() {
  apiService.init();
}