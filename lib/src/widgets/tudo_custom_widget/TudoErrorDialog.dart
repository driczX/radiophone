import 'package:flutter/material.dart';

class ShowErrorDialog extends StatelessWidget {
  const ShowErrorDialog({
    this.title,
    this.content,
  });
  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        FlatButton(
          child: Text('Okay'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
