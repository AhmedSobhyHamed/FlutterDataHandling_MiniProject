abstract class HttpClient {
  Future<List<dynamic>> getList(String url);
  Future<Map<String, dynamic>> getOne(String url);
}

List<dynamic> extractHttpList(dynamic data) {
  if (data is List) return data;
  if (data is Map && data['data'] is List) {
    return data['data'] as List<dynamic>;
  }
  throw const FormatException('HTTP response does not contain a list');
}

Map<String, dynamic> extractHttpMap(dynamic data) {
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
