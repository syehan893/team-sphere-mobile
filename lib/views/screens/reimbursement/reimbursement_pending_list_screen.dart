import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/app/themes/responsive.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';
import 'package:team_sphere_mobile/views/screens/reimbursement/reimbursement_detail_modal.dart';
import 'package:team_sphere_mobile/views/screens/reimbursement/reimbursement_shimmer.dart';

import '../../../app/themes/themes.dart';
import '../../../data/data.dart';
import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';

class PendingRequestList extends StatelessWidget {
  const PendingRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchReimbursementRequestCubit,
        FetchReimbursementRequestState>(
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
                  key: Key(
                      'key-${reimbursement.requestId}-${reimbursement.receiptFilePath}'),
                  name:
                      '${reimbursement.employee?.firstName} ${reimbursement.employee?.lastName}',
                  initials: reimbursement.employee?.email ??
                      CommonStrings.emptyString,
                  description: reimbursement.description,
                  amount: reimbursement.amount,
                  date: Util.formatDateStandard(
                      reimbursement.expenseDate.toString()),
                  onTap: () {
                    _showDetailModal(context, reimbursement);
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _showDetailModal(
      BuildContext context, ReimbursementRequest reimbursement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.75,
        expand: false,
        builder: (_, controller) => BlocProvider(
          create: (context) => getIt<CreateReimbursementRequestCubit>(),
          child: ReimbursementDetailModal(
            key: Key(
                'key-reimbursement-detail-modal-${reimbursement.employeeId}-${reimbursement.receiptFilePath}-${reimbursement.createdAt}'),
            controller: controller,
            reimbursement: reimbursement,
          ),
        ),
      ),
    );
  }
}

class PendingRequestCard extends StatelessWidget {
  final String name;
  final String initials;
  final String description;
  final int amount;
  final String date;
  final Function() onTap;

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
      onTap: onTap,
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
                      SizedBox(
                        width: responsive.widthPercentage(50),
                        child: Body1.bold(name,
                            fontSize: 14, overflow: TextOverflow.ellipsis),
                      ),
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
