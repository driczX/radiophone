import 'package:flutter/material.dart';

class TudoPasswordWidget extends StatefulWidget {
  const TudoPasswordWidget({
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.filled,
    this.controller,
    this.focusNode,
  });

  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final Icon prefixIcon;
  final bool filled;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _TudoPasswordWidgetState createState() => _TudoPasswordWidgetState();
}

class _TudoPasswordWidgetState extends State<TudoPasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      key: widget.fieldKey,
      obscureText: _obscureText,
      // maxLength:
      //     widget.maxLength ?? 8, // if not provided by the user, then it is 8
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        border: const UnderlineInputBorder(),
        filled: widget.filled,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
