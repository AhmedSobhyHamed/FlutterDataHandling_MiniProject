import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/employee.dart';
import '../employee_data.dart';

class EmployeeDataCache implements EmployeeData {
  EmployeeDataCache(this._preferences);

  final SharedPreferences _preferences;

  static const _employeesKey = 'cached_employees';

  @override
  Future<List<Employee>> getList() async {
    final raw = _preferences.getString(_employeesKey);
    if (raw == null) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Employee.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Employee> getOne(int id) async {
    final employees = await getList();
    return employees.firstWhere(
      (employee) => employee.id == id,
      orElse: () => throw StateError('Employee $id not found in cache'),
    );
  }

  Future<void> saveList(List<Employee> employees) async {
    final encoded = jsonEncode(
      employees.map((employee) => employee.toJson()).toList(),
    );
    await _preferences.setString(_employeesKey, encoded);
  }

  bool hasCache() => _preferences.containsKey(_employeesKey);

  Future<void> drop() async {
    await _preferences.remove(_employeesKey);
  }
}
