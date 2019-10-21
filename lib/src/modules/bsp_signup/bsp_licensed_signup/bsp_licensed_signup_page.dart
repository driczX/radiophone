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
import 'package:tudo/src/modules/bsp_signup/business_details/business_details_page.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoErrorDialog.dart';
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
  final TextEditingController _bspLicenseExpiryDate = TextEditingController();
  final format = new DateFormat.yMMMEd('en-US');

  List<BusinessProfilePicture> _bspLicenseImages =
      new List<BusinessProfilePicture>();
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  List<dynamic> _bspLicenseAuthorityTypes = <dynamic>[];
  Map<String, dynamic> _bspLicenseAuthorityType;
  bool _isvisibleissuingauthority = false;
  // static DateTime _bspLicenseExpiryDate = DateTime.now();

  // String formattedDate = DateFormat('yyyy-MM-dd').format(_bspLicenseExpiryDate);

  bool businesslicensecheck = false;
  int radioValue = -1;
  Future<File> licenceimage;
  Future<File> profilepicture;
  DateTime date;
  TimeOfDay time;
  String _countryId;
  BSPSignupRepository _bspSignupRepository = new BSPSignupRepository();
  bool autovalidate = false;
  bool _isEditMode = false;

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
          _bspLicenseExpiryDate.text =
              (widget.bspSignupCommonModel.licensed[0].bspExpiryDate);
          _bspLicenseAuthorityType =
              widget.bspSignupCommonModel.bspLicenseAuthorityType;
          _isEditMode = true;
          print('is edit mode = $_isEditMode');
        } else {
          _isEditMode = false;
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
    return DateTimeField(
      format: format,
      autocorrect: true,
      autovalidate: false,
      controller: _bspLicenseExpiryDate,
      readOnly: true,
      validator: (date) => date == null ? 'Please enter valid date' : null,
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
          lastDate: DateTime(2100),
        );
      },
    );
    // return FormField(
    //   builder: (FormFieldState state) {
    //     return DateTimeField(
    //       decoration: InputDecoration(
    //         labelText: _bspLicenseExpiryDate.toString(),
    //         prefixIcon: Icon(Icons.date_range),
    //       ),
    //       format: format,
    //       onShowPicker: (context, currentValue) async {
    //         final DateTime picked = await showDatePicker(
    //           context: context,
    //           initialDate: _bspLicenseExpiryDate,
    //           firstDate: DateTime(1900),
    //           lastDate: DateTime.now(),
    //         );
    //         if (picked != null && picked != _bspLicenseExpiryDate)
    //           setState(() {
    //             _bspLicenseExpiryDate = picked;
    //           });
    //         return;
    //       },
    //     );
    //   },
    // );
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
                  prefixIcon: Icon(FontAwesomeIcons.fileContract),
                  labelText: AppConstantsValue.appConst['licensedsignup']
                      ['licenseissuingauthoritytype']['translation'],
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
                        if (newValue['name']
                            .toLowerCase()
                            .contains("other".toLowerCase())) {
                          _isvisibleissuingauthority = true;
                          _bspLicenseAuthorityName.clear();
                        } else {
                          _isvisibleissuingauthority = false;
                          _bspLicenseAuthorityName.clear();
                        }
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

  Widget _buildEditImagePicker(int index) {
    return Stack(
      children: <Widget>[
        Image.file(
          widget.bspSignupCommonModel.licensed[0].bspLicenseImages[index]
              .imageFile,
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
                widget.bspSignupCommonModel.licensed[0].bspLicenseImages
                    .removeAt(index);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildViewImage(int index) {
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
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildbusinesslicensepicture() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          if (widget.bspSignupCommonModel.licensed != null) {
            // Edit Image mode
            return Card(
              clipBehavior: Clip.antiAlias,
              child: _buildEditImagePicker(index),
            );
          } else {
            return _buildViewImage(index);
          }
        } else {
          // Add Image mode
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _openImagePickerModal(context, index);
              },
            ),
          );
        }
      }),
    );
  }

  void _getImage(BuildContext context, int index, ImageSource source) async {
    //  Future<File> imagee = await ImagePicker.pickImage(source: source);
    Future<File> imagee = ImagePicker.pickImage(source: source);
    imagee.then((file) {
      if (file != null) {
        setState(() {
          _imageFile = imagee;
          getFileImage(index);
        });
      }
    });

    Navigator.pop(context);
  }

  void _openImagePickerModal(BuildContext context, int index) {
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0))),
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: colorStyles["primary"], // button color
                        child: InkWell(
                          splashColor: Colors.red, // inkwell color
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(FontAwesomeIcons.image)),
                          onTap: () {
                            _getImage(context, index, ImageSource.gallery);
                          },
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        color: colorStyles["primary"], // button color
                        child: InkWell(
                          splashColor: Colors.red, // inkwell color
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(FontAwesomeIcons.camera)),
                          onTap: () {
                            _getImage(context, index, ImageSource.camera);
                          },
                        ),
                      ),
                    ),
                    // FlatButton(
                    //   color: Colors.red,
                    //   textColor: flatButtonColor,
                    //   child: Text('Use Camera'),
                    //   onPressed: () {
                    //     _getImage(context, index, ImageSource.camera);
                    //   },
                    // ),
                    // FlatButton(
                    //   color: Colors.red,
                    //   textColor: flatButtonColor,
                    //   child: Text('Use Gallery'),
                    //   onPressed: () {
                    //     _getImage(context, index, ImageSource.gallery);
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          );
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
      title: Text("BSP Licensed Details"),
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
                if (_bspLicenseImages.length < 2) {
                  print('less than 2 documents uploaded');
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => ShowErrorDialog(
                      content: Text(
                          'You need to upload atleast 2 documents to proceed next'),
                      title: Text('Document Required'),
                    ),
                  );
                } else {
                  Licensed licensed = new Licensed(
                    bspLicenseImages: _bspLicenseImages,
                    bspLicenseNumber: _bspBusinessLicenseNumber.text,
                    bspAuthority: _bspLicenseAuthorityName.text,
                    bspExpiryDate: _bspLicenseExpiryDate.text,
                    bspIssuing: _bspLicenseAuthorityType['id'],
                  );
                  licensed.bspLicenseNumber = _bspBusinessLicenseNumber.text;
                  licensed.bspExpiryDate = _bspLicenseExpiryDate.text;
                  licensed.bspIssuing = _bspLicenseAuthorityType['id'];
                  licensed.bspAuthority = _bspLicenseAuthorityName.text;
                  listOfLicenses.add(licensed);
                  model.licensed = listOfLicenses;
                  model.bspLicenseAuthorityType = _bspLicenseAuthorityType;
                  print('after adding the license: model:');
                  print(model.toJson());
                  if (_isEditMode) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BusinessDetailsPage(
                          bspSignupCommonModel: model,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BspLicensedSignupTermsPage(
                            bspSignupCommonModel: model),
                      ),
                    );
                  }
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
                  autovalidate: autovalidate,
                  key: _formKey,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.down,
                      // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildbusinesslicenseno(),
                            _buildexpirydate(),
                            _buildlicenseissuingauthority(),
                            _isvisibleissuingauthority
                                ? _buildlicenseauthority()
                                : SizedBox(),
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
