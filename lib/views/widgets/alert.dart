import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';

import 'widgets.dart';

class Alert extends StatelessWidget {
  final Color? color;
  final Color? contentColor;
  final String message;
  final IconData icon;
  const Alert({
    super.key,
    this.color,
    this.contentColor,
    required this.icon,
    required this.message,
  });

  Alert.red({
    super.key,
    required this.icon,
    required this.message,
  })  : color = PColors.alert.red100,
        contentColor = PColors.alert.red700;

  Alert.green({
    super.key,
    required this.icon,
    required this.message,
  })  : color = PColors.alert.green100,
        contentColor = PColors.alert.green700;

  Alert.yellow({
    super.key,
    required this.icon,
    required this.message,
  })  : color = PColors.alert.yellow100,
        contentColor = PColors.alert.yellow700;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: contentColor, size: 24),
          const SizedBox(width: 12),
          Body1(message, color: contentColor)
        ],
      ),
    );
  }
}
