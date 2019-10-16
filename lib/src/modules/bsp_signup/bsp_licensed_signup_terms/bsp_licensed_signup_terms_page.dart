import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_page.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';

import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoErrorDialog.dart';
import 'package:tudo/src/widgets/tudo_selection_widget/TudoConditionWidget.dart';

class BspLicensedSignupTermsPage extends StatefulWidget {
  static const String routeName = "/bspLicensedSignupTerms";
  final BspSignupCommonModel bspSignupCommonModel;

  BspLicensedSignupTermsPage({
    Key key,
    @required this.bspSignupCommonModel,
  }) : super(key: key);

  @override
  _BspLicensedSignupTermsPageState createState() =>
      _BspLicensedSignupTermsPageState();
}

class _BspLicensedSignupTermsPageState
    extends State<BspLicensedSignupTermsPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isWalkIn = false;
  bool _isHome = false;
  bool _isOnDemand = false;

  Widget _buildLogo() {
    return new Image(
      image: new AssetImage("assets/logo.png"),
      height: 150,
      width: 150,
    );
  }

  Widget _buildselectcheckbox() {
    return Text(
      AppConstantsValue.appConst['bsplicensedsignupterms']['selectcheck']
          ['translation'],
    );
  }

  // Walkin
  _onCustomerWalkin(value) {
    setState(() {
      _isWalkIn = value;
    });
  }

  Widget _buildCustomerWalkIn() {
    return TudoConditionWidget(
      text: AppConstantsValue.appConst['bsplicensedsignupterms']
          ['CustomerWalkIn']['translation'],
      onChanged: (value) {
        print(value);
        _onCustomerWalkin(value);
      },
      validate: false,
    );
  }

  Widget _buildCustomerWalkInHelp() {
    return Text(
      AppConstantsValue.appConst['bsplicensedsignupterms']['customervisithelp']
          ['translation'],
    );
  }

  // Home
  _onCustomerInHome(value) {
    setState(() {
      _isHome = value;
    });
  }

  Widget _buildCustomerInHome() {
    return TudoConditionWidget(
      text: AppConstantsValue.appConst['bsplicensedsignupterms']
          ['CustomerInHome']['translation'],
      onChanged: (value) {
        _onCustomerInHome(value);
      },
      validate: false,
    );
  }

  Widget _buildCustomerInHomeHelp() {
    return Text(
      AppConstantsValue.appConst['bsplicensedsignupterms']['businesscheckhelp']
          ['translation'],
    );
  }

  // On Demand

  _onCustomerOnDemand(value) {
    setState(() {
      _isOnDemand = value;
    });
  }

  Widget _buildBusinessOnDemand() {
    return TudoConditionWidget(
      text: AppConstantsValue.appConst['bsplicensedsignupterms']
          ['BusinessOnDemand']['translation'],
      onChanged: (value) {
        _onCustomerOnDemand(value);
      },
      validate: false,
    );
  }

  Widget _buildBusinessOnDemandHelp() {
    return Text(AppConstantsValue.appConst['bsplicensedsignupterms']
        ['businessprovidehelp']['translation']);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Bsp Licensed Signup Terms and Condition"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
      ),
      centerTitle: true,
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
            onPressed: () {
              _formKey.currentState.reset();
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
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (_isHome == false &&
                    _isOnDemand == false &&
                    _isWalkIn == false) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => ShowErrorDialog(
                            title: Text('Select Service'),
                            content: Text(
                              'Please select atleast one service type to proceed next',
                            ),
                          ));
                } else {
                  BspSignupCommonModel model = widget.bspSignupCommonModel;
                  model.isWalkin = _isWalkIn;
                  model.isHome = _isHome;
                  model.isOnDemand = _isOnDemand;
                  print(model.toJson());
                  final Route route = MaterialPageRoute(
                      builder: (context) =>
                          BspServicePage(bspSignupCommonModel: model));
                  final result = await Navigator.push(context, route);
                  try {
                    if (result != null) {
                      if (result) {
                        //Return callback here.
                      }
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         BspServicePage(bspSignupCommonModel: model),
                  //   ),
                  // );
                }
              }
            },
          ),
        ],
      ),
    );
    return new Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            // Background(),
            SingleChildScrollView(
              child: SafeArea(
                top: false,
                bottom: false,
                child: Form(
                  autovalidate: true,
                  key: _formKey,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.down,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: new Container(
                        // color: Colors.white,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(25)),
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildLogo(),
                            _buildselectcheckbox(),
                            SizedBox(
                              height: 5,
                            ),
                            _buildCustomerWalkIn(),
                            SizedBox(
                              height: 5,
                            ),
                            _buildCustomerWalkInHelp(),
                            Divider(
                              height: 3,
                            ),
                            _buildCustomerInHome(),
                            SizedBox(
                              height: 5,
                            ),
                            _buildCustomerInHomeHelp(),
                            Divider(
                              height: 3,
                            ),
                            _buildBusinessOnDemand(),
                            SizedBox(
                              height: 5,
                            ),
                            _buildBusinessOnDemandHelp(),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
