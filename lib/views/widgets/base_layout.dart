import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import 'widgets.dart';

enum BaseLayoutTheme { v2 }

enum BaseLayoutAppBarTheme { v2 }

class BaseLayoutAppBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;
  final EdgeInsets padding;
  final Widget? titleWidget;
  final Widget? bottom;
  final Widget? top;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final Color? backgroundColor;
  final CrossAxisAlignment? crossAxisAlignmentAppBar;
  final Color? titleColor;
  final Color? backButtonColor;

  const BaseLayoutAppBar.v2(
      {super.key,
      this.title,
      this.onBackTap,
      this.actions,
      this.padding = const EdgeInsets.only(top: 14, left: 20, right: 20),
      this.systemUiOverlayStyle,
      this.bottom,
      this.top,
      this.backgroundColor,
      this.crossAxisAlignmentAppBar,
      this.titleColor,
      this.backButtonColor})
      : titleWidget = null;

  Widget _buildTitle(BuildContext context) {
    if (title != null) {
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          if (Navigator.canPop(context)) ...[
            _buildBackButton(context)!,
            Align(
              alignment: Alignment.center,
              child: H3(
                title ?? '',
                color: titleColor ?? TSColors.shades.loEm,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else
            Align(
              alignment: Alignment.center,
              child: Expanded(
                  child: H3(
                title ?? '',
                color: titleColor ?? TSColors.shades.loEm,
                overflow: TextOverflow.ellipsis,
              )),
            )
        ],
      );
    }
    if (titleWidget != null) {
      return titleWidget!;
    }
    return const SizedBox.shrink();
  }

  Widget? _buildBackButton(BuildContext context) {
    if (Navigator.canPop(context)) {
      return IconButton(
        onPressed: () {
          if (onBackTap == null) {
            Navigator.pop(context);
          } else {
            onBackTap?.call();
          }
        },
        iconSize: 18,
        icon: Icon(
          Icons.arrow_back_ios,
          color: backButtonColor ?? TSColors.shades.loEm,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle ?? SystemUiOverlayStyle.dark,
      child: Container(
        color: backgroundColor ?? TSColors.background.b100,
        alignment: Alignment.bottomLeft,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (top != null) top!,
              Container(
                padding: padding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      crossAxisAlignmentAppBar ?? CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: _buildTitle(context),
                    ),
                    if (!Util.falsyChecker(actions)) ...[...actions!]
                  ],
                ),
              ),
              if (bottom != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: bottom!,
                )
            ],
          ),
        ),
      ),
    );
  }
}

enum BaseLayoutFooterPosition { floating, fixed }

class BaseLayout extends StatefulWidget {
  final String? title;
  final bool? useBackButton;
  final VoidCallback? onBackTap;
  final Widget? bottomNavigationBar;
  final Widget body;
  final Widget? footer;
  final BaseLayoutFooterPosition footerPosition;
  final EdgeInsets? footerPadding;
  final EdgeInsets? contentPadding;
  final bool? resizeAvoidButton;
  final Widget? appBar;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final ImageProvider? backgroundImage;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const BaseLayout({
    super.key,
    this.title,
    this.useBackButton = false,
    this.onBackTap,
    this.bottomNavigationBar,
    this.footerPadding,
    this.contentPadding,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.backgroundImage,
    this.resizeAvoidButton,
    required this.body,
    this.footer,
    this.footerPosition = BaseLayoutFooterPosition.fixed,
    this.appBarBackgroundColor,
  }) : appBar = null;

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  Widget _buildTitle(BuildContext context) {
    return widget.title != null
        ? Stack(
            alignment: Alignment.centerLeft,
            children: [
              if (Navigator.canPop(context) &&
                  (widget.useBackButton ?? false)) ...[
                _buildBackButton(context)!,
                Align(
                  alignment: Alignment.center,
                  child: H3(
                    widget.title ?? CommonStrings.emptyString,
                    color: TSColors.primary.p100,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ] else
                Align(
                  alignment: Alignment.center,
                  child: H3(
                    widget.title ?? CommonStrings.emptyString,
                    color: TSColors.primary.p100,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
            ],
          )
        : Container();
  }

  Widget? _buildBackButton(BuildContext context) {
    if (Navigator.canPop(context)) {
      return IconButton(
        onPressed: () {
          if (widget.onBackTap == null) {
            Navigator.pop(context);
          } else {
            widget.onBackTap?.call();
          }
        },
        iconSize: 18,
        icon: Icon(
          Icons.arrow_back_ios,
          color: TSColors.shades.loEm,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) {
        if (widget.onBackTap != null) {
          widget.onBackTap!();
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: widget.resizeAvoidButton ?? false,
        backgroundColor: widget.backgroundColor ?? TSColors.background.b100,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        appBar: widget.title != null
            ? AppBar(
                title: _buildTitle(context),
                backgroundColor:
                    widget.appBarBackgroundColor ?? TSColors.background.b100,
                automaticallyImplyLeading: false,
                elevation: 0,
                centerTitle: false,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              )
            : null,
        bottomNavigationBar: widget.bottomNavigationBar,
        body: Stack(
          children: [
            if (widget.backgroundImage != null)
              Positioned.fill(
                child: Image(
                  image: widget.backgroundImage!,
                  fit: BoxFit.cover,
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    padding: widget.contentPadding ?? const EdgeInsets.all(12),
                    child: widget.body,
                  ),
                ),
                if (widget.footer != null &&
                    widget.footerPosition ==
                        BaseLayoutFooterPosition.fixed) ...[
                  Container(
                    width: double.infinity,
                    padding: widget.footerPadding ??
                        const EdgeInsets.symmetric(vertical: 12),
                    color: TSColors.background.b100,
                    child: UnconstrainedBox(child: widget.footer),
                  )
                ]
              ],
            ),
            if (widget.footer != null &&
                widget.footerPosition == BaseLayoutFooterPosition.floating)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: widget.footerPadding ??
                      const EdgeInsets.symmetric(vertical: 12),
                  child: UnconstrainedBox(child: widget.footer),
                ),
              )
          ],
        ),
      ),
    );
  }
}
