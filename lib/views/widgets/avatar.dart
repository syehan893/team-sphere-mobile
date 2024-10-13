import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit.dart';

class EmployeeAvatar extends StatelessWidget {
  final String email;
  final double radius;

  const EmployeeAvatar({super.key, required this.email, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeAvatarCubit, String?>(
      builder: (context, avatarUrl) {
        if (avatarUrl == null) {
          return CircleAvatar(
            radius: radius,
            child: Text(email[0].toUpperCase()),
          );
        }
        return CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(avatarUrl),
        );
      },
    );
  }
}