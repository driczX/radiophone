import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tudo/src/styles/colors.dart';

class TudoConditionDialogWidget extends StatelessWidget {
  const TudoConditionDialogWidget({
    this.title,
    this.subText,
    this.onpressYes,
    this.labelbutton1,
    this.labelbutton2,
    this.subText2,
    this.subText3,
  });
  final Widget title;
  final String subText;
  final String subText2;
  final String subText3;
  final GestureTapCallback onpressYes;
  final Widget labelbutton1;
  final Widget labelbutton2;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title ?? Text("Dialog Title"),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(subText ?? "Subtext Here"),
            SizedBox(
              height: 10,
            ),
            Text(subText2),
            SizedBox(
              height: 10,
            ),
            Text(subText3),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(FontAwesomeIcons.arrowCircleRight),
                  label: labelbutton1,
                  color: colorStyles["primary"],
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                FlatButton.icon(
                  icon: Icon(FontAwesomeIcons.arrowCircleRight),
                  label: labelbutton2,
                  color: colorStyles["primary"],
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  onPressed: onpressYes,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
