import 'package:flutter/material.dart';
import 'package:tudo/src/styles/colors.dart';

class Colorscreen extends StatefulWidget {
  @override
  ColorscreenState createState() => ColorscreenState();
}

class ColorscreenState extends State<Colorscreen> {
  bool editable = true;
  DateTime date;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Choose Color")),
        body: Stack(
          fit: StackFit.expand,

          children: <Widget>[
            Card(
              margin: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  SizedBox(height: 16.0),
                  FlatButton(
                    child: Text("Teal"),
                    onPressed: () {},
                    color: colorStyles["primary"],
                    textColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("Orange"),
                    onPressed: () {},
                    color: Colors.orange,
                    textColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("Amber"),
                    onPressed: () {},
                    color: Colors.amber,
                    textColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text("Cyan"),
                    onPressed: () {},
                    color: Colors.cyan,
                    textColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ],
              ),
            )
          ],
          //padding: EdgeInsets.all(16.0),
        ),
      );
}
