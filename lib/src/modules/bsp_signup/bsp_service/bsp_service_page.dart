import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_bloc.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_screen.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';

class BspServicePage extends StatefulWidget {
  static const String routeName = "/bspService";
  final BspSignupCommonModel bspSignupCommonModel;

  BspServicePage({
    Key key,
    @required this.bspSignupCommonModel,
  }) : super(key: key);

  @override
  _BspServicePageState createState() => _BspServicePageState();
}

class _BspServicePageState extends State<BspServicePage> {
  List<int> servicesIds = [];
  Map<String, bool> selection = {};

  SearchBarController _controller = new SearchBarController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Service'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var _bspServiceBloc = new BspServiceBloc();
    return new Scaffold(
      appBar: SearchBar(
        controller: _controller,
        onQueryChanged: (String query) {
          print('Search Query $query');
          setState(() {
            searchText = query;
          });
        },
        defaultBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Select Services'),
        ),
      ),
      body: BspServiceScreen(
        bspServiceBloc: _bspServiceBloc,
        servicesIds: servicesIds,
        selection: selection,
        searchQuery: searchText,
      ),
      bottomNavigationBar: Container(
        height: 56,
        // margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
              onPressed: () {
                print('reseting the state');
                setState(() {
                  selection = {};
                  servicesIds = [];
                });
              },
            ),
            new FlatButton.icon(
              icon: Icon(Icons.ac_unit),
              label: Text('Next'),
              color: Colors.amber,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: () {
                print('servicesIds at the next button');
                print(servicesIds);
                if (servicesIds.length == 0) {
                  _showErrorDialog(
                      'You need to select atleast one service to proceed next!');
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
