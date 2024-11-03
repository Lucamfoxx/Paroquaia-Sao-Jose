// services/date_formatter.dart
import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.length > 8) {
      return oldValue;
    }

    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 4) {
        formattedText += '/';
      }
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}