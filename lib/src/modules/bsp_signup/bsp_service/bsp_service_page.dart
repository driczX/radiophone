import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/index.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart'
    as BspServices;
import 'package:tudo/src/modules/bsp_signup/business_profile/business_profile_page.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoErrorDialog.dart';

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
  List<BspServices.Service> selectedServices = [];
  SearchBarController _controller = new SearchBarController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ShowErrorDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _bspServiceBloc = new BspServiceBloc();
    final appBar = SearchBar(
      controller: _controller,
      onQueryChanged: (String query) {
        print('Search Query $query');
        setState(() {
          _searchText = query;
        });
      },
      defaultBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              refresh();
              NavigationHelper.navigatetoBack(context);
            }),
        title: Text('Select Services'),
      ),
    );

    final bottomNavigationBar = Container(
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
            icon: Icon(FontAwesomeIcons.arrowCircleRight),
            label: Text('Next'),
            color: colorStyles["primary"],
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onPressed: () {
              BspSignupCommonModel model = widget.bspSignupCommonModel;
              model.servicesIds = servicesIds;
              model.services = selectedServices;
              print('servicesIds at the next button');
              print(servicesIds);
              print(model.toJson());
              if (servicesIds.length == 0) {
                _showErrorDialog(
                    'You need to select atleast one service to proceed next!');
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessProfilePage(
                      bspSignupCommonModel: model,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
    return new Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: new BspServiceScreen(
        bspServiceBloc: _bspServiceBloc,
        bspSignupCommonModel: widget.bspSignupCommonModel,
        servicesIds: servicesIds,
        selection: selection,
        searchQuery: _searchText,
        selectedServices: selectedServices,
        refresh: refresh,
      ),
    );
  }
}
