import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({
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
    this.focusNode,
    this.onChanged,
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
  final FocusNode focusNode;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      key: fieldKey,
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
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
