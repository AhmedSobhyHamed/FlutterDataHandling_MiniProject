abstract class HttpClient {
  Future<List<dynamic>> getList(String url);
  Future<Map<String, dynamic>> getOne(String url);
}
