import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:after_layout/after_layout.dart';

import 'package:tudo/src/modules/bsp_signup/bsp_licensed_signup_terms/bsp_licensed_signup_terms_page.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_repository.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/tudo_selection_widget/TudoConditionWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoTextWidget.dart';

class BspLicensedSignupPage extends StatefulWidget {
  static const String routeName = "/bspLicensedSignup";

  final BspSignupCommonModel bspSignupCommonModel;

  BspLicensedSignupPage({
    Key key,
    @required this.bspSignupCommonModel,
  }) : super(key: key);

  @override
  _BspLicensedSignupPageState createState() => _BspLicensedSignupPageState();
}

class _BspLicensedSignupPageState extends State<BspLicensedSignupPage>
    with AfterLayoutMixin<BspLicensedSignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bspBusinessLicenseNumber =
      TextEditingController();
  final TextEditingController _bspLicenseAuthorityName =
      TextEditingController();
  final format = DateFormat.yMMMd("en_US");

  List<BusinessProfilePicture> _bspLicenseImages =
      new List<BusinessProfilePicture>();
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  List<dynamic> _bspLicenseAuthorityTypes = <dynamic>[];
  Map<String, dynamic> _bspLicenseAuthorityType;
  static DateTime _bspLicenseExpiryDate = DateTime.now();

  String formattedDate = DateFormat('yyyy-MM-dd').format(_bspLicenseExpiryDate);

  bool businesslicensecheck = false;
  int radioValue = -1;
  Future<File> licenceimage;
  Future<File> profilepicture;
  DateTime date;
  TimeOfDay time;
  String _countryId;
  BSPSignupRepository _bspSignupRepository = new BSPSignupRepository();
  bool autovalidate = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      date = new DateTime.now().add(new Duration(hours: 1));
      time = new TimeOfDay.fromDateTime(date);
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _bspSignupRepository
        .getLicenseAuthority(_countryId)
        .then((listOfLicenseAuthority) {
      if (listOfLicenseAuthority['error'] != null) {
      } else {
        print('listOfLicenseAuthority');
        print(listOfLicenseAuthority);
        setState(() {
          _bspLicenseAuthorityTypes =
              listOfLicenseAuthority['data']['licenceIssuingAuthorities'];
        });
        print('model');
        print(widget.bspSignupCommonModel.licensed);
        if (widget.bspSignupCommonModel.licensed != null) {
          _bspLicenseImages =
              widget.bspSignupCommonModel.licensed[0].bspLicenseImages;
          print(_bspLicenseImages);
          _bspBusinessLicenseNumber.text =
              widget.bspSignupCommonModel.licensed[0].bspLicenseNumber;
          _bspLicenseAuthorityName.text =
              widget.bspSignupCommonModel.licensed[0].bspAuthority;
          _bspLicenseExpiryDate = DateTime.parse(
              widget.bspSignupCommonModel.licensed[0].bspExpiryDate);
          _bspLicenseAuthorityType =
              widget.bspSignupCommonModel.bspLicenseAuthorityType;
        } else {
          print('I am in new mode');
        }
      }
    });
  }

  Widget _buildbusinesslicenseno() {
    return new TudoTextWidget(
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      controller: _bspBusinessLicenseNumber,
      labelText: AppConstantsValue.appConst['licensedsignup']
          ['businesslicenseno']['translation'],
      validator: Validators().validateLicenseno,
    );
  }

  Widget _buildexpirydate() {
    return FormField(
      builder: (FormFieldState state) {
        return DateTimeField(
          decoration: InputDecoration(
            labelText: _bspLicenseExpiryDate.toString(),
            prefixIcon: Icon(Icons.date_range),
          ),
          format: format,
          onShowPicker: (context, currentValue) async {
            final DateTime picked = await showDatePicker(
              context: context,
              initialDate: _bspLicenseExpiryDate,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != _bspLicenseExpiryDate)
              setState(() {
                _bspLicenseExpiryDate = picked;
              });
            return;
          },
        );
      },
    );
  }

  Widget _buildlicenseissuingauthority() {
    return FormBuilder(
      autovalidate: autovalidate,
      child: FormBuilderCustomField(
          attribute: "Issuing Authority",
          validators: [
            FormBuilderValidators.required(),
          ],
          formField: FormField(
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: AppConstantsValue.appConst['licensedsignup']
                      ['licenseissuingauthority']['translation'],
                  errorText: field.errorText,
                ),
                isEmpty: _bspLicenseAuthorityTypes == [],
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    isExpanded: true,
                    hint: Text(AppConstantsValue.appConst['licensedsignup']
                        ['licenseissuingauthority']['translation']),
                    value: _bspLicenseAuthorityType,
                    isDense: true,
                    onChanged: (dynamic newValue) {
                      setState(() {
                        _bspLicenseAuthorityType = newValue;
                        field.didChange(newValue);
                      });
                    },
                    items: _bspLicenseAuthorityTypes.map(
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

  Widget _buildlicenseauthority() {
    return new TudoTextWidget(
      validator: (val) => Validators.validateName(val, "Issuing Authority"),
      controller: _bspLicenseAuthorityName,
      prefixIcon: Icon(Icons.account_circle),
      labelText: AppConstantsValue.appConst['licensedsignup']
          ['licenseissuingauthority']['translation'],
      hintText: AppConstantsValue.appConst['licensedsignup']
          ['licenseissuingauthority']['translation'],
    );
  }

  Widget _buildlabeluploadlicensepicture() {
    return Text(AppConstantsValue.appConst['licensedsignup']
        ['labeluploadlicenpicture']['translation']);
  }

  Widget _buildbusinesslicensepicture() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          if (widget.bspSignupCommonModel.licensed != null) {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Image.file(
                    widget.bspSignupCommonModel.licensed[0]
                        .bspLicenseImages[index].imageFile,
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
                          widget
                              .bspSignupCommonModel.licensed[0].bspLicenseImages
                              .removeRange(index, index + 1);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
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
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          }
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
    _imageFile.then((file) async {
      BusinessProfilePicture bspLicenseImage = new BusinessProfilePicture();
      bspLicenseImage.imageFile = file;
      bspLicenseImage.imageUrl = '';
      _bspLicenseImages.add(bspLicenseImage);
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

  Widget _buildlegalbusinesscheck() {
    return TudoConditionWidget(
      text: AppConstantsValue.appConst['licensedsignup']['legalbusinesscheck']
          ['translation'],
    );
  }

  Widget content(
      BuildContext context, BspLicensedSignupViewModel bspLicensedSignupVm) {
    final appBar = AppBar(
      centerTitle: true,
      title: Text("BSP Licensed Signup"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
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
            onPressed: () {
              _formKey.currentState.reset();
              _bspBusinessLicenseNumber.clear();
              _bspLicenseAuthorityName.clear();
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
                BspSignupCommonModel model = widget.bspSignupCommonModel;
                print(model.licensed);
                List<Licensed> listOfLicenses = new List<Licensed>();
                print('${_bspLicenseAuthorityType['id']}');
                Licensed licensed = new Licensed(
                  bspLicenseImages: _bspLicenseImages,
                  bspLicenseNumber: _bspBusinessLicenseNumber.text,
                  bspAuthority: _bspLicenseAuthorityName.text,
                  bspExpiryDate: _bspLicenseExpiryDate.toString(),
                  bspIssuing: _bspLicenseAuthorityType['id'],
                );
                licensed.bspLicenseNumber = _bspBusinessLicenseNumber.text;
                licensed.bspExpiryDate = _bspLicenseExpiryDate.toString();
                licensed.bspIssuing = _bspLicenseAuthorityType['id'];
                licensed.bspAuthority = _bspLicenseAuthorityName.text;
                listOfLicenses.add(licensed);
                model.licensed = listOfLicenses;
                model.bspLicenseAuthorityType = _bspLicenseAuthorityType;
                print('after adding the license: model:');
                print(model.toJson());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BspLicensedSignupTermsPage(bspSignupCommonModel: model),
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
                  autovalidate: autovalidate,
                  key: _formKey,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.down,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildbusinesslicenseno(),
                            _buildexpirydate(),
                            _buildlicenseissuingauthority(),
                            _buildlicenseauthority(),
                            SizedBox(
                              height: 10,
                            ),
                            _buildlabeluploadlicensepicture(),
                            _buildbusinesslicensepicture(),
                            SizedBox(
                              height: 20,
                            ),
                            _buildlegalbusinesscheck()
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

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BspLicensedSignupViewModel>(
      converter: (Store<AppState> store) =>
          BspLicensedSignupViewModel.fromStore(store),
      onInit: (Store<AppState> store) {
        _countryId = store.state.auth.loginUser.user.country.id.toString();
        print('_countryId');
        print(_countryId);
      },
      builder: (BuildContext context,
              BspLicensedSignupViewModel bspLicensedSignupVm) =>
          content(context, bspLicensedSignupVm),
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

class BspLicensedSignupViewModel {
  final LoginUser user;
  BspLicensedSignupViewModel({this.user});

  static BspLicensedSignupViewModel fromStore(Store<AppState> store) {
    return BspLicensedSignupViewModel(
      user: store.state.auth.loginUser,
    );
  }
}
