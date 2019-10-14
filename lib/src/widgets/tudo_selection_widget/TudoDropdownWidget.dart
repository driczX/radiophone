import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TudoDropdownWidget extends StatelessWidget {
  const TudoDropdownWidget({
    this.attribute,
    this.fieldKey,
    this.enabled,
    this.autovalidate,
    this.labelText,
    this.border,
    this.errortext,
    this.items,
    this.value,
    this.onChanged,
    this.contentPadding,
    this.prefixIcon,
    this.hintText,
    this.field,
    this.dropdownvalue,
    this.isEmpty,
  });

  final String attribute;
  final Key fieldKey;
  final bool enabled;
  final bool autovalidate;
  final String labelText;
  final InputBorder border;
  final String errortext;
  final List<DropdownMenuItem<dynamic>> items;
  final String value;
  final Function onChanged;
  final Padding contentPadding;
  final Icon prefixIcon;
  final String hintText;
  final FormFieldState<dynamic> field;
  final List<String> dropdownvalue;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      autovalidate: true,
      initialValue: {},
      child: FormBuilderCustomField(
        attribute: "Country",
        validators: [
          FormBuilderValidators.required(),
        ],
        formField: FormField(
          builder: (FormFieldState<dynamic> field) {
            return DropdownButtonHideUnderline(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new InputDecorator(
                    decoration: InputDecoration(
                        filled: false,
                        hintText: "hintText",
                        prefixIcon: prefixIcon,
                        labelText: dropdownvalue == null ? labelText : 'From',
                        errorText: errortext ?? field.errorText),
                    isEmpty: isEmpty,
                    child: new DropdownButton(
                      value: field.value,
                      isDense: true,
                      onChanged: (value) {
                        field.didChange(value);
                      },
                      items: dropdownvalue.map((option) {
                        return DropdownMenuItem(
                          child: Text("$option"),
                          value: option,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
