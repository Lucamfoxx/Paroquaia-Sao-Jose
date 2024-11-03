import 'package:flutter/services.dart';

class DateFormatterJovem extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove caracteres não numéricos
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita o comprimento do texto
    if (newText.length > 8) {
      // Se tiver mais de 8 caracteres, não faz nenhuma alteração
      return oldValue;
    }

    // Adiciona automaticamente as barras para o formato DD/MM/AAAA
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