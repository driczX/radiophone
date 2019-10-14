import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/validator.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoTextWidget.dart';

class BspUnlicensedWidget extends StatefulWidget {
  @override
  _BspUnlicensedWidgetState createState() => _BspUnlicensedWidgetState();
}

class _BspUnlicensedWidgetState extends State<BspUnlicensedWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Object> images = List<Object>();
  Future<File> _imageFile;
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

  int userinputValue = 0;
  bool informationislegitimate = false;

  static DateTime expirydate1 = DateTime.now();
  var formateexpirydate = DateFormat('yyyy-MM-dd').format(expirydate1);
  final format = DateFormat("yyyy-MM-dd");

  final TextEditingController _photoidentitydocumentno =
      TextEditingController();

  final TextEditingController _clrissuingauthority = TextEditingController();

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
                    // onChang,
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
      controller: _photoidentitydocumentno,
      prefixIcon: Icon(FontAwesomeIcons.idCard),
      labelText: AppConstantsValue.appConst['unlicensedsignup']
          ['documentnumber1']['translation'],
      hintText: AppConstantsValue.appConst['unlicensedsignup']
          ['documentnumber1']['translation'],
      validator: Validators().validateLicenseno,
    );
  }

  Widget _buildexpirydate1() {
    return FormField(builder: (FormFieldState state) {
      return DateTimeField(
        decoration: InputDecoration(
          labelText: expirydate1.toString(),
          prefixIcon: Icon(Icons.date_range),
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final DateTime picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (picked != null && picked != expirydate1)
            setState(() {
              expirydate1 = picked;
              print(expirydate1);
            });
          return;
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
      controller: _clrissuingauthority,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Form(
        autovalidate: true,
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
                    _buildidentificationtype1(),
                    _builddocumentnumber1(),
                    _buildexpirydate1(),
                    _buildissuingauthority1(),
                    _buildidentificationpictures(),
                  ],
                ),
              ),
            ),
          ],
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
