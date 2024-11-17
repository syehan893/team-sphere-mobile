import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/enums/creation_status.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/core/enums/leave_enum.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';

import '../../../app/themes/themes.dart';
import '../../../core/helpers/utils.dart';
import '../../../data/data.dart';
import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';
import 'leave_shimmer.dart';

class PendingRequestList extends StatelessWidget {
  const PendingRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateLeaveRequestCubit>(),
      child: BlocListener<CreateLeaveRequestCubit, CreateLeaveRequestState>(
        listener: (context, state) {
          if (state.updateStatus == CreationStatus.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: LoadingAnimationWidget.progressiveDots(
                    color: TSColors.primary.p100,
                    size: 50,
                  ),
                );
              },
            );
          }
          if (state.updateStatus == CreationStatus.success) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            context.read<FetchLeaveRequestCubit>()
              ..fetchLeaveRequestsByEmployeeId()
              ..fetchLeaveRequestsByManagerId();
          }
        },
        child: BlocBuilder<FetchLeaveRequestCubit, FetchLeaveRequestState>(
          builder: (context, state) {
            if (state.managerFetchStatus == FetchStatus.error) {
              return const Center(
                child: Body1.regular('Data Not Found', fontSize: 14),
              );
            }
            if (state.managerFetchStatus == FetchStatus.loading) {
              return const PendingRequestCardShimmerList(itemCount: 10);
            }
            if (state.managerFetchStatus == FetchStatus.loaded) {
              final listLeave = state.approvalLeaveRequests ?? [];
              if (listLeave.isEmpty) {
                return const Center(
                  child: Body1.regular('Data Not Found', fontSize: 14),
                );
              }
              return AnimatedListView(
                children: List.generate(
                  listLeave.length,
                      (int index) {
                    final leave = listLeave[index];
                    return PendingRequestCard(
                        leave: leave,
                        name:
                        '${leave.employee?.firstName} ${leave.employee
                            ?.lastName}',
                        initials:
                        leave.employee?.email ?? CommonStrings.emptyString,
                        date: Util.formatDateRange(leave.startDate.toString(),
                            leave.endDate.toString()));
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class PendingRequestCard extends StatelessWidget {
  final String name;
  final String initials;
  final String date;
  final LeaveRequest leave;

  const PendingRequestCard({
    super.key,
    required this.name,
    required this.initials,
    required this.date,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      constraints: const BoxConstraints(maxHeight: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: TSColors.secondary.s70),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            EmployeeAvatar(
              radius: 24,
              email: initials,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Body1.bold(
                    name,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Body1.regular(date),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _showConfirmationDialog(context, 'Reject', () {
                  context.read<CreateLeaveRequestCubit>().updateLeaveRequest(
                      leave,
                      LeaveStatusMapper.leaveStatusToString(
                          LeaveStatus.declined));
                },
                );
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: TSColors.alert.red700,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                _showConfirmationDialog(context, 'Approve', () {
                  context.read<CreateLeaveRequestCubit>().updateLeaveRequest(
                      leave,
                      LeaveStatusMapper.leaveStatusToString(
                          LeaveStatus.approved));
                },
                );
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: TSColors.alert.green700,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.check, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String actionType,
      VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: TSColors.background.b400,
          title: Text('Confirm $actionType'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Body1.regular(
                'Are you sure you want to $actionType this request?',
                fontSize: 14,
              ),
              const SizedBox(height: 16),
              Body1.bold(
                'Leave Type : ${leave.leaveType}',
                fontSize: 14,
              ),
              Body1.bold(
                'Reason : ${leave.reason}',
                fontSize: 14,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Body1.regular('Cancel',
                  fontSize: 14, color: TSColors.alert.red700),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
              },
              child: Body1.regular('Confirm',
                  fontSize: 14, color: TSColors.alert.green700),
            ),
          ],
        );
      },
    );
  }
}
