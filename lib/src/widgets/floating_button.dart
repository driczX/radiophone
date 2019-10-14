import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.view_list,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      curve: Curves.bounceIn,
      backgroundColor: Colors.blue[800],
      foregroundColor: Colors.white,
      children: [
        SpeedDialChild(
          child: Icon(Icons.room_service, color: Colors.white),
          backgroundColor: Colors.purple,
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => AddwalkScreen()));
          },
          label: AppConstantsValue.appConst['floatingbutton']['addinhouse']
              ['translation'],
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.purpleAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.event, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => Addbranchscreen()));
          },
          label: AppConstantsValue.appConst['floatingbutton']['addevent']
              ['translation'],
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.greenAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: colorStyles["primary"],
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => BspAddressmapscreen()));
            //MaterialPageRoute(builder: (context) => Addwalkinservice()));
          },
          label: AppConstantsValue.appConst['floatingbutton']['addtask']
              ['translation'],
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.amberAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.desktop_mac, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () {},
          //  Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Addondemanddate())),
          label: AppConstantsValue.appConst['floatingbutton']['addondemand']
              ['translation'],
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.directions_walk, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () {
            // NavigationHelper.navigatetoAddwalkinservice(context);
          },
          label: AppConstantsValue.appConst['floatingbutton']['addwalkin']
              ['translation'],
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.lightBlueAccent,
        ),
      ],
    );
  }
}
