import '../data/models/employee.dart';
import '../data/repositories/api/employee_data_api.dart';
import '../data/repositories/cache/employee_data_cache.dart';

class EmployeeService {
  EmployeeService({
    required EmployeeDataApi api,
    required EmployeeDataCache cache,
  }) : _api = api,
      _cache = cache;

  final EmployeeDataApi _api;
  final EmployeeDataCache _cache;

  /// Cached list if present; otherwise fetch from API, store, and return.
  Future<List<Employee>> getList() async {
    if (_cache.hasCache()) {
      return _cache.getList();
    }

    final employees = await _api.getList();
    await _cache.saveList(employees);
    return employees;
  }

  /// One employee from cache, or from API if it is not cached.
  Future<Employee> getOne(int id) async {
    try {
      return await _cache.getOne(id);
    } on StateError {
      return _api.getOne(id);
    }
  }

  /// Gets the cache instance.
  EmployeeDataCache cache() => _cache;

  /// Clears the local cache.
  Future<void> refresh() => _cache.drop();

  /// Clears the cache, then loads the list again (API + store).
  Future<List<Employee>> freshList() async {
    await refresh();
    return getList();
  }
}
