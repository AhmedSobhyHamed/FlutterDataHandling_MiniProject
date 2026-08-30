import 'package:flutter/material.dart';

import '../../data/models/employee.dart';
import '../../services/employee_service.dart';
import '../components/employee_card.dart';

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({
    super.key,
    required this.employee,
    required this.employeeService,
  });

  final Employee employee;
  final EmployeeService employeeService;

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  late Employee _employee;
  List<Employee> _cached = [];
  int _index = -1;

  bool get _hasCachedList => _index >= 0 && _cached.isNotEmpty;

  bool get _hasPrevious => _hasCachedList && _index > 0;

  bool get _hasNext => _hasCachedList && _index < _cached.length - 1;

  @override
  void initState() {
    super.initState();
    _employee = widget.employee;
    _loadCache();
  }

  Future<void> _loadCache() async {
    final cache = widget.employeeService.cache();
    if (!cache.hasCache()) return;

    final cached = await cache.getList();
    if (!mounted) return;

    final index = cached.indexWhere((item) => item.id == widget.employee.id);
    if (index >= 0) {
      cached[index] = widget.employee;
      await cache.saveList(cached);
    }
    if (!mounted) return;

    setState(() {
      _cached = cached;
      _index = index;
    });
  }

  void _previous() {
    if (_hasPrevious) {
      setState(() {
        _index--;
        _employee = _cached[_index];
      });
    }
  }

  void _next() {
    if (_hasNext) {
      setState(() {
        _index++;
        _employee = _cached[_index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(_employee.employeeName),
      ),
      body: Column(
        children: [
          _employeeCard(),
          if (_hasCachedList) _navigationBar(),
        ],
      ),
    );
  }

  Widget _employeeCard() {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: EmployeeCard(employee: _employee),
        ),
      ),
    );
  }

  Widget _navigationBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _previousButton(),
            Text('${_index + 1} / ${_cached.length}'),
            _nextButton(),
          ],
        ),
      ),
    );
  }

  Widget _previousButton() {
    return IconButton(
      tooltip: 'Previous',
      icon: const Icon(Icons.arrow_back),
      onPressed: _hasPrevious ? _previous : null,
    );
  }

  Widget _nextButton() {
    return IconButton(
      tooltip: 'Next',
      icon: const Icon(Icons.arrow_forward),
      onPressed: _hasNext ? _next : null,
    );
  }
}
