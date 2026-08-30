import 'package:flutter/material.dart';

import '../../data/models/employee.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({
    super.key,
    required this.employee,
    this.onTap,
  });

  final Employee employee;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text('${employee.id}')),
      title: Text(employee.employeeName),
      trailing: _PostImage(imageUrl: employee.profileImage),
      onTap: onTap,
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const CircleAvatar(child: Icon(Icons.person));
    }

    return CircleAvatar(backgroundImage: NetworkImage(imageUrl));
  }
}
