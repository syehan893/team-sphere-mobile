import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';

enum Variant { strong, normal, large, small }

enum VariantSize { big, small }

enum VariantStyle { bold, regular }

abstract class Typography extends StatelessWidget {
  final Color? color;
  final String text;
  final double? fontSize;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Variant variant;
  final VariantSize variantSize;
  final VariantStyle variantStyle;

  const Typography(
    this.text, {
    super.key,
    this.fontSize,
    this.color,
    this.overflow,
    this.textAlign,
    this.variant = Variant.normal,
    this.variantSize = VariantSize.small,
    this.variantStyle = VariantStyle.regular,
  });

  TextStyle getTextStyle();
}

class H1 extends Typography {
  const H1(super.text,
      {super.key,
      super.color,
      super.overflow,
      super.textAlign,
      super.variant,
      super.variantSize,
      super.variantStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  TextStyle getTextStyle() {
    return TextStyles.h1;
  }
}

class H2 extends Typography {
  const H2(super.text,
      {super.key,
      super.color,
      super.overflow,
      super.textAlign,
      super.variant,
      super.variantSize,
      super.variantStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  TextStyle getTextStyle() {
    return TextStyles.h2;
  }
}

class H3 extends Typography {
  const H3(super.text,
      {super.key,
      super.color,
      super.overflow,
      super.textAlign,
      super.variant,
      super.variantSize,
      super.variantStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  TextStyle getTextStyle() {
    return TextStyles.h3;
  }
}

class SubHeadline extends Typography {
  const SubHeadline(super.text,
      {super.key,
      super.color,
      super.overflow,
      super.textAlign,
      super.variant,
      super.variantSize,
      super.variantStyle});

  const SubHeadline.bold(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
  }) : super(variantStyle: VariantStyle.bold);

  const SubHeadline.regular(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
  }) : super(variantStyle: VariantStyle.regular);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  TextStyle getTextStyle() {
    switch (variantStyle) {
      case VariantStyle.bold:
        return TextStyles.subHeadlineBold;
      default:
        return TextStyles.subHeadlineRegular;
    }
  }
}

class ButtonMontserrat extends Typography {
  const ButtonMontserrat(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
    super.variant,
  });

  const ButtonMontserrat.big(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
  }) : super(variantSize: VariantSize.big);

  const ButtonMontserrat.small(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
  }) : super(variantSize: VariantSize.small);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  TextStyle getTextStyle() {
    switch (variantSize) {
      case VariantSize.big:
        return TextStyles.buttonBig;
      default:
        return TextStyles.buttonSmall;
    }
  }
}

class Body1 extends Typography {
  const Body1(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
    super.variant,
    super.fontSize,
  });

  const Body1.bold(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
    super.fontSize,
  }) : super(variantStyle: VariantStyle.bold);

  const Body1.regular(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
    super.fontSize,
  }) : super(variantStyle: VariantStyle.regular);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(color: color, fontSize: fontSize),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  TextStyle getTextStyle() {
    switch (variantStyle) {
      case VariantStyle.bold:
        return TextStyles.body1Bold;
      default:
        return TextStyles.body1Regular;
    }
  }
}

class Label extends Typography {
  const Label(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
    super.variant,
  });

  const Label.bold(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
  }) : super(variantStyle: VariantStyle.bold);

  const Label.regular(
    super.text, {
    super.key,
    super.color,
    super.overflow,
    super.textAlign,
  }) : super(variantStyle: VariantStyle.regular);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle().copyWith(color: color),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  TextStyle getTextStyle() {
    switch (variantStyle) {
      case VariantStyle.bold:
        return TextStyles.labelBold;
      default:
        return TextStyles.labelRegular;
    }
  }
}
