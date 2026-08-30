abstract class LocalStorage {
  String? getString(String key);
  Future<void> setString(String key, String value);
  bool containsKey(String key);
  Future<void> remove(String key);
}
