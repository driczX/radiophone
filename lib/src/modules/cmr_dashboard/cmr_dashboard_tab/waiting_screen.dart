import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tudo/src/styles/colors.dart';

final List rooms = [
  {"image": "assets/map.png", "title": "Catering Service"},
  {"image": "assets/map.png", "title": "Developing"},
  {"image": "assets/map.png", "title": "Cooking Service"},
  {"image": "assets/map.png", "title": "Event Management"},
];

class Waitingscreen extends StatelessWidget {
  static final String path = "lib/src/pages/hotel/hhome.dart";
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0.0,
      title: Text("Waiting"),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
    final bottomNavigationBar = Container(
      height: 56,
      //margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new FlatButton.icon(
            icon: Icon(Icons.close),
            label: Text('Clear'),
            color: Colors.redAccent,
            textColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return _buildRooms(context, index);
            }, childCount: 100),
          )
        ],
      ),
    );
  }

  Widget _buildRooms(BuildContext context, int index) {
    var room = rooms[index % rooms.length];
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(room['image']),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Icon(
                        Icons.star,
                        color: Colors.grey.shade800,
                        size: 20.0,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Icon(
                        Icons.star_border,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                    Positioned(
                      bottom: 20.0,
                      right: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        child: Text("\$40"),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        room['title'],
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("Bouddha, Kathmandu"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "(220 reviews)",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;

  const Category(
      {Key key,
      @required this.icon,
      @required this.title,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(title, style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
