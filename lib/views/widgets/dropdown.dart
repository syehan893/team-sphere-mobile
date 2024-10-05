import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';
import 'package:team_sphere_mobile/views/widgets/typography.dart';

enum DropdownFieldTheme { v1, v2 }

class DropdownField<T> extends StatefulWidget {
  final String label;
  final bool enabled;
  final List<DropdownMenuItem<T>> values;
  final T? value;
  final Function(T? v)? onChanged;
  final Color? fillColor;
  final String? Function(T? value)? validator;
  final String? hintText;
  final bool isRequired;
  final DropdownFieldTheme dropdownFieldTheme;
  const DropdownField({
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
    this.dropdownFieldTheme = DropdownFieldTheme.v1,
  });

  const DropdownField.v2({
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
    this.dropdownFieldTheme = DropdownFieldTheme.v2,
  });

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
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
      return PColors.primary.p100;
    }
    return unfocusColor ??
        (widget.dropdownFieldTheme == DropdownFieldTheme.v1
            ? Colors.transparent
            : PColors.shades.stroke);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // margin: widget.margin,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: widget.fillColor ??
                (widget.dropdownFieldTheme == DropdownFieldTheme.v1
                    ? PColors.background.b400
                    : PColors.background.b100),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _getFocusColor(),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.dropdownFieldTheme == DropdownFieldTheme.v1
                        ? Row(
                            children: [
                              H1(
                                widget.label,
                                color: _getFocusColor(
                                  unfocusColor: PColors.shades.hiEm,
                                ),
                              ),
                              Visibility(
                                visible: widget.isRequired,
                                child: Body1(
                                  ' *(wajib diisi)',
                                  color: PColors.alert.red700,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Label.regular(
                                widget.label,
                                color: _getFocusColor(
                                  unfocusColor: PColors.shades.hiEm,
                                ),
                              ),
                              Visibility(
                                visible: widget.isRequired,
                                child: Label.regular(
                                  ' *',
                                  color: PColors.alert.red700,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 24,
                      child: DropdownButtonFormField<T>(
                        icon: Container(),

                        borderRadius: BorderRadius.circular(8),
                        isDense: true,
                        // elevation: 2,
                        // isExpanded: false,
                        validator: widget.validator,
                        style: TextStyles.subHeadlineBold.copyWith(
                                    color: PColors.shades.loEm,
                                  ),
                        hint:  SubHeadline.regular(
                                widget.hintText ?? CommonStrings.emptyString,
                                color: PColors.shades.stroke,
                              ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          // suffixIcon: widget.suffixIcon,
                          contentPadding: EdgeInsets.zero,
                          // labelStyle: _defaultStyle,
                          fillColor:
                              widget.fillColor ?? PColors.background.b400,
                          // label: Text(label),
                          filled: true,
                          // errorBorder: _errorBorder,
                          // errorStyle: _errorStyle,
                          // labelStyle: _defaultStyle,
                          // focusedBorder: _hasError ? _errorBorder : _defaultBorder,
                          // border: _defaultBorder,
                          // enabledBorder: _hasError ? _errorBorder : _defaultBorder,
                          // focusedErrorBorder: _errorBorder,
                        ),
                        value: _value,
                        items: widget.values,
                        // dropdownColor: Colors.white,
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
