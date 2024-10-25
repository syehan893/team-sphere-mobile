import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/app/themes/responsive.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';
import 'package:team_sphere_mobile/core/enums/leave_enum.dart';

import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';

class MyReimbursementList extends StatelessWidget {
  const MyReimbursementList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchReimbursementRequestCubit,
        FetchReimbursementRequestState>(
      builder: (context, state) {
        if (state.employeeFetchStatus == FetchStatus.error) {
          return const Center(
            child: Body1.regular('Data Not Found', fontSize: 14),
          );
        }
        if (state.employeeFetchStatus == FetchStatus.loading) {
          return Center(
              child: LoadingAnimationWidget.progressiveDots(
            color: TSColors.primary.p100,
            size: 50,
          ));
        }
        if (state.employeeFetchStatus == FetchStatus.loaded) {
          final listReimbursment = state.reimbursementRequests ?? [];
          if (listReimbursment.isEmpty) {
            return const Center(
              child: Body1.regular('Data Not Found', fontSize: 14),
            );
          }
          return AnimatedListView(
            children: List.generate(
              listReimbursment.length,
              (int index) {
                final reimbursement = listReimbursment[index];
                return ReimbursementCard(
                    title: reimbursement.description,
                    date: Util.formatDateStandard(reimbursement.expenseDate),
                    amount: reimbursement.amount,
                    status: LeaveStatusMapper.stringToLeaveStatus(
                        reimbursement.status));
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class ReimbursementCard extends StatelessWidget {
  final String title;
  final String date;
  final int amount;
  final LeaveStatus status;

  const ReimbursementCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveLayout(context);

    Color color;

    switch (status) {
      case LeaveStatus.approved:
        color = TSColors.alert.green700;
        break;
      case LeaveStatus.pending:
        color = TSColors.alert.yellow700;
        break;
      case LeaveStatus.declined:
        color = TSColors.alert.red700;
        break;
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 90),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: TSColors.secondary.s70),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(8)),
              width: 16,
              height: 66,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: responsive.widthPercentage(60),
                      child: Body1.bold(
                        title,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Body1.regular(date)
                  ],
                ),
                const SizedBox(height: 8),
                SubHeadline.regular('Rp. ${Util.formatNumber(amount)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
