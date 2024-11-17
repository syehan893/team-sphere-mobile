import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/enums/creation_status.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import '../../cubits/cubit.dart';

class LeaveRequestScreen extends StatelessWidget {
  const LeaveRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateLeaveRequestCubit>(),
      child: const LeaveRequestContent(),
    );
  }
}

class LeaveRequestContent extends StatelessWidget {
  const LeaveRequestContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Leave Request',
      useBackButton: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CreateLeaveRequestCubit, CreateLeaveRequestState>(
          builder: (context, state) {
            if (state.status == CreationStatus.loading) {
              return Center(
                  child: LoadingAnimationWidget.progressiveDots(
                color: TSColors.primary.p100,
                size: 50,
              ));
            }
            return BlocBuilder<EmployeeCubit, EmployeeState>(
              builder: (context, employeeState) {
                if (employeeState is EmployeeLoaded) {
                  context.read<CreateLeaveRequestCubit>().updateManagerId(
                      employeeState.employee.managerId ??
                          employeeState.employee.employeeId);
                  context
                      .read<CreateLeaveRequestCubit>()
                      .updateEmployeeId(employeeState.employee.employeeId);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        H2(
                          'Submit your leave',
                          color: TSColors.primary.p100,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildDatePicker(
                      Key('start-date-${state.leaveRequest.startDate.toIso8601String()}'),
                      context,
                      'Start Date',
                      state.leaveRequest.startDate,
                      (newDate) => context
                          .read<CreateLeaveRequestCubit>()
                          .updateStartDate(newDate),
                    ),
                    const SizedBox(height: 24),
                    _buildDatePicker(
                      Key('end-date-${state.leaveRequest.endDate.toIso8601String()}'),
                      context,
                      'End Date',
                      state.leaveRequest.endDate,
                      (newDate) => context
                          .read<CreateLeaveRequestCubit>()
                          .updateEndDate(newDate),
                    ),
                    const SizedBox(height: 24),
                    _buildDropdown(context, state),
                    const SizedBox(height: 24),
                    TextInput(
                      onChanged: (value) => context
                          .read<CreateLeaveRequestCubit>()
                          .updateReason(value ?? ''),
                      label: 'Reason',
                    ),
                    const Spacer(),
                    _buildSubmitButton(context, state),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDatePicker(Key key, BuildContext context, String label,
      DateTime date, Function(DateTime) onDateChanged) {
    return InkWell(
      key: key,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
        if (picked != null) onDateChanged(picked);
      },
      child: BlocBuilder<CreateLeaveRequestCubit, CreateLeaveRequestState>(
        builder: (context, state) {
          return TextInput(
            initialValue: DateFormat('dd/MM/yyyy').format(date),
            enabled: false,
            label: label,
            suffixWidget: const Icon(Icons.calendar_today),
          );
        },
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, CreateLeaveRequestState state) {
    return TextInput(
      key: Key('leave-type-${state.leaveRequest.leaveType}'),
      label: 'Leave Type',
      initialValue: state.leaveRequest.leaveType,
      onChanged: (newValue) {
        context.read<CreateLeaveRequestCubit>().updateLeaveType(newValue!);
      },
      dropdownOptions: const ['Annual Leave', 'Sick Leave', 'Special Leave'],
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, CreateLeaveRequestState state) {
    return SizedBox(
      width: double.infinity,
      child: Button(
        title: 'Submit',
        onTap: state.status == CreationStatus.loading
            ? null
            : () {
                context.read<CreateLeaveRequestCubit>().createLeaveRequest();
              },
      ),
    );
  }
}
