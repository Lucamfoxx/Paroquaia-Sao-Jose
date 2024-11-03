// widgets/custom_text_form_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText; // Adiciona hintText como parâmetro opcional

  CustomTextFormField({
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.keyboardType,
    this.inputFormatters,
    this.hintText, // Inicializa hintText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        validator: isRequired
            ? (value) =>
                value?.isEmpty ?? true ? 'Por favor, insira $label' : null
            : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText, // Define o hintText
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
