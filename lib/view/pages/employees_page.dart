import 'package:flutter/material.dart';

import '../../data/models/employee.dart';
import '../../services/employee_service.dart';
import '../components/employee_tile.dart';
import 'employee_details_page.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key, required this.employeeService});

  final EmployeeService employeeService;

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  late Future<List<Employee>> _employeesFuture;

  @override
  void initState() {
    super.initState();
    _employeesFuture = widget.employeeService.getList();
  }

  Future<void> _load({bool fresh = false}) async {
    final future = fresh
        ? widget.employeeService.freshList()
        : widget.employeeService.getList();
    setState(() => _employeesFuture = future);
    await future;
  }

  void _openDetails(Employee employee) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployeeDetailsPage(
          employee: employee,
          employeeService: widget.employeeService,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () => _load(fresh: true),
          ),
        ],
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _errorView();
          }

          final employees = snapshot.data ?? [];
          if (employees.isEmpty) {
            return const Center(child: Text('No employees'));
          }

          return _employeesList(employees);
        },
      ),
    );
  }

  Widget _errorView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Could not load employees'),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _load,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _employeesList(List<Employee> employees) {
    return RefreshIndicator(
      onRefresh: () => _load(fresh: true),
      child: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return EmployeeTile(
            employee: employee,
            onTap: () => _openDetails(employee),
          );
        },
      ),
    );
  }
}
