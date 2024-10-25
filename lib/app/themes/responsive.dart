import 'package:flutter/material.dart';

class ResponsiveLayout {
  final BuildContext context;
  
  ResponsiveLayout(this.context);

  double screenHeight() => MediaQuery.of(context).size.height;
  double screenWidth() => MediaQuery.of(context).size.width;

  double heightPercentage(double percentage) => screenHeight() * (percentage / 100);

  double widthPercentage(double percentage) => screenWidth() * (percentage / 100);
}
