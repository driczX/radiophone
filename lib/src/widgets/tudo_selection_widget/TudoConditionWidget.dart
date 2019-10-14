import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TudoConditionWidget extends StatelessWidget {
  final String text;
  final Function onChanged;
  final GestureTapCallback onTap;
  final String errortext;
  final bool validate;
  final bool intialValue;
  final bool readOnly;

  const TudoConditionWidget({
    this.text,
    this.onTap,
    this.errortext,
    this.onChanged,
    this.validate = true,
    this.intialValue = false,
    this.readOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      attribute: 'accept_terms',
      initialValue: intialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      leadingInput: true,
      label: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text ?? 'I have read and agree to the ',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      validators: validate
          ? [
              FormBuilderValidators.requiredTrue(
                errorText: errortext ?? 'You Must have to check this',
              ),
            ]
          : [],
    );
  }
}
