import 'package:dio/dio.dart';

import 'http_client.dart';

class DioHttpClient implements HttpClient {
  DioHttpClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<List<Map<String, dynamic>>> getList(String url) async {
    final response = await _dio.get(url);
    return _extractList(response.data);
  }

  @override
  Future<Map<String, dynamic>> getOne(String url) async {
    final response = await _dio.get(url);
    return _extractMap(response.data);
  }

  List<Map<String, dynamic>> _extractList(dynamic data) {
    if (data is List) return data;
    if (data is Map && data['data'] is List) {
      return data['data'] as List<Map<String, dynamic>>;
    }
    throw const FormatException('HTTP response does not contain a list');
  }

  Map<String, dynamic> _extractMap(dynamic data) {
    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      final inner = map['data'];
      if (inner is Map) {
        return Map<String, dynamic>.from(inner);
      }
      return map;
    }
    throw const FormatException('HTTP response does not contain an object');
  }
}
