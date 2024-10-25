import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';

import '../../../app/themes/themes.dart';
import '../../../core/helpers/utils.dart';
import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';

class PendingRequestList extends StatelessWidget {
  const PendingRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLeaveRequestCubit, FetchLeaveRequestState>(
      builder: (context, state) {
        if (state.managerFetchStatus == FetchStatus.error) {
          return const Center(
            child: Body1.regular('Data Not Found', fontSize: 14),
          );
        }
        if (state.managerFetchStatus == FetchStatus.loading) {
          return Center(
              child: LoadingAnimationWidget.progressiveDots(
            color: TSColors.primary.p100,
            size: 50,
          ));
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
                    name:
                        '${leave.employee?.firstName} ${leave.employee?.lastName}',
                    initials:
                        leave.employee?.email ?? CommonStrings.emptyString,
                    date: Util.formatDateRange(leave.startDate, leave.endDate));
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class PendingRequestCard extends StatelessWidget {
  final String name;
  final String initials;
  final String date;

  const PendingRequestCard(
      {super.key,
      required this.name,
      required this.initials,
      required this.date});

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
                  Body1.bold(name,
                      fontSize: 14, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Body1.regular(date),
                ],
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: TSColors.alert.red700,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.close, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: TSColors.alert.green700,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
