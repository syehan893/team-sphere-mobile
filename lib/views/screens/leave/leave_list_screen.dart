import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/core/enums/leave_enum.dart';

import '../../../app/themes/themes.dart';
import '../../widgets/widgets.dart';

class MyLeavesList extends StatelessWidget {
  const MyLeavesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnimatedListView(
      children: [
        LeaveCard(
            type: 'Annual',
            date: '29 Jul - 31 Aug',
            status: LeaveStatus.approved),
        LeaveCard(
            type: 'Special',
            date: '29 Jul - 31 Aug',
            status: LeaveStatus.pending),
        LeaveCard(
            type: 'Sick',
            date: '29 Jul - 31 Aug',
            status: LeaveStatus.declined),
        LeaveCard(
            type: 'Annual',
            date: '29 Jul - 31 Aug',
            status: LeaveStatus.approved),
        LeaveCard(
            type: 'Annual',
            date: '29 Jul - 31 Aug',
            status: LeaveStatus.approved),
      ],
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
