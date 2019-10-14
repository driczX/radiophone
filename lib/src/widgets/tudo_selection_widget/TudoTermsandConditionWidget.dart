import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TudoTermsandConditionWidget extends StatelessWidget {
  const TudoTermsandConditionWidget({
    this.text,
    this.linktext,
    this.onTap,
    this.errortext,
  });
  final String text;
  final String linktext;
  final GestureTapCallback onTap;
  final String errortext;
  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      attribute: 'accept_terms',
      initialValue: false,
      onChanged: (val) {
        print('value check');
        print(val);
      },
      leadingInput: true,
      label: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text ?? 'I have read and agree to the ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
                text: linktext ?? 'Terms and Conditions',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
      ),
      validators: [
        FormBuilderValidators.requiredTrue(
          errorText: errortext,
        ),
      ],
    );
  }
}
