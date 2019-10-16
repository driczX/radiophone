import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tudo/src/modules/bsp_dashboard/Bsp_main_drawer.dart';
import 'package:tudo/src/modules/bsp_dashboard/bsp_dashboard_screen.dart';
import 'package:tudo/src/modules/bsp_dashboard/bsp_setting_screen.dart';
import 'package:tudo/src/widgets/floating_button.dart';
import 'package:tudo/src/widgets/platform_adaptive.dart';

class BspMainScreen extends StatefulWidget {
  BspMainScreen({Key key}) : super(key: key);

  @override
  State<BspMainScreen> createState() => new BspMainScreenState();
}

class BspMainScreenState extends State<BspMainScreen> {
  GlobalKey bottomNavigationKey = GlobalKey();
  PageController _tabController;
  String _title;
  int _index;

  ScrollController scrollController;
  bool dialVisible = true;
  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
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

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        //backgroundColor: colorStyles["primary"],
        appBar: new PlatformAdaptiveAppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(
                  icon: new Icon(Icons.watch_later),
                  text: "Tudo",
                ),
                new Tab(
                  icon: new Icon(Icons.timelapse),
                  text: "Bsp 1",
                ),
                new Tab(
                  icon: new Icon(Icons.cancel),
                  text: "Bsp2 nn",
                ),
                //  new Tab(icon: new Icon(Icons.timelapse)),
                // new Tab(icon: new Icon(Icons.cancel)),
              ],
            ),
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

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Find A Job"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text("Companies"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              title: Text("Bookmarks"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profile"),
            ),
          ],
          onTap: (_) {},
        ),
        body: new PageView(
          controller: _tabController,
          onPageChanged: onTabChanged,
          children: <Widget>[
            new BspDashboardTab(),
            // new StatsTab(),
            new BspSettingsTab()
          ],
        ),
        drawer: new BspMainDrawer(),
      ),
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
