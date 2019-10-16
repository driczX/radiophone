import 'package:flutter/material.dart';


class BspSettingsTab extends StatelessWidget {
  BspSettingsTab({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListView(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                color: Colors.transparent,
              ),
              child: new Image(
                image: new AssetImage("assets/user.png"),
                height: 150.0,
                width: 10.0,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.color_lens),
                title: Text('Theme'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Colorscreen()));
                }),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Wallet'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Address'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.data_usage),
              title: Text('Licence And usage'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Notification'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Become TuDo Business Provider?'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.textsms),
              title: Text('Agreement and Terms'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Refer TUDO'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.title),
              title: Text('Title'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
