import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/dio_http_client.dart';
import 'core/shared_preferences_storage.dart';
import 'data/repositories/api/employee_data_api.dart';
import 'data/repositories/cache/employee_data_cache.dart';
import 'services/employee_service.dart';
import 'view/pages/employees_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final employeeService = EmployeeService(
    api: EmployeeDataApi(DioHttpClient()),
    cache: EmployeeDataCache(SharedPreferencesStorage(preferences)),
  );

  runApp(MyApp(employeeService: employeeService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.employeeService});

  final EmployeeService employeeService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employees',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: EmployeesPage(employeeService: employeeService),
    );
  }
}
