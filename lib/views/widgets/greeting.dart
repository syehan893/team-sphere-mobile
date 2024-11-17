import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/gen/assets.gen.dart';

class DynamicGreetingWidget extends StatelessWidget {
  final String name;

  const DynamicGreetingWidget({super.key, required this.name});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) {
      return 'Good Morning,';
    } else if (hour >= 12 && hour < 15) {
      return 'Good Afternoon,';
    } else if (hour >= 15 && hour < 18) {
      return 'Good Evening,';
    } else {
      return 'Good Night,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreeting(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: TSColors.primary.p100,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: TSColors.primary.p100,
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: TSColors.secondary.s30,
          child: Image.asset(Assets.icons.notifications.path,
              color: TSColors.primary.p100, height: 20, width: 20),
        ),
      ],
    );
  }
}
