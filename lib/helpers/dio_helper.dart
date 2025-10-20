import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;
  static void initialized() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.escuelajs.co/api/v1/auth/',
        connectTimeout: Duration(seconds: 300),
        sendTimeout: Duration(seconds: 300),
        receiveTimeout: Duration(seconds: 300),
        headers: {"Content-Type": "application/json"},
      ),
    );
    print('initialized successfully');
  }

  static Future<Response<dynamic>> getData(String path) async {
    final response = await _dio.get(path);
    return response;
  }

  static Future<Response<dynamic>> postData({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.post(
      path,
      data: body,
      queryParameters: queryParameters,
    );
    print('post successfully');
    return response;
  }
}
