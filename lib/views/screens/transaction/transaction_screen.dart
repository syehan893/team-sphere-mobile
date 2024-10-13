import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/gen/assets.gen.dart';

import '../../widgets/widgets.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: _buildCard(
            'Reimbursement',
            Assets.images.office.path,
            TSColors.blue.brandeis,
            TSColors.blue.lilBoy,
            () {
              context.go('/reimburse');
            },
            false,
          )),
          const SizedBox(width: 34),
          Expanded(
              child: _buildCard(
            'Leave',
            Assets.images.calendar.path,
            TSColors.blue.bolt,
            TSColors.blue.maya,
            () {
              context.go('/leave');
            },
            true,
          )),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String path, Color contentColor,
      Color headerColor, VoidCallback onTap, bool isCalendar) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 240,
          decoration: BoxDecoration(
            color: contentColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IntrinsicWidth(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: headerColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 60,
                    maxWidth: 200,
                    minWidth: 200,
                  ),
                  child: Body1.bold(title),
                ),
                SizedBox(height: isCalendar ? 10 : 50),
                Expanded(
                  child: SizedBox(
                    child: Image.asset(path,
                        height: isCalendar ? 100 : 150,
                        width: isCalendar ? 100 : 150),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
