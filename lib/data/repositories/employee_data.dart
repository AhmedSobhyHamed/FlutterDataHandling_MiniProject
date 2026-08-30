import '../models/employee.dart';

abstract class EmployeeData {
  Future<List<Employee>> getList();
  Future<Employee> getOne(int id);
}
