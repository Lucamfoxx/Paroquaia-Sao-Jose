// widgets/custom_text_form_field_jovem.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldJovem extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  CustomTextFormFieldJovem({
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        validator: isRequired ? (value) => value?.isEmpty ?? true ? 'Por favor, insira $label' : null : null,
        decoration: InputDecoration(
          labelText: label,
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