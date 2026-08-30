import '../../../core/http_client.dart';
import '../../../ExternalResources/APIs.dart';
import '../../models/employee.dart';
import '../employee_data.dart';

class EmployeeDataApi implements EmployeeData {
  EmployeeDataApi(this._http);

  final HttpClient _http;

  @override
  Future<List<Employee>> getList() async {
    final raw = await _http.getList(APIs.employees);
    return raw
        .map((item) => Employee.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Employee> getOne(int id) async {
    final raw = await _http.getOne(APIs.employee(id));
    return Employee.fromJson(raw);
  }
}
