import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_unlicensed_signup/bsp_unlicensed_widget.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/navigation_helper.dart';

class Un extends StatefulWidget {
  @override
  _UnState createState() => _UnState();
}

class _UnState extends State<Un> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("BSP Unlicensed Signup"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
      ),
      actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})],
      centerTitle: true,
    );
    final bottomNavigationBar = Container(
      color: Colors.transparent,
      height: 56,
      //margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new FlatButton.icon(
            icon: Icon(Icons.close),
            label: Text('Clear'),
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onPressed: () {},
          ),
          new FlatButton.icon(
            icon: Icon(FontAwesomeIcons.arrowCircleRight),
            label: Text('Next'),
            color: colorStyles["primary"],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: BspUnlicensedWidget(),
    );
  }
}
