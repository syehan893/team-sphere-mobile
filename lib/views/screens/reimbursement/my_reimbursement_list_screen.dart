import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import '../../widgets/widgets.dart';

class MyReimbursementList extends StatelessWidget {
  const MyReimbursementList({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      children: [
        ReimbursementCard(
            title: 'Adobe Photoshop',
            date: '29 May 2024',
            amount: 2000000,
            color: TSColors.alert.green700),
        ReimbursementCard(
            title: 'Pizza Hut',
            date: '29 May 2024',
            amount: 140000,
            color: TSColors.alert.red700),
        ReimbursementCard(
            title: 'Internet Bulan Agustus',
            date: '29 May 2024',
            amount: 350000,
            color: TSColors.alert.yellow700),
        ReimbursementCard(
            title: 'Bayar Server',
            date: '29 May 2024',
            amount: 113000000,
            color: TSColors.alert.green700),
        ReimbursementCard(
            title: 'Gojeck ke kantor',
            date: '29 May 2024',
            amount: 12000,
            color: TSColors.alert.yellow700),
      ],
    );
  }
}

class ReimbursementCard extends StatelessWidget {
  final String title;
  final String date;
  final int amount;
  final Color color;

  const ReimbursementCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Body1.bold(title, fontSize: 14),
                      Body1.regular(date),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SubHeadline.regular('Rp. ${Util.formatNumber(amount)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
