import 'package:dio/dio.dart';

import 'http_client.dart';

class DioHttpClient implements HttpClient {
  DioHttpClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<List<dynamic>> getList(String url) async {
    final response = await _dio.get(url);
    return extractHttpList(response.data);
  }

  @override
  Future<Map<String, dynamic>> getOne(String url) async {
    final response = await _dio.get(url);
    return extractHttpMap(response.data);
  }
}
