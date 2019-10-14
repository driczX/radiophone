import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TudoDatepickerWidget extends StatefulWidget {
  const TudoDatepickerWidget({
    this.labelText,
    this.prefixIcon,
  });

  final String labelText;
  final Icon prefixIcon;

  @override
  _TudoDatepickerWidgetState createState() => _TudoDatepickerWidgetState();
}

class _TudoDatepickerWidgetState extends State<TudoDatepickerWidget> {
  DateTime expirydate2 = DateTime.now();
  final format2 = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return FormField(builder: (FormFieldState state) {
      return DateTimeField(
        decoration: InputDecoration(
          labelText: widget.labelText ?? expirydate2.toString(),
          prefixIcon: widget.prefixIcon,
        ),
        format: format2,
        onShowPicker: (context, currentValue) async {
          final DateTime picked = await showDatePicker(
            context: context,
            initialDate: expirydate2,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null && picked != expirydate2)
            setState(() {
              expirydate2 = picked;
              print(expirydate2);
            });
        },
      );
    });
  }
}
