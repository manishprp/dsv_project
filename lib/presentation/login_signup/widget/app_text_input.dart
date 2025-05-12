import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool enabled;

  const AppTextInput({
    super.key,
    this.validator,
    this.labelText,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      style: TextStyle(color: Colors.black),
      validator: validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        border: const OutlineInputBorder(),
        labelText: enabled ? labelText : null,
      ),
    );
  }
}
