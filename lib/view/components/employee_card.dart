import 'package:flutter/material.dart';

import '../../data/models/employee.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProfileImage(imageUrl: employee.profileImage),
            const SizedBox(height: 16),
            _Item(label: 'ID', value: '${employee.id}'),
            _Item(label: 'Name', value: employee.employeeName),
            _Item(label: 'Salary', value: '${employee.employeeSalary}'),
            _Item(label: 'Age', value: '${employee.employeeAge}'),
          ],
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const CircleAvatar(
        radius: 48,
        child: Icon(Icons.person, size: 48),
      );
    }

    return CircleAvatar(
      radius: 48,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
