import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<T?> get<T>(String url);
}

class DioClient implements HttpClient {
  final Dio _dio;

  DioClient(this._dio);

  @override
  Future<T?> get<T>(String url) async {
    final response = await _dio.get<T>(url);
    return response.data;
  }
}
