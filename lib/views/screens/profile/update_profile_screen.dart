import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/core/enums/creation_status.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';
import 'package:team_sphere_mobile/views/widgets/base_layout.dart';

import '../../../app/themes/colors.dart';
import '../../cubits/cubit.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoaded) {
          return BlocProvider(
            create: (context) => getIt<UpdateEmployeeCubit>()
              ..updateEmployee(state.employee)
              ..loadAvatarUrl(),
            child: const UpdateEmployeeContent(),
          );
        }
        return Center(
          child: LoadingAnimationWidget.progressiveDots(
            color: TSColors.primary.p100,
            size: 50,
          ),
        );
      },
    );
  }
}

class UpdateEmployeeContent extends StatelessWidget {
  const UpdateEmployeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Profile',
      useBackButton: true,
      onBackTap: () {
        context.go('/home');
        context.read<HomeCubit>().changeNavBar(HomeNavBar.home);
      },
      body: BlocConsumer<UpdateEmployeeCubit, UpdateEmployeeState>(
        listener: (context, state)  {
          if (state.status == CreationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Employee updated successfully')),
            );
            context.go('/home');
            context.read<HomeCubit>().changeNavBar(HomeNavBar.home);
          } else if (state.status == CreationStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == CreationStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => context.read<UpdateEmployeeCubit>().pickAvatar(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: state.avatarFileBytes != null
                        ? MemoryImage(state.avatarFileBytes!)
                        : (state.avatarUrl != null
                            ? NetworkImage(state.avatarUrl!)
                            : null),
                    child:
                        state.avatarFileBytes == null && state.avatarUrl == null
                            ? const Icon(Icons.camera_alt, size: 30)
                            : null,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: state.firstName,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onChanged: (value) => context
                      .read<UpdateEmployeeCubit>()
                      .updateFirstName(value),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: state.lastName,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onChanged: (value) =>
                      context.read<UpdateEmployeeCubit>().updateLastName(value),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: state.phoneNumber,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  onChanged: (value) => context
                      .read<UpdateEmployeeCubit>()
                      .updatePhoneNumber(value),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () =>
                      context.read<UpdateEmployeeCubit>().saveChanges(),
                  child: const Text('Update'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
