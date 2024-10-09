import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_sphere_mobile/views/cubits/login_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ProfileScreen'),
          TextButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              child: const Text('Kembali Ke Login'))
        ],
      ),
    );
  }
}
