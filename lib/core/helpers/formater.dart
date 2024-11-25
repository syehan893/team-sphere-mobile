import 'package:flutter/services.dart';

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    String formattedText = '';
    for (var i = 0; i < newText.length; i++) {
      formattedText += newText[i];
      if ((newText.length - i - 1) % 3 == 0 && i != newText.length - 1) {
        formattedText += '.';
      }
    }

    int selectionIndex = newValue.selection.end;
    if (newValue.text != formattedText) {
      selectionIndex = formattedText.length - (newText.length - selectionIndex);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
