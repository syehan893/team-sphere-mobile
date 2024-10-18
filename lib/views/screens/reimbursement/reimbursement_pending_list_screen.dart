import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import '../../../app/themes/themes.dart';
import '../../widgets/widgets.dart';

class PendingRequestList extends StatelessWidget {
  final Function(BuildContext, String, String, int, String) onCardTap;

  const PendingRequestList({super.key, required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      children: [
        PendingRequestCard(
          key: const Key('MF'),
          name: 'Muhammad Fernando',
          initials: 'MF',
          description: 'Subcribe chatgpt',
          amount: 350000,
          date: '29 May 2024',
          onTap: onCardTap,
        ),
        PendingRequestCard(
          key: const Key('syehan@gmail.com'),
          name: 'Muhammad Syehan',
          initials: 'syehan@gmail.com',
          description: 'Bayar domain',
          amount: 1000000,
          date: '29 May 2024',
          onTap: onCardTap,
        ),
        PendingRequestCard(
          key: const Key('MJ'),
          name: 'Michel Jackson',
          initials: 'MJ',
          description: 'Makan 17 Agustusan',
          amount: 350000,
          date: '29 May 2024',
          onTap: onCardTap,
        ),
      ],
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
    return GestureDetector(
      onTap: () => onTap(context, name, description, amount, date),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Body1.bold(name, fontSize: 14),
                        const SizedBox(height: 8),
                        Body1.regular(date),
                      ],
                    ),
                    SubHeadline(
                        '$description - Rp. ${Util.formatNumber(amount)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
