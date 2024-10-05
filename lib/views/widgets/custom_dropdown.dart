import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

import 'widgets.dart';

enum CustomDropdownFieldTheme { v1, v2 }

class CustomDropdownField<T> extends StatefulWidget {
  final String label;
  final bool enabled;
  final List<DropdownMenuItem<T>> values;
  final T? value;
  final Function(T? v)? onChanged;
  final Color? fillColor;
  final String? Function(T? value)? validator;
  final String? hintText;
  final bool isRequired;
  final bool isOptional;

  final CustomDropdownFieldTheme dropdownFieldTheme;
  const CustomDropdownField({
    super.key,
    required this.label,
    required this.values,
    this.value,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.fillColor,
    this.hintText,
    this.isRequired = false,
    this.isOptional = false,
    this.dropdownFieldTheme = CustomDropdownFieldTheme.v1,
  });

  const CustomDropdownField.v2({
    super.key,
    required this.label,
    required this.values,
    this.value,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.fillColor,
    this.hintText,
    this.isRequired = false,
    this.isOptional = false,
    this.dropdownFieldTheme = CustomDropdownFieldTheme.v2,
  });

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  bool _hasError = false;
  bool get _hasFocus => _focusNode.hasFocus;
  T? _value;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    _value = widget.value;
  }

  Color _getFocusColor({Color? unfocusColor}) {
    if (_hasError) {
      return PColors.alert.red700;
    } else if (_hasFocus) {
      return PColors.primary.p700;
    }
    return unfocusColor ??
        (widget.dropdownFieldTheme == CustomDropdownFieldTheme.v1
            ? Colors.transparent
            : PColors.shades.disabled);
  }

  TextStyle get _defaultStyle => TextStyles.body1Regular.copyWith(
        color: PColors.shades.disabled,
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.fillColor ??
                (widget.dropdownFieldTheme == CustomDropdownFieldTheme.v1
                    ? PColors.background.b400
                    : PColors.background.b100),
          
            border: Border(
                bottom: BorderSide(
              color: _getFocusColor(),
            )),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: DropdownButtonFormField<T>(
                        icon: Container(),
                        borderRadius: BorderRadius.circular(8),
                        isDense: true,
                        validator: widget.validator,
                        style: TextStyles.subHeadlineRegular.copyWith(
                          color: PColors.shades.loEm,
                        ),

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelText: widget.isRequired
                              ? '${widget.label} *'
                              : widget.isOptional
                                  ? '${widget.label} (optional)'
                                  : widget.label,
                          labelStyle: _defaultStyle,
                          fillColor:
                              widget.fillColor ?? PColors.background.b400,
                          filled: true,
                        ),
                        value: _value,
                        items: widget.values,
                        onChanged: widget.enabled
                            ? (v) {
                                String? errorMessage =
                                    widget.validator?.call(v);
                                widget.onChanged?.call(v);
                                setState(() {
                                  _hasError = !Util.falsyChecker(errorMessage);
                                  _value = v;
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_drop_down, color: PColors.shades.disabled)
            ],
          ),
        ),
        Visibility(
          visible: _hasError,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4),
            child: Body1(
              widget.validator?.call(_value) ?? CommonStrings.emptyString,
              color: PColors.alert.red700,
            ),
          ),
        )
      ],
    );
  }
}
