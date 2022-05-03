import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<T?> get<T>(String url);
}

class DioClient implements HttpClient {
  final Dio _dio;

  DioClient({required Dio dio}) : _dio = dio;

  @override
  Future<T?> get<T>(String url) async {
    final response = await _dio.get<T>(url);
    return response.data;
  }
}
