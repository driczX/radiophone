import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tudo/src/modules/cmr_dashboard/cmr_dashboard_screen.dart';
import 'package:tudo/src/modules/cmr_dashboard/cmr_setting_screen.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/widgets/floating_button.dart';
import 'package:tudo/src/widgets/main_drawer.dart';
import 'package:tudo/src/widgets/platform_adaptive.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  GlobalKey bottomNavigationKey = GlobalKey();
  PageController _tabController;
  String _title;
  int _index;
  // int _page = 0;
  ScrollController scrollController;
  bool dialVisible = true;
  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    _title = TabItems[0].title;
    // _index = 0;

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

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: colorStyles["primary"],
      appBar: new PlatformAdaptiveAppBar(
          title: new Text(
            _title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          platform: Theme.of(context).platform),
      floatingActionButton: FloatingButton(),
      // bottomNavigationBar: new PlatformAdaptiveBottomBar(
      //   currentIndex: _index,
      //   onTap: onTap,
      //   items: TabItems.map((TabItem item) {
      //     return new BottomNavigationBarItem(
      //       title: new Text(
      //         item.title,
      //         style: textStyles['bottom_label'],
      //       ),
      //       icon: new Icon(
      //         item.icon,
      //         size: 25,
      //       ),
      //     );
      //   }).toList(),
      // ),

      // bottomNavigationBar: BottomNavyBar(
      //   backgroundColor: Colors.white,
      //   selectedIndex: _index,
      //   //showElevation: true,
      //   onItemSelected: (index) => setState(() {
      //         _index = index;
      //         _tabController.animateToPage(index,
      //             duration: Duration(milliseconds: 300), curve: Curves.ease);
      //       }),
      //   items: [
      //     BottomNavyBarItem(
      //       icon: Icon(
      //         Icons.dashboard,
      //         color: colorStyles["primary"],
      //       ),
      //       title: Text('Dashboard'),
      //       activeColor: colorStyles["primary"],
      //     ),
      //     BottomNavyBarItem(
      //         icon: Icon(
      //           Icons.settings,
      //           color: colorStyles["primary"],
      //         ),
      //         title: Text('Setting'),
      //         activeColor: colorStyles["primary"]),
      //     BottomNavyBarItem(
      //         icon: Icon(
      //           Icons.message,
      //           color: colorStyles["primary"],
      //         ),
      //         title: Text('Messages'),
      //         activeColor: colorStyles["primary"]),
      //     BottomNavyBarItem(
      //         icon: Icon(
      //           Icons.settings,
      //           color: colorStyles["primary"],
      //         ),
      //         title: Text('Settings'),
      //         activeColor: colorStyles["primary"]),
      //   ],
      // ),
      // bottomNavigationBar: FancyBottomNavigation(
      //   tabs: [
      //     TabData(iconData: Icons.home, title: "Home", onclick: () {}),
      //     TabData(
      //       iconData: Icons.search,
      //       title: "Search",
      //       onclick: () {},
      //     ),
      //     TabData(iconData: Icons.settings, title: "Basket")
      //   ],
      //   initialSelection: 1,
      //   key: bottomNavigationKey,
      //   onTabChangedListener: (tab) {
      //     _tabController.jumpToPage(tab);
      //     setState(() {
      //       this._index = tab;
      //     });
      //   },
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        // key: _bottomNavigationKey,
        // index: 0,
        //  height: 50.0,
        //initialIndex: 1,

        items: <Widget>[
          Icon(
            Icons.dashboard,
            size: 23,
            color: Colors.black87,
          ),
          // Icon(Icons.search, size: 30),
          Icon(
            Icons.settings,
            size: 25,
            color: Colors.black87,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: colorStyles['primary'],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (tab) {
          _tabController.jumpToPage(tab);
          setState(() {
            this._index = tab;
          });
        },
      ),
      body: new PageView(
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          new DashboardTab(),
          // new StatsTab(),
          new SettingsTab()
        ],
      ),
      drawer: new MainDrawer(),
    );
  }

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._index = tab;
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
  const TabItem(title: 'Settings', icon: Icons.settings)
];
