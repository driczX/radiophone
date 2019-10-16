import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:redux/redux.dart';

import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_repository.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';

import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';

import 'package:tudo/src/utils/navigation_helper.dart';

import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/tudo_selection_widget/TudoConditionWidget.dart';

import 'package:tudo/src/widgets/tudo_text_widget/TudoNumberWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoTextWidget.dart';

import 'bsp_licensed_signup/bsp_licensed_signup_page.dart';
import 'bsp_unlicensed_signup/bsp_unlicensed_signup_page.dart';

class BspSignupPage extends StatefulWidget {
  static const String routeName = "/bspSignup";

  @override
  _BspSignupPageState createState() => _BspSignupPageState();
}

class _BspSignupPageState extends State<BspSignupPage>
    with AfterLayoutMixin<BspSignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _bspPhone = TextEditingController();
  final MaskedTextController _bspPhone =
      new MaskedTextController(mask: '(000)-000-0000');
  final TextEditingController _bspBusinessName = TextEditingController();
  final TextEditingController _bspBusinessLegalAddress =
      TextEditingController();
  final TextEditingController _bspBusinessLicense = TextEditingController();
  final TextEditingController _bspLicenseAuthority = TextEditingController();
  final TextEditingController _bspEstYear = TextEditingController();
  final TextEditingController _bspNumberOfEmployee = TextEditingController();
  final TextEditingController _bspBusinessDetailsComment =
      TextEditingController();
  final TextEditingController _countryCodeController =
      new TextEditingController();

  BSPSignupRepository _bspSignupRepository = new BSPSignupRepository();
  bool bspcheck = false;
  BspSignupCommonModel model = BspSignupCommonModel();
  int radioValue = -1;
  String _alternatephone;
  String _businessname;
  bool addressenabled = false;
  List<dynamic> _type = <dynamic>[];
  Map<String, dynamic> _typeValue;
  String _establishyear;
  String _numberofemployee;
  LocationResult _pickedLocation;
  DateTime selectedDate = DateTime.now();
  bool flexibletime = false;
  DateTime date;
  TimeOfDay time;
  Map<String, dynamic> bspsignupdata = new Map<String, dynamic>();
  bool autovalidate = false;

  @override
  void initState() {
    super.initState();
    print(model);
    _bspNumberOfEmployee.text = "1";
    _bspSignupRepository.getBSTypes().then((businessTypeResponse) {
      print('businessTypeResponse');
      print(businessTypeResponse);
      if (businessTypeResponse['error'] != null) {
      } else {
        setState(() {
          _type = businessTypeResponse['data']['businessTypes'];
        });
      }
    });
    setState(() {
      date = new DateTime.now().add(new Duration(hours: 1));
      time = new TimeOfDay.fromDateTime(date);
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    model = ModalRoute.of(context).settings.arguments;
    if (model == null) {
      model = new BspSignupCommonModel();
    } else {
      print('model for edit');
      _setExistingDetails(model);
    }
  }

  void _setExistingDetails(bspModel) {
    _bspBusinessName.text = bspModel.businessLegalName;
    _bspPhone.text = model.businessPhoneNumber;
    _bspEstYear.text = model.businessYear;
    _bspNumberOfEmployee.text = model.numberofEmployees;
    _bspBusinessLegalAddress.text = model.businessLegalAddress;
    _typeValue = model.businessTypes;
    // List setTypes = _type.where((bspTypeList) {
    //   return bspTypeList['id'] == model.businessType;
    // });
    // print('setTypes');
    // print(setTypes);
    // _typeValue = setTypes[0];
  }

  Widget _buildlegalbusinessname() {
    return new TudoTextWidget(
      controller: _bspBusinessName,
      textCapitalization: TextCapitalization.sentences,
      prefixIcon: Icon(Icons.business),
      labelText: AppConstantsValue.appConst['bspSignup']['legalbusinessname']
          ['translation'],
      hintText: AppConstantsValue.appConst['bspSignup']['legalbusinessname']
          ['translation'],
      validator: (val) =>
          Validators.validateRequired(val, "Business legal name"),
      onSaved: (val) {
        _businessname = val;
        bspsignupdata['businessname'] = _businessname;
      },
    );
  }

  Widget _buildalternatephone() {
    return Row(
      children: <Widget>[
        new Expanded(
          child: new TudoTextWidget(
            controller: _countryCodeController,
            enabled: false,
            prefixIcon: Icon(FontAwesomeIcons.globe),
            labelText: "code",
            hintText: "Country Code",
          ),
          flex: 2,
        ),
        new SizedBox(
          width: 10.0,
        ),
        new Expanded(
          child: new TudoNumberWidget(
            controller: _bspPhone,
            validator: Validators().validateMobile,
            labelText: AppConstantsValue.appConst['bspSignup']['alternatephone']
                ['translation'],
            hintText: AppConstantsValue.appConst['bspSignup']['alternatephone']
                ['translation'],
            prefixIcon: Icon(Icons.phone),
            onSaved: (val) {
              _alternatephone = val;
              bspsignupdata['alternatephone'] = _alternatephone;
            },
          ),
          flex: 5,
        ),
      ],
    );
  }

  Widget _buildestablishedyear() {
    return new TudoNumberWidget(
      controller: _bspEstYear,
      prefixIcon: Icon(FontAwesomeIcons.calendar),
      labelText: AppConstantsValue.appConst['bspSignup']['establishedyear']
          ['translation'],
      hintText: AppConstantsValue.appConst['bspSignup']['establishedyear']
          ['translation'],
      validator: Validators().validateestablishedyear,
      maxLength: 4,
      onSaved: (val) {
        _establishyear = val.trim();
        bspsignupdata['establishyear'] = _establishyear;
      },
    );
  }

  Widget _buildnumberofemployees() {
    return new TudoNumberWidget(
      controller: _bspNumberOfEmployee,
      prefixIcon: Icon(Icons.control_point_duplicate),
      labelText: AppConstantsValue.appConst['bspSignup']['numberofemployees']
          ['translation'],
      hintText: AppConstantsValue.appConst['bspSignup']['numberofemployees']
          ['translation'],
      validator: Validators().validatenumberofemployee,
      onSaved: (val) {
        _numberofemployee = val.trim();
        bspsignupdata['numberofemployes'] = _numberofemployee;
      },
    );
  }

  Widget _buildbusinesslegaladdress() {
    return Row(
      children: <Widget>[
        new Expanded(
          child: new TudoTextWidget(
            prefixIcon: Icon(Icons.business),
            labelText: AppConstantsValue.appConst['bspSignup']
                ['businesslegaladdress']['translation'],
            hintText: AppConstantsValue.appConst['bspSignup']
                ['businesslegaladdress']['translation'],
            controller: _bspBusinessLegalAddress,
            enabled: addressenabled,
            validator: (val) =>
                Validators.validateRequired(val, "Business legal name"),
          ),
          flex: 5,
        ),
        new SizedBox(
          width: 10.0,
        ),
        new Expanded(
          child: new FloatingActionButton(
            backgroundColor: colorStyles['primary'],
            child: Icon(
              FontAwesomeIcons.globe,
              color: Colors.white,
            ),
            elevation: 0,
            onPressed: () async {
              LocationResult result = await LocationPicker.pickLocation(
                context,
                "AIzaSyDZZeGlIGUIPs4o8ahJE_yq6pJv3GhbKQ8",
              );
              print("result = $result");
              setState(() {
                _pickedLocation = result;
                addressenabled = !addressenabled;
              });
              // setState(() => _pickedLocation = result);
              _bspBusinessLegalAddress.text = _pickedLocation.address;
              model.businessGeoLocation = new BusinessGeoLocation(
                lat: _pickedLocation.latLng.latitude.toString(),
                lng: _pickedLocation.latLng.longitude.toString(),
              );
            },
          ),
          flex: 2,
        ),
      ],
    );
  }

  Widget _buildbusinesstype() {
    return FormBuilder(
      autovalidate: autovalidate,
      child: FormBuilderCustomField(
          attribute: "Business type",
          validators: [FormBuilderValidators.required()],
          formField: FormField(
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.perm_identity),
                  labelText: _type == []
                      ? 'Select Personal Identification type'
                      : 'Business type',
                  hintText: "Select Personal Identification type",
                  errorText: field.errorText,
                ),
                isEmpty: _typeValue == [],
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    // isExpanded: true,
                    hint: Text("Select Personal Identification type"),
                    value: _typeValue,
                    isDense: true,
                    onChanged: (dynamic newValue) {
                      print('newValue');
                      print(newValue);
                      setState(() {
                        _typeValue = newValue;
                        field.didChange(newValue);
                      });
                    },
                    items: _type.map(
                      (dynamic value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: new Text(value['name']),
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildlegalbusinesscheck() {
    return TudoConditionWidget(
      text: AppConstantsValue.appConst['bspSignup']['legalbusinesscheck']
          ['translation'],
      errortext: AppConstantsValue.appConst['bspSignup']['errortext']
          ['translation'],
    );
  }

  Widget content(BuildContext context, BspSignupViewModel bspSignupVm) {
    final appBar = AppBar(
      title: Text("BSP Signup"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
      ),
      centerTitle: true,
    );

    final bottomNavigationBar = Container(
      color: Colors.transparent,
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
              _bspPhone.clear();
              _bspBusinessName.clear();
              _bspBusinessLicense.clear();
              _bspLicenseAuthority.clear();
              _bspEstYear.clear();
              _bspNumberOfEmployee.clear();
              _bspBusinessDetailsComment.clear();
              _bspBusinessLegalAddress.clear();
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
              setState(() {
                autovalidate = !autovalidate;
              });
              if (_formKey.currentState.validate()) {
                model.businessLegalName = _bspBusinessName.text;
                model.businessPhoneNumber = _bspPhone.text;
                model.businessYear = _bspEstYear.text;
                model.numberofEmployees = _bspNumberOfEmployee.text;
                model.businessType = _typeValue['id'];
                model.businessLegalAddress = _bspBusinessLegalAddress.text;
                model.businessTypes = _typeValue;
                print('model');
                print(model.licensed);
                if (_typeValue['name'].toLowerCase() ==
                    "Licensed / Registered".toLowerCase()) {
                  model.isLicensed = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BspLicensedSignupPage(
                        bspSignupCommonModel: model,
                      ),
                    ),
                  );
                } else {
                  model.isLicensed = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BspUnlicensedSignupPage(
                        bspSignupCommonModel: model,
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          autovalidate: autovalidate,
          key: _formKey,
          child: Stack(
            children: <Widget>[
              // Background(),
              SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildlegalbusinessname(),
                      _buildalternatephone(),
                      _buildestablishedyear(),
                      _buildnumberofemployees(),
                      SizedBox(
                        height: 5,
                      ),
                      _buildbusinesslegaladdress(),
                      _buildbusinesstype(),
                      _buildlegalbusinesscheck(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BspSignupViewModel>(
      converter: (Store<AppState> store) => BspSignupViewModel.fromStore(store),
      onInit: (Store<AppState> store) {
        _countryCodeController.text =
            store.state.auth.loginUser.user.country.isdCode;
      },
      builder: (BuildContext context, BspSignupViewModel bspSignupVm) =>
          content(context, bspSignupVm),
    );
  }
}

class BspSignupViewModel {
  final LoginUser user;
  BspSignupViewModel({this.user});

  static BspSignupViewModel fromStore(Store<AppState> store) {
    return BspSignupViewModel(
      user: store.state.auth.loginUser,
    );
  }
}
