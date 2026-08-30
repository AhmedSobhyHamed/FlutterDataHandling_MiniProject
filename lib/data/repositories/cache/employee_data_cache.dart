import 'dart:convert';

import '../../../core/local_storage.dart';
import '../../models/employee.dart';
import '../employee_data.dart';

class EmployeeDataCache implements EmployeeData {
  EmployeeDataCache(this._storage);

  final LocalStorage _storage;

  static const _employeesKey = 'cached_employees';

  @override
  Future<List<Employee>> getList() async {
    final raw = _storage.getString(_employeesKey);
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
    await _storage.setString(_employeesKey, encoded);
  }

  bool hasCache() => _storage.containsKey(_employeesKey);

  Future<void> drop() async {
    await _storage.remove(_employeesKey);
  }
}
