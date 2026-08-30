/// Central place for API endpoints and keys.
/// Change these values when switching environments or backends.
class APIs {
  APIs._();

  static const String baseUrl = 'https://dummy.restapiexample.com/api/v1';

  static const String employees = '$baseUrl/employees';

  static String employee(int id) => '$baseUrl/employee/$id';
}
