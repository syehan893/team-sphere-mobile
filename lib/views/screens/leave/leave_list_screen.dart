import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/core/enums/leave_enum.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import '../../../app/themes/themes.dart';
import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';
import 'leave_shimmer.dart';

class MyLeavesList extends StatelessWidget {
  const MyLeavesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLeaveRequestCubit, FetchLeaveRequestState>(
      builder: (context, state) {
        if (state.employeeFetchStatus == FetchStatus.error) {
          return const Center(
            child: Body1.regular('Data Not Found', fontSize: 14),
          );
        }
        if (state.employeeFetchStatus == FetchStatus.loading) {
          return const LeaveCardShimmerList(itemCount: 10);
        }
        if (state.employeeFetchStatus == FetchStatus.loaded) {
          final listLeave = state.leaveRequests ?? [];
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
                return LeaveCard(
                    type: leave.leaveType,
                    date: Util.formatDateRange(leave.startDate.toString(), leave.endDate.toString()),
                    status:
                        LeaveStatusMapper.stringToLeaveStatus(leave.status));
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class LeaveCard extends StatelessWidget {
  final String type;
  final String date;
  final LeaveStatus status;

  const LeaveCard(
      {super.key,
      required this.type,
      required this.date,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: TSColors.secondary.s70),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Body1.bold(type, fontSize: 14),
                const SizedBox(height: 4),
                Body1.regular(date),
              ],
            ),
            StatusChip(status: status),
          ],
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final LeaveStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case LeaveStatus.approved:
        color = TSColors.alert.green700;
        label = 'Approved';
        break;
      case LeaveStatus.pending:
        color = TSColors.alert.yellow700;
        label = 'Pending';
        break;
      case LeaveStatus.declined:
        color = TSColors.alert.red700;
        label = 'Declined';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      alignment: Alignment.center,
      constraints: const BoxConstraints(minWidth: 100, maxHeight: 30),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Body1.bold(label, color: Colors.white),
    );
  }
}
