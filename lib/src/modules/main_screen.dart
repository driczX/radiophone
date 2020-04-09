import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radiophone/src/modules/song_screen.dart';
import 'package:radiophone/src/style/colors.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  GlobalKey bottomNavigationKey = GlobalKey();
  PageController _tabController;
  TabController _tabC;
  String _title;
  int index;

  ScrollController scrollController;
  bool dialVisible = true;
  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    _tabC = new TabController(length: 6, vsync: this);
    _title = TabItems[0].title;

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorStyles['primary'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            title: Text(
              "Top Stations",
              style: TextStyle(
                fontFamily: 'Proxima',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text(
              "Favorites",
              style: TextStyle(
                fontFamily: 'Proxima',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.globe),
            title: Text(
              "Countries",
              style: TextStyle(
                fontFamily: 'Proxima',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.radiation),
            title: Text(
              "Genre",
              style: TextStyle(
                fontFamily: 'Proxima',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(
                fontFamily: 'Proxima',
              ),
            ),
          ),
        ],
        onTap: (tab) {
          _tabController.jumpToPage(tab);
          setState(() {
            this.index = tab;
          });
        },
      ),
      body: new PageView(
        // physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          // new BSPTabScreen(),
          // new StatsTab(),
          SongScreen(),
          Container(
            child: Center(
              child: Text(
                "Favorites Coming soon!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Countries Coming soon!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Genre coming soon!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text(
                "Setting coming soon!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this.index = tab;
    });

    this._title = TabItems[tab].title;
  }
}

class TabItem {
  final String title;
  final IconData icon;
  const TabItem({this.title, this.icon});
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Dashboard', icon: Icons.dashboard),
  //const TabItem(title: 'Request', icon: Icons.timeline),
  const TabItem(title: 'Settings', icon: Icons.settings),
  const TabItem(title: 'Settings', icon: Icons.settings),
  const TabItem(title: 'Settings', icon: Icons.settings),
  const TabItem(title: 'Settings', icon: Icons.settings)
];
