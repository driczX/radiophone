import 'package:flutter/material.dart';

class TudoPrimaryButtonWidget extends StatelessWidget {
  const TudoPrimaryButtonWidget({
    this.fieldKey,
    this.onPressed,
    this.icon,
    this.controller,
    this.shape,
    this.label,
    this.textColor,
    this.color,
  });

  final Key fieldKey;
  final GestureTapCallback onPressed;
  final Icon icon;
  final TextEditingController controller;
  final RoundedRectangleBorder shape;
  final Text label;
  final Color textColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      icon: icon ?? Icon(Icons.label),
      label: label ?? Text("Label"),
      color: color,
      textColor: textColor,
      shape: shape,
      onPressed: onPressed,
    );
  }
}
