import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';

import 'widgets.dart';

class Empty extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icons;

  const Empty({super.key, required this.title, this.subtitle, this.icons});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icons ?? Icons.supervised_user_circle_outlined,
          size: 53,
          color: PColors.grey.gainsboro,
        ),
        const SizedBox(
          height: 29,
        ),
        H2(title, color: PColors.shades.disabled, textAlign: TextAlign.center),
        const SizedBox(
          height: 8,
        ),
        Body1.regular(subtitle ?? CommonStrings.emptyString,
            color: PColors.shades.disabled, textAlign: TextAlign.center),
      ],
    );
  }
}
