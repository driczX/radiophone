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
  bool autovalidate = false;
  bool informationislegitimate = false;
  DateTime expirydate1 = DateTime.now();
  DateTime expirydate2 = DateTime.now();

  final format = DateFormat("yyyy-MM-dd");
  final format2 = DateFormat("yyyy-MM-dd");

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

//  Map<String, String> _formdata = {};
  var _myWidgets = List<Widget>();
  int _index = 0;
  final Map<int, String> identification1Values = Map();
  final Map<int, String> documentValues = Map();
  final Map<int, DateTime> expiryDateValues = Map();
  final Map<int, String> issuingAuthority = Map();
  final Map<int, String> identificationPicturesValues = Map();

  final List<TextEditingController> _documentControllers = List();
  final List<TextEditingController> _issuingauthoritytype = List();
  final List<TextEditingController> _expiryDate = List();
  final List<TextEditingController> _issuingauthority = List();
  final List<List<Object>> _identificationpictures = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  void _add() {
//    TextEditingController controller = TextEditingController();
    int keyValue = _index;
    _myWidgets = List.from(_myWidgets)
      ..add(Column(
        key: Key("$keyValue"),
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            // padding: EdgeInsets.fromLTRB(18,5,18,18),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () {
                          print("CLose pressed");
                          _myWidgets = List.from(_myWidgets)..removeAt(_index);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        _buildidentificationtype1(keyValue),
                        _builddocumentnumber1(keyValue),
                        _builddate(keyValue),
                        _buildissuingauthority1(keyValue),
                        _buildidentificationpictures(keyValue),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ));

    setState(() => ++_index);
  }

  bool isClicked = false;

  /*_add1() {
    setState(() {
      isClicked = true;
      ++_index;
    });
  }*/

  Widget _buildidentificationtype1(int keyValue) {
    TextEditingController controller = TextEditingController();
    _issuingauthoritytype.add(controller);

    return FormBuilder(
      autovalidate: autovalidate,
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
                        type = controller.text = newValue;
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

  Widget _builddocumentnumber1(int keyValue) {
    TextEditingController controller = TextEditingController();
    _documentControllers.add(controller);
    return new TudoTextWidget(
      controller: controller,
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      labelText: AppConstantsValue.appConst['unlicensedsignup']
          ['documentnumber1']['translation'],
      hintText: AppConstantsValue.appConst['unlicensedsignup']
          ['documentnumber1']['translation'],
      validator: Validators().validateLicenseno,
      onSaved: (val) {
        setState(() {
          documentValues[keyValue] = val;
        });
        // _licenseno = val;
      },
    );
  }

  Widget _builddate(int keyValue) {
    TextEditingController controller = TextEditingController();
    _expiryDate.add(controller);
    return DateTimeField(
      format: format,
      autocorrect: true,
      autovalidate: autovalidate,
      controller: controller,
      readOnly: true,
      // validator: (date) => date == null ? 'Please enter valid date' : null,
      decoration: InputDecoration(
          labelText: "Expiry Date",
          hintText: "Expiry Date",
          prefixIcon: Icon(
            FontAwesomeIcons.calendar,
            size: 24,
          )),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }

  Widget _buildissuingauthority1(int keyValue) {
    TextEditingController controller = TextEditingController();
    _issuingauthority.add(controller);
    return new TudoTextWidget(
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      labelText: AppConstantsValue.appConst['unlicensedsignup']
          ['issuingauthority1']['translation'],
      hintText: AppConstantsValue.appConst['unlicensedsignup']
          ['issuingauthority1']['translation'],
      validator: (val) => Validators.validateName(val, "Issuing Authority"),
      onSaved: (val) {
        setState(() {
          issuingAuthority[keyValue] = val;
        });
        // _illusingauthority = issuingAuthority[keyValue] = val;
      },
      controller: controller,
    );
  }

  Widget _buildidentificationpictures(int keyValue) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
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
                  width: 300,
                  height: 300,
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
                        _identificationpictures.add(images);
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
      title: Text("BSP Unlicensed Details"),
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: () async {
                setState(() {
                  autovalidate = !autovalidate;
                });
                if (_formKey.currentState.validate()) {
                  List<Licensed> listOfLicenses = new List<Licensed>();
                  BspSignupCommonModel model = widget.bspSignupCommonModel;
                  for (var i = 0; i < _myWidgets.length; i++) {
                    String document = _documentControllers[i].text;
                    String issuingAuthorityType = _issuingauthoritytype[i].text;
                    String expiryDate = _expiryDate[i].text;
                    String issuingAuthority = _issuingauthority[i].text;
                    //  String picture = _identificationpictures[i].text;
                    print('Document: $document');
                    print('IssuingAuthorityType: $issuingAuthorityType');
                    print('ExpiryDate: $expiryDate');
                    print('IssuingAuthority: $issuingAuthority');
                    print('Picture: ${_identificationpictures.length}');
                    print(_myWidgets.length);
                    Licensed licensed = new Licensed(
                      bspLicenseNumber: document,
                      bspAuthority: issuingAuthority,
                      bspExpiryDate: expiryDate,
                      bspIssuing: issuingAuthorityType,
                    );
                    licensed.bspLicenseNumber = _documentControllers[i].text;
                    licensed.bspExpiryDate = _expiryDate[i].text;
                    licensed.bspIssuing = _issuingauthoritytype[i].text;
                    licensed.bspAuthority = _issuingauthority[i].text;
                    listOfLicenses.add(licensed);
                  }
                  model.unlicensed = listOfLicenses;
                  print(model.toJson());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BspLicensedSignupTermsPage(
                            bspSignupCommonModel: model),
                      ));
                }
              }),
        ],
      ),
    );
    return new Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          _add();
        },
        label: Text(
          "Add License",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        icon: Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Form(
            autovalidate: autovalidate,
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        child: ListView(
                          padding: const EdgeInsets.all(18.0),
                          children: _myWidgets,
                        ),
                      ),
                    ),
                    _buildinformationislegitmate(),
                  ],
                )
              ],
            )),
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
