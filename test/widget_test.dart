import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterdatahandling_miniproject/core/dio_http_client.dart';
import 'package:flutterdatahandling_miniproject/core/shared_preferences_storage.dart';
import 'package:flutterdatahandling_miniproject/data/repositories/api/employee_data_api.dart';
import 'package:flutterdatahandling_miniproject/data/repositories/cache/employee_data_cache.dart';
import 'package:flutterdatahandling_miniproject/main.dart';
import 'package:flutterdatahandling_miniproject/services/employee_service.dart';

void main() {
  testWidgets('Employees page loads', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final employeeService = EmployeeService(
      api: EmployeeDataApi(DioHttpClient()),
      cache: EmployeeDataCache(SharedPreferencesStorage(preferences)),
    );

    await tester.pumpWidget(MyApp(employeeService: employeeService));

    expect(find.text('Employees'), findsOneWidget);
  });
}
