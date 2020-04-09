import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radiophone/src/style/colors.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String _title = "Navigation Example";
  Widget createDrawerListTiles(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _title = title;
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            
            child: Center(
                child: ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/logo.png",
                height: 150.0,
                width: 100.0,
              ),
            )),
            decoration: BoxDecoration(color: Color(0xff2F0D35)),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.star),
            title: Text(
              "Top Station",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              "Favorites",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.music),
            title: Text(
              "SHOUTcast Radio",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
