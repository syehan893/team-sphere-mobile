import 'package:flutter/material.dart';
import '../../app/themes/themes.dart';

class Button extends StatelessWidget {
  final String title;
  final TextStyle? titelStyle;
  final double? fontSize;
  final TextOverflow? textOverflow;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final Widget? leading;
  final IconData? leadingIcon;
  final Widget? trailing;
  final double? width;
  final double? height;
  final EdgeInsets? contentPadding;
  final double? iconSize;
  final BoxDecoration? decoration;
  final WidgetStateProperty<OutlinedBorder?>? shape;

  const Button({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.width,
    this.height,
    this.contentPadding,
    this.leading,
    this.trailing,
    this.titelStyle,
    this.iconSize,
    this.decoration,
    this.fontSize,
    this.textOverflow,
    this.shape,
  })  : leadingIcon = null,
        iconColor = null;

  const Button.leading({
    super.key,
    required this.title,
    this.titelStyle,
    this.width,
    this.height,
    this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.contentPadding,
    required this.leading,
    this.iconSize,
    this.decoration,
    this.fontSize,
    this.textOverflow,
    this.shape,
  })  : trailing = null,
        leadingIcon = null,
        iconColor = null;

  const Button.leadingIcon({
    super.key,
    required this.title,
    this.titelStyle,
    this.width,
    this.height,
    this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.contentPadding,
    this.iconColor,
    this.iconSize,
    required this.leadingIcon,
    this.decoration,
    this.fontSize,
    this.textOverflow,
    this.shape,
  })  : trailing = null,
        leading = null;

  const Button.trailing({
    super.key,
    required this.title,
    this.onTap,
    this.titelStyle,
    this.backgroundColor,
    this.width,
    this.height,
    this.titleColor,
    this.contentPadding,
    required this.trailing,
    this.iconSize,
    this.decoration,
    this.fontSize,
    this.textOverflow,
    this.shape,
  })  : leading = null,
        leadingIcon = null,
        iconColor = null;

  @override
  Widget build(BuildContext context) {
    final colorForIcon = iconColor ?? titleColor;
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: decoration,
        child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(
              onTap == null
                  ? TSColors.shades.disabled
                  : backgroundColor ?? TSColors.primary.p100,
            ),
            shape: shape ??
                WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
          ),
          child: Padding(
            padding: contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 10)],
                if (leadingIcon != null) ...[
                  Icon(
                    leadingIcon,
                    size: iconSize,
                    color: onTap == null || titleColor == null
                        ? Colors.white
                        : colorForIcon,
                  ),
                  const SizedBox(width: 10),
                ],
                Flexible(
                  child: Text(
                    title,
                    style: (titelStyle ?? TextStyles.body1Regular).copyWith(
                        color: onTap == null || titleColor == null
                            ? Colors.white
                            : titleColor,
                        fontSize: fontSize ?? 16,
                        overflow: textOverflow ?? TextOverflow.fade),
                  ),
                ),
                if (trailing != null) ...[const SizedBox(width: 10), trailing!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
