import 'package:flutter/material.dart';
import 'package:tudo/src/styles/colors.dart';

class HangingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      bottom: new TabBar(
        tabs: [
          new Tab(icon: new Icon(Icons.watch_later)),
          new Tab(icon: new Icon(Icons.timelapse)),
          new Tab(icon: new Icon(Icons.cancel)),
          //  new Tab(icon: new Icon(Icons.timelapse)),
          // new Tab(icon: new Icon(Icons.cancel)),
        ],
      ),
      elevation: 0.0,
      title: Text("Hangings"),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
    final bottomNavigationBar = Container(
        color: colorStyles["primary"],
        child: new TabBar(
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.watch_later)),
            new Tab(icon: new Icon(Icons.timelapse)),
            new Tab(icon: new Icon(Icons.cancel)),
          ],
        ));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        body: Container(
          child: Container(
            child: Text("Hello"),
          ),
        ),
      ),
    );
  }
}
