import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/constant/animation_duration.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';
import 'package:team_sphere_mobile/views/widgets/typography.dart';

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
  final List<String>? dropdownOptions;

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
    this.dropdownOptions,
  })  : suffix = suffixWidget,
        prefix = null;

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

  Color _getFocusColor({Color? unfocusColor}) {
    if (_hasError) {
      return TSColors.alert.red700;
    } else if (_hasFocus && !widget.readOnly && widget.enabled) {
      return TSColors.primary.p100;
    }
    return unfocusColor ?? TSColors.shades.disabled;
  }

  Widget _buildInputField() {
    if (widget.dropdownOptions != null && widget.dropdownOptions!.isNotEmpty) {
      return DropdownButtonFormField<String>(
        value: _text ?? widget.initialValue,
        decoration: InputDecoration(
          labelText: widget.isRequired
              ? '${widget.label} *'
              : widget.isOptional
                  ? '${widget.label} (optional)'
                  : widget.label,
          fillColor: widget.enabled
              ? widget.fillColor ?? TSColors.background.b100
              : Colors.transparent,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        items: widget.dropdownOptions!.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Body1.regular(option,
                color: TSColors.primary.p100, fontSize: 14),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _text = value;
            widget.onChanged?.call(value);
          });
        },
        validator: widget.validator,
      );
    } else {
      return TextFormField(
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
        style: TextStyles.body1Regular
            .copyWith(color: TSColors.primary.p100, fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          fillColor: widget.enabled
              ? widget.fillColor ?? TSColors.background.b100
              : Colors.transparent,
          filled: true,
          isDense: true,
          labelText: widget.isRequired ? '${widget.label} *' : widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      );
    }
  }

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
                  ),
                ),
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
                          child: _buildInputField(),
                        ),
                      ],
                    ),
                  ),
                  if (widget.suffix != null) widget.suffix!,
                ],
              ),
            ),
            if (_hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4),
                child: Body1.regular(
                  widget.validator?.call(_text) ?? CommonStrings.emptyString,
                  color: TSColors.alert.red700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
