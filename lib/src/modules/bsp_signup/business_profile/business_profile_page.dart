import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tudo/src/modules/bsp_signup/business_details/business_details_page.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/app_constants_value.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoLogoWidget.dart';
import 'package:tudo/src/widgets/tudo_selection_widget/TudoConditionWidget.dart';
import 'package:tudo/src/widgets/tudo_text_widget/TudoTextWidget.dart';

class BusinessProfilePage extends StatefulWidget {
  static const String routeName = "/businessProfile";
  final BspSignupCommonModel bspSignupCommonModel;

  BusinessProfilePage({
    Key key,
    @required this.bspSignupCommonModel,
  }) : super(key: key);

  @override
  _BusinessProfilePageState createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _comment = TextEditingController();
  String _businessSummary;
  Future<File> _profilepicture;
  List<BusinessProfilePicture> _bspProfileImages =
      new List<BusinessProfilePicture>();

  pickprofilepicture(ImageSource source) {
    setState(() {
      _profilepicture = ImagePicker.pickImage(source: source);
    });
  }

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

  Widget _buildbusinessprofilepicture() {
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
    _imageFile.then((file) async {
      BusinessProfilePicture bspProfileImage = new BusinessProfilePicture();
      bspProfileImage.imageFile = file;
      bspProfileImage.imageUrl = '';
      _bspProfileImages.add(bspProfileImage);
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

  Widget _buildLogo() {
    return new TudoLogoWidget();
  }

  Widget _buildlabeluploadprofilepicture() {
    return Text(AppConstantsValue.appConst['businessprofile']
        ['uploadprofilepicture']['translation']);
  }

  Widget _buildcomment() {
    return Container(
      margin: EdgeInsets.all(8.0),
      // hack textfield height
      padding: EdgeInsets.only(bottom: 10.0),
      child: TudoTextWidget(
        controller: _comment,
        maxLines: 9,
        validator: (val) => val.isEmpty ? 'Please enter Comment' : null,
        hintText: "Write your business profile!",
        onSaved: (val) {
          _businessSummary = val.trim();
        },
      ),
    );
  }

  Widget _buildagreeandaccept() {
    return TudoConditionWidget(
      text: AppConstantsValue.appConst['businessprofile']['agreeandaccept']
          ['translation'],
    );
  }

  Widget _buildaccepttudo() {
    return TudoConditionWidget(
      text: AppConstantsValue.appConst['businessprofile']['accepttudo']
          ['translation'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = new AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
      ),
      title: new Text("Business Profile"),
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
              _comment.clear();
              ImageUploadModel().imageFile.delete();
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
                BspSignupCommonModel model = widget.bspSignupCommonModel;
                model.profileComment = _comment.text;
                model.businessProfilePictures = _bspProfileImages;
                print('bspModel stored!');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BusinessDetailsPage(bspSignupCommonModel: model)));
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildLogo(),
                            _buildcomment(),
                            _buildlabeluploadprofilepicture(),
                            _buildbusinessprofilepicture(),
                            _buildagreeandaccept(),
                            _buildaccepttudo(),
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
