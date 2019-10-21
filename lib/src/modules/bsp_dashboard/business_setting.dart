import 'package:flutter/material.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_page.dart';
import 'package:tudo/src/modules/cmr_dashboard/cmr_main_screen.dart';

class BusinessSetting extends StatefulWidget {
  @override
  _BusinessSettingState createState() => _BusinessSettingState();
}

class _BusinessSettingState extends State<BusinessSetting> {
  bool _value = false;

  void _onChanged(bool value) {
    print(value);
    setState(
      () {
        if (value == false) {
          _value = false;
        } else {
          _value = true;
        }
      },
    );
  }

  String data;
  @override
  Widget build(BuildContext context) {
    bool _value2 = false;

    void _onChanged2(bool value) => setState(() => _value2 = value);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Business Setting'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(12.0),
        child: new ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business Profile Overview'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business Branches'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BspSignupPage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Employees'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('My Manager'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business Calendar'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Payment and Receivables'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business Vehicles'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business insurance'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business tax Rate'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Service Appointment duration'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business Hours'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business Service Radius'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Business Shift Schedule'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            new SwitchListTile(
              value: _value,
              onChanged: _onChanged,
              title: new Text('Block/Hold Future Appointment',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Divider(),
            new SwitchListTile(
              value: _value2,
              onChanged: _onChanged2,
              title: new Text('Auto Schedule',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Sign Out'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
