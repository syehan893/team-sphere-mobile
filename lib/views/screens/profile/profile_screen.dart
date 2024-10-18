import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import '../../cubits/cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EmployeeLoaded) {
          context.read<EmployeeAvatarCubit>().loadAvatar(state.employee.email);

          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    EmployeeAvatar(email: state.employee.email),
                    const SizedBox(height: 16),
                    Body1.bold(
                      '${state.employee.firstName} ${state.employee.lastName}',
                      fontSize: 14,
                    ),
                    const SizedBox(height: 4),
                    Body1.regular(state.employee.jobTitle),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TSColors.primary.p100,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Body1.bold('Edit Profile',
                          color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    _buildOptionTile(Icons.person, 'My Profile', () {}),
                    _buildOptionTile(
                        Icons.description, 'Terms & Condition', () {}),
                    _buildOptionTile(
                        Icons.privacy_tip, 'Privacy Policy', () {}),
                    _buildOptionTile(Icons.logout, 'Logout', () {
                      context.read<AuthCubit>().signOut();
                    }, isLogout: true),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
            child: Column(
          children: [
            const Body1.bold('Something went wrong'),
            _buildOptionTile(Icons.logout, 'Logout', () {
              context.read<AuthCubit>().signOut();
            }, isLogout: true),
          ],
        ));
      },
    );
  }

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      hoverColor: TSColors.primary.p50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isLogout ? TSColors.alert.red100 : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isLogout ? TSColors.alert.red700 : Colors.black,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? TSColors.alert.red700 : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
