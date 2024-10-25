import 'package:flutter/material.dart';

class SafeWidget extends StatelessWidget {
  final Widget child;
  final double? maxHeightPercentage;
  final double? maxWidthPercentage;

  const SafeWidget({
    super.key,
    required this.child,
    this.maxHeightPercentage,
    this.maxWidthPercentage,
  });

  @override
  Widget build(BuildContext context) {
    double maxHeight =
        MediaQuery.of(context).size.height * (maxHeightPercentage ?? 100) / 100;
    double maxWidth =
        MediaQuery.of(context).size.width * (maxWidthPercentage ?? 100) / 100;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      child: child,
    );
  }
}
