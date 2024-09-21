import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'auth_interceptor.dart';

@singleton
class ApiClient {
  final Dio _dio;
  final AuthService _authService;

  ApiClient(this._authService) : _dio = Dio() {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _authService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token might be expired, try to refresh
          final newToken = await _authService.getAccessToken();
          if (newToken != null) {
            // Retry the request with the new token
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            return handler.resolve(await _dio.fetch(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }

  Future<Response> post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path, dynamic data) async {
    return await _dio.delete(path, data: data);
  }

}