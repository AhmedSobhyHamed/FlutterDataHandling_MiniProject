import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class SharedPreferencesStorage implements LocalStorage {
  SharedPreferencesStorage(this._preferences);

  final SharedPreferences _preferences;

  @override
  String? getString(String key) => _preferences.getString(key);

  @override
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  @override
  bool containsKey(String key) => _preferences.containsKey(key);

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }
}
