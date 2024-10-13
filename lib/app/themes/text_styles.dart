import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/core/assets/font_family.dart';

class TextStyles {
  
  static TextStyle h1 = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 36 / 24,
    color: TSColors.shades.hiEm,
  );

  static TextStyle h2 = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 30 / 20,
    color: TSColors.shades.hiEm,
  );

  static TextStyle h3 = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24 / 16,
    color: TSColors.shades.hiEm,
  );

  static TextStyle subHeadlineBold = TextStyle(
    fontFamily: FontFamily.montserratBold,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
    color: TSColors.shades.hiEm,
  );

  static TextStyle subHeadlineRegular = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    color: TSColors.shades.hiEm,
  );

  static TextStyle buttonBig = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24 / 16,
    color: TSColors.shades.hiEm,
  );

  static TextStyle buttonSmall = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 18 / 12,
    color: TSColors.shades.hiEm,
  );

  static TextStyle body1Bold = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 18 / 12,
    color: TSColors.shades.hiEm,
  );
  static TextStyle body1Regular = TextStyle(
    fontFamily: FontFamily.montserrat,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 18 / 12,
    color: TSColors.shades.hiEm,
  );

  static TextStyle labelBold = TextStyle(
    fontFamily: FontFamily.montserratBold,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 10,
    height: 16 / 10,
    color: TSColors.shades.hiEm,
  );

  static TextStyle labelRegular = TextStyle(
    fontFamily: FontFamily.montserratRegular,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 16 / 10,
    color: TSColors.shades.hiEm,
  );
}
