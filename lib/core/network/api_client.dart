import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/config.dart';
import 'package:team_sphere_mobile/core/helpers/logger.dart';
import 'auth_interceptor.dart';

@singleton
class ApiClient {
  final Dio _dio;
  final AuthService _authService;

  ApiClient(this._authService)
      : _dio = Dio(BaseOptions(baseUrl: Config.baseUrl)) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _authService.getAccessToken();
        logger.d('Token $token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        logger.e('Error $error');
        if (error.response?.statusCode == 401) {
          final newToken = await _authService.getAccessToken();
          if (newToken != null) {
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final clonedRequest = await _dio.request(
              error.requestOptions.path,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
            );
            return handler.resolve(clonedRequest);
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String path) async {
    final result = await _dio.get(path);
    logger.i('''
      Get : ${Config.baseUrl + path} 
      Response : $result
      ''');
    return result;
  }

  Future<Response> post(String path, dynamic data) async {
    final result = await _dio.post(path, data: data);
    logger.i('''
      Post      : ${Config.baseUrl + path}
      Data      : $data 
      Response  : $result
      ''');
    return result;
  }

  Future<Response> put(String path, dynamic data) async {
    final result = await _dio.put(path, data: data);
    logger.i('''
      Put       : ${Config.baseUrl + path} 
      Data      : $data
      Response  : $result
      ''');
    return result;
  }

  Future<Response> delete(String path, dynamic data) async {
    final result = await _dio.delete(path, data: data);
    logger.i('''
      Put       : ${Config.baseUrl + path} 
      Data      : $data
      Response  : $result
      ''');
    return result;
  }
}
