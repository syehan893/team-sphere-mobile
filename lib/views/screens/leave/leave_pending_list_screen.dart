import 'package:flutter/material.dart';

import '../../../app/themes/themes.dart';
import '../../widgets/widgets.dart';

class PendingRequestList extends StatelessWidget {
  const PendingRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnimatedListView(
      children: [
        PendingRequestCard(
            name: 'Muhammad Syehan',
            initials: 'syehan@gmail.com',
            date: '29 Jul - 31 Aug'),
        PendingRequestCard(
            name: 'Muhammad Fernando', initials: 'MF', date: '02 Jun - 07 Jun'),
        PendingRequestCard(
            name: 'Agatha Aurel', initials: 'AA', date: '16 Dec - 27 Dec'),
      ],
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
                  Body1.bold(name, fontSize: 14, overflow: TextOverflow.ellipsis),
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
