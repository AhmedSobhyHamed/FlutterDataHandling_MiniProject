import 'dart:convert';

import 'package:http/http.dart' as http;

import 'http_client.dart';

class PackageHttpClient implements HttpClient {
  PackageHttpClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<dynamic>> getList(String url) async {
    final response = await _get(url);
    return extractHttpList(jsonDecode(response.body));
  }

  @override
  Future<Map<String, dynamic>> getOne(String url) async {
    final response = await _get(url);
    return extractHttpMap(jsonDecode(response.body));
  }

  Future<http.Response> _get(String url) async {
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP ${response.statusCode} for $url');
    }
    return response;
  }
}
