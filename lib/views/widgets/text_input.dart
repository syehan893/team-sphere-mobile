import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/constant/animation_duration.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import 'widgets.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final Function(String? value)? onChanged;
  final EdgeInsets margin;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool readOnly;
  final Function()? onTap;
  final String? hintText;
  final Color? fillColor;
  final bool isRequired;
  final bool isOptional;
  final TextInputAction? textInputAction;

  const TextInput({
    super.key,
    Widget? suffixWidget,
    required this.label,
    this.initialValue,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.enabled = true,
    this.onChanged,
    this.margin = const EdgeInsets.only(top: 2),
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.fillColor,
    this.isRequired = false,
    this.isOptional = false,
    this.textInputAction,
  })  : suffix = suffixWidget,
        prefix = null;

  TextInput.password({
    super.key,
    required this.label,
    Widget? prefix,
    this.initialValue,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.enabled = true,
    this.onChanged,
    this.margin = const EdgeInsets.only(top: 2),
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.fillColor,
    Function()? onVisibilityTap,
    this.isRequired = false,
    this.isOptional = false,
    this.textInputAction,
  })  : prefix = null,
        suffix = GestureDetector(
          onTap: onVisibilityTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color:
                  !obscureText ? TSColors.primary.p100 : TSColors.shades.disabled,
            ),
          ),
        );

  TextInput.prefixText({
    super.key,
    required this.label,
    required String text,
    this.initialValue,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.enabled = true,
    this.onChanged,
    this.margin = const EdgeInsets.only(top: 2),
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.fillColor,
    Function()? onVisibilityTap,
    this.isRequired = false,
    this.isOptional = false,
    this.textInputAction,
  })  : prefix = Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(top: 1),
          constraints: const BoxConstraints(
            maxWidth: 30,
          ),
          child: SubHeadline.bold(
            text,
            color: TSColors.shades.loEm,
          ),
        ),
        suffix = null;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _hasError = false;
  bool get _hasFocus => _focusNode.hasFocus;
  String? _text;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      setState(() {
        String? textController = widget.controller?.text;
        String? errorMessage = widget.validator?.call(textController);
        _hasError = !Util.falsyChecker(errorMessage);
      });
    });
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {});
    }
  }

  Color _getFocusColor({Color? unfocusColor}) {
    if (_hasError) {
      return TSColors.alert.red700;
    } else if (_hasFocus && !widget.readOnly && widget.enabled) {
      return TSColors.primary.p100;
    }
    return unfocusColor ?? TSColors.shades.disabled;
  }

  OutlineInputBorder get _errorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      );

  OutlineInputBorder get _defaultBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      );

  TextStyle get _defaultStyle => TextStyles.body1Regular.copyWith(
        color: TSColors.shades.disabled,
      );
  TextStyle get prefixStyle => TextStyles.subHeadlineBold.copyWith(
        color: TSColors.shades.stroke,
      );

  TextStyle get _errorStyle => _defaultStyle.copyWith(
        color: TSColors.alert.red700,
      );

  Widget get _textField => TextFormField(
        focusNode: _focusNode,
        textInputAction: widget.textInputAction,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        autovalidateMode: widget.autovalidateMode,
        obscureText: widget.obscureText,
        initialValue: widget.initialValue,
        enabled: widget.enabled,
        cursorColor: TSColors.primary.p100,
        onChanged: (v) {
          widget.onChanged?.call(v);
          String? errorMessage = widget.validator?.call(v);
          setState(() {
            _hasError = !Util.falsyChecker(errorMessage);
            _text = v;
          });
        },
        style: TextStyles.subHeadlineRegular.copyWith(
          color: TSColors.shades.loEm,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          prefixStyle: prefixStyle.copyWith(
            color: TSColors.shades.loEm,
          ),
          prefixIconConstraints:
              const BoxConstraints(minHeight: 2, minWidth: 2),
          fillColor: widget.enabled
              ? widget.fillColor ?? TSColors.background.b100
              : Colors.transparent,
          // hintText: widget.hintText,
          hintStyle: _defaultStyle,
          filled: true,
          isDense: true,
          errorBorder: _errorBorder,
          errorStyle: _errorStyle,
          contentPadding: const EdgeInsets.only(top: 30, bottom: 20),
          labelText: widget.isRequired
              ? '${ widget.label } *'
              : widget.isOptional
                  ? '${ widget.label } (optional)'
                  : widget.label,
          labelStyle: _defaultStyle,
          border: _defaultBorder,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AnimationDuration.milis200,
      reverseDuration: AnimationDuration.milis200,
      alignment: Alignment.topCenter,
      curve: Curves.fastLinearToSlowEaseIn,
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: widget.margin,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: _getFocusColor(),
                )),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: _textField,
                        ),
                      ],
                    ),
                  ),
                  if (widget.suffix != null) widget.suffix!,
                ],
              ),
            ),
            Visibility(
              visible: _hasError,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4),
                child: Label.regular(
                  widget.validator?.call(_text) ?? CommonStrings.emptyString,
                  color: TSColors.alert.red700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
