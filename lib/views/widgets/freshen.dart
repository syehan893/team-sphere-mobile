import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';

class Freshen extends StatelessWidget {
  final VoidCallback? onRefresh;
  final Widget child;
  const Freshen({
    super.key,
    this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: PColors.primary.p700,
      color: PColors.primary.p100,
      onRefresh: () async {
        onRefresh?.call();
      },
      child: child,
    );
  }
}