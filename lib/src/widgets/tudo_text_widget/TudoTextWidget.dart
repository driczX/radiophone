import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TudoTextWidget extends StatelessWidget {
  const TudoTextWidget({
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
    this.enabled,
    this.focusNode,
    this.textCapitalization,
    this.onTap,
    this.maxLines,
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
  final bool enabled;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final GestureTapCallback onTap;
  final int maxLines;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.text,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      focusNode: focusNode,
      enabled: enabled,
      key: fieldKey,
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLines,
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
