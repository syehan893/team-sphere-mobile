import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';

import '../cubits/cubit.dart';


class EmployeeAvatar extends StatelessWidget {
  final String email;
  final double radius;

  const EmployeeAvatar({super.key, required this.email, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<EmployeeAvatarCubit>()
        ..loadAvatar(email),
      child: BlocListener<EmployeeCubit, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeLoaded) {
            context.read<EmployeeAvatarCubit>().loadAvatar(email);
          }
        },
        child: BlocBuilder<EmployeeAvatarCubit, EmployeeAvatarState>(
          builder: (context, state) {
            if (state is EmployeeAvatarLoaded) {
              return CircleAvatar(
                radius: radius,
                child: ClipOval(
                  child: Image.network(
                    state.avatarUrl,
                    fit: BoxFit.cover,
                    width: radius * 2,
                    height: radius * 2,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildFallbackAvatar();
                    },
                  ),
                ),
              );
            }
            return _buildFallbackAvatar();
          },
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return CircleAvatar(
      radius: radius,
      child: Text(email[0].toUpperCase()),
    );
  }
}