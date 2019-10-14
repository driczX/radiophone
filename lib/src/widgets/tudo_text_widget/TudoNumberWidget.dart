import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TudoNumberWidget extends StatelessWidget {
  const TudoNumberWidget({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.filled,
    this.prefixIcon,
    this.controller,
    this.maxLength,
    this.initialValue,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final bool filled;
  final Icon prefixIcon;
  final TextEditingController controller;
  final int maxLength;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      key: fieldKey,
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: const UnderlineInputBorder(),
        filled: filled,
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
      ),
    );
  }
}
