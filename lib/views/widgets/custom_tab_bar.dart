import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/views/widgets/typography.dart';

import '../../app/themes/themes.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabLabels;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomTabBar({
    super.key,
    required this.tabLabels,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TSColors.primary.p50,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: List.generate(
          tabLabels.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? TSColors.primary.p100
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: selectedIndex == index
                    ? Body1.bold(tabLabels[index],
                        textAlign: TextAlign.center, color: Colors.white)
                    : Body1.regular(tabLabels[index],
                        textAlign: TextAlign.center, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
