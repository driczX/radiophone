import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_licensed_signup_terms/bsp_licensed_signup_terms_page.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';

import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/tudo_selection_widget/TudoConditionWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoTextWidget.dart';

class BspUnlicensedSignupPage extends StatefulWidget {
  static const String routeName = "/bspUnlicensedSignup";
  final BspSignupCommonModel bspSignupCommonModel;

  BspUnlicensedSignupPage({
    Key key,
    @required this.bspSignupCommonModel,
  }) : super(key: key);

  @override
  _BspUnlicensedSignupPageState createState() =>
      _BspUnlicensedSignupPageState();
}

class _BspUnlicensedSignupPageState extends State<BspUnlicensedSignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Object> images = List<Object>();
  Future<File> _imageFile;
  @override
  void initState() {
    super.initState();
    debugPrint(
        'BSP SIGNUP DATA: ${widget.bspSignupCommonModel.businessPhoneNumber}');
    debugPrint('BSP SIGNUP DATA: ${widget.bspSignupCommonModel.businessYear}');
    debugPrint(
        'BSP SIGNUP DATA: ${widget.bspSignupCommonModel.numberofEmployees}');
    debugPrint('BSP SIGNUP DATA: ${widget.bspSignupCommonModel.businessType}');
    debugPrint(
        'BSP SIGNUP DATA: ${widget.bspSignupCommonModel.businessLegalName}');
    debugPrint(
        'BSP SIGNUP DATA: ${widget.bspSignupCommonModel.businessLegalAddress}');
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  bool informationislegitimate = false;
  DateTime expirydate1 = DateTime.now();
  DateTime expirydate2 = DateTime.now();

  final format = DateFormat("yyyy-MM-dd");
  final format2 = DateFormat("yyyy-MM-dd");
  final TextEditingController clrbusinesslicense = TextEditingController();
  final TextEditingController clrbusinesslicense2 = TextEditingController();
  final TextEditingController clrissuingauthority = TextEditingController();
  final TextEditingController clrissuingauthority2 = TextEditingController();
  String _licenseno;
  String _licenseno2;
  String _illusingauthority;
  String _illusingauthority2;
  List<String> _type2 = <String>[
    '',
    'Passport',
    'Driving License',
    'Voter ID card',
    'Ration Card',
    'Aadhar',
    'Other Id',
  ];
  String type2 = 'Passport';
  List<String> _type = <String>[
    '',
    'Passport',
    'Driving License',
    'Voter ID card',
    'Ration Card',
    'Aadhar',
    'Other Id',
  ];
  String type = 'Passport';
  Map<String, String> _formdata = {};
  var _myWidgets = List<Widget>();
  int _index = 1;

  void _add() {
    int keyValue = _index;
    _myWidgets = List.from(_myWidgets)
      ..add(Column(
        key: Key("${keyValue}"),
        children: <Widget>[
          _buildidentificationtype1(),
          _builddocumentnumber1(),
          _buildexpirydate1(),
          _buildissuingauthority1(),
          _buildidentificationpictures(),
          _buildinformationislegitmate(),
        ],
      ));

    setState(() => ++_index);
  }

  bool isClicked = false;
  _add1() {
    setState(() {
      isClicked = true;
      ++_index;
    });
  }

  Widget _buildidentificationtype1() {
    return FormBuilder(
      autovalidate: true,
      child: FormBuilderCustomField(
          attribute: "Business type",
          validators: [FormBuilderValidators.required()],
          formField: FormField(
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: AppConstantsValue.appConst['unlicensedsignup']
                      ['identificationtype1']['translation'],
                  hintText: AppConstantsValue.appConst['unlicensedsignup']
                      ['identificationtype1']['translation'],
                  errorText: field.errorText,
                ),
                isEmpty: type == '',
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: type,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        type = newValue;
                        field.didChange(newValue);
                      });
                    },
                    items: _type.map(
                      (String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: new Text(value),
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

  Widget _builddocumentnumber1() {
    return new TudoTextWidget(
      controller: clrbusinesslicense,
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      labelText: AppConstantsValue.appConst['unlicensedsignup']
          ['documentnumber1']['translation'],
      hintText: AppConstantsValue.appConst['unlicensedsignup']
          ['documentnumber1']['translation'],
      validator: Validators().validateLicenseno,
      onSaved: (val) {
        _licenseno = val;
      },
    );
  }

  Widget _buildexpirydate1() {
    return FormField(builder: (FormFieldState state) {
      return DateTimeField(
        decoration: InputDecoration(
            labelText: expirydate1.toString(),
            prefixIcon: Icon(Icons.date_range)),
        format: format,
        onShowPicker: (context, currentValue) async {
          final DateTime picked = await showDatePicker(
              context: context,
              initialDate: expirydate1,
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (picked != null && picked != expirydate1)
            setState(() {
              expirydate1 = picked;
              print(expirydate1);
            });
        },
      );
    });
  }

  Widget _buildissuingauthority1() {
    return new TudoTextWidget(
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      labelText: AppConstantsValue.appConst['unlicensedsignup']
          ['issuingauthority1']['translation'],
      hintText: AppConstantsValue.appConst['unlicensedsignup']
          ['issuingauthority1']['translation'],
      validator: (val) => Validators.validateName(val, "Issuing Authority"),
      onSaved: (val) {
        _illusingauthority = val;
      },
      controller: clrissuingauthority,
    );
  }

  Widget _buildidentificationtype2() {
    return FormBuilder(
      autovalidate: true,
      child: FormBuilderCustomField(
          attribute: "Identification type",
          validators: [FormBuilderValidators.required()],
          formField: FormField(
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: AppConstantsValue.appConst['unlicensedsignup']
                      ['identificationtype2']['translation'],
                  hintText: AppConstantsValue.appConst['unlicensedsignup']
                      ['identificationtype2']['translation'],
                  errorText: field.errorText,
                ),
                isEmpty: type2 == '',
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: type2,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        type2 = newValue;
                        field.didChange(newValue);
                      });
                    },
                    items: _type2.map(
                      (String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: new Text(value),
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

  Widget _builddocumentnumber2() {
    return new TudoTextWidget(
      controller: clrbusinesslicense2,
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      labelText: AppConstantsValue.appConst['unlicensedsignup']
          ['documentnumber2']['translation'],
      validator: Validators().validateLicenseno,
      onSaved: (val) {
        _licenseno2 = val;
      },
    );
  }

  Widget _buildexpirydate2() {
    return FormField(builder: (FormFieldState state) {
      return DateTimeField(
        decoration: InputDecoration(
            labelText: expirydate2.toString(),
            prefixIcon: Icon(Icons.date_range)),
        format: format2,
        onShowPicker: (context, currentValue) async {
          final DateTime picked = await showDatePicker(
            context: context,
            initialDate: expirydate2,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null && picked != expirydate2)
            setState(() {
              expirydate2 = picked;
              print(expirydate2);
            });
        },
      );
    });
  }

  Widget _buildissuingauthority2() {
    return new TudoTextWidget(
      controller: clrissuingauthority2,
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      labelText: AppConstantsValue.appConst['unlicensedsignup']
          ['issuingauthority2']['translation'],
      validator: (val) => Validators.validateName(val, "Issuing authority"),
      onSaved: (val) {
        _illusingauthority2 = val;
      },
    );
  }

  Widget _buildidentificationpictures() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 100,
                  height: 100,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }

  Widget _buildinformationislegitmate() {
    return TudoConditionWidget(
      text:
          "Above entered Identity information is legitimate and accurate to my knowledge",
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("BSP Unlicensed Signup"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
      ),
      actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: _add)],
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
            textColor: Colors.black,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  BspSignupCommonModel model = widget.bspSignupCommonModel;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BspLicensedSignupTermsPage(
                              bspSignupCommonModel: model)));
                }
              }),
        ],
      ),
    );
    return new Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          autovalidate: true,
          key: _formKey,

          child: ListView(
            padding: const EdgeInsets.all(30.0),
            children: _myWidgets,
          ),
          // child: Stack(
          //   children: <Widget>[
          //     // Background(),
          //     SingleChildScrollView(
          //       padding: const EdgeInsets.all(30.0),
          //       child: new Container(
          //         child: new Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             isClicked ? _buildidentificationtype1() : Container(),
          //             isClicked ? _builddocumentnumber1() : Container(),
          //             isClicked ? _buildexpirydate1() : Container(),
          //             isClicked ? _buildissuingauthority1() : Container(),
          //             // _buildidentificationtype1(),
          //             // _builddocumentnumber1(),
          //             // _buildexpirydate1(),
          //             // _buildissuingauthority1(),
          //             // _buildidentificationtype2(),
          //             // _builddocumentnumber2(),
          //             // _buildexpirydate2(),
          //             // _buildissuingauthority2(),
          //             _buildidentificationpictures(),
          //             _buildinformationislegitmate(),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
