import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/app/themes/responsive.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import '../../../app/themes/themes.dart';
import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';

class PendingRequestList extends StatelessWidget {
  final Function(BuildContext, String, String, int, String) onCardTap;

  const PendingRequestList({super.key, required this.onCardTap});

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
          final listReimbursment = state.approvalReimbursementRequests ?? [];
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
                return PendingRequestCard(
                  key: Key('${reimbursement.requestId}'),
                  name:
                      '${reimbursement.employee?.firstName} ${reimbursement.employee?.lastName}',
                  initials: reimbursement.employee?.email ??
                      CommonStrings.emptyString,
                  description: reimbursement.description,
                  amount: reimbursement.amount,
                  date: Util.formatDateStandard(reimbursement.expenseDate),
                  onTap: onCardTap,
                );
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
  final String description;
  final int amount;
  final String date;
  final Function(BuildContext, String, String, int, String) onTap;

  const PendingRequestCard({
    super.key,
    required this.name,
    required this.initials,
    required this.description,
    required this.amount,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveLayout(context);

    return GestureDetector(
      onTap: () => onTap(context, name, description, amount, date),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: TSColors.alert.yellow700),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              EmployeeAvatar(
                key: Key(initials),
                radius: 24,
                email: initials,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Body1.bold(name,
                          fontSize: 14, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 8),
                      Body1.regular(date),
                    ],
                  ),
                  SizedBox(
                    width: responsive.widthPercentage(65),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubHeadline(description,
                            overflow: TextOverflow.ellipsis),
                        SubHeadline('Rp. ${Util.formatNumber(amount)}',
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
