import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:graphql/utilities.dart' show multipartFileFrom;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudo/src/modules/bsp_dashboard/bsp_main_screen.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_licensed_signup/bsp_licensed_signup_page.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_licensed_signup_terms/bsp_licensed_signup_terms_page.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_page.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_repository.dart';
import 'package:tudo/src/redux/models/app_state.dart';
import 'package:tudo/src/redux/models/login_user.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/utils/navigation_helper.dart';
import 'package:tudo/src/widgets/fullscreenloader.dart';
import 'package:tudo/src/widgets/tudo_selection_widget/TudoConditionWidget.dart';

class BusinessDetailsPage extends StatefulWidget {
  static const String routeName = "/businessDetails";
  final BspSignupCommonModel bspSignupCommonModel;

  BusinessDetailsPage({
    Key key,
    @required this.bspSignupCommonModel,
  }) : super(key: key);

  @override
  _BusinessDetailsPageState createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  final image = 'assets/watch2.png';
  List<Object> images = List<Object>();
  bool _isLoading = false;

  final List<String> _seletedConsents = [
    "You must accept you are over 18 years of age to conitnue",
    "Above entered Identity information is legitimate and accurate to my knowledge",
    "I agree and accept to pay charges incurred in verifying my business background",
    "I Accpet TUDO terms and conditions"
  ];
  @override
  void initState() {
    super.initState();
  }

  Widget _buildbusinessprofilepicture() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 5,
      childAspectRatio: 1,
      children: List.generate(
          widget.bspSignupCommonModel.businessProfilePictures.length, (index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Image.file(
                widget.bspSignupCommonModel.businessProfilePictures[index]
                    .imageFile,
                width: 100,
                height: 100,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildbusinessLicenseimages() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 5,
      childAspectRatio: 1,
      children: List.generate(
          widget.bspSignupCommonModel.licensed[0].bspLicenseImages.length,
          (index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Image.file(
                widget.bspSignupCommonModel.licensed[0].bspLicenseImages[index]
                    .imageFile,
                width: 100,
                height: 100,
              ),
            ],
          ),
        );
      }),
    );
  }

  _showDialogOnGQLFinished(context, header, text, isRedirect) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(header),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(text),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(FontAwesomeIcons.arrowCircleRight),
                      label: Text("Okay"),
                      color: colorStyles["primary"],
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      onPressed: () async {
                        if (isRedirect) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BspMainScreen(),
                            ),
                          );
                          // NavigationHelper.navigatetoMainscreen(context);
                        } else {
                          NavigationHelper.navigatetoBack(context);
                        }
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBusinessHeaders(BusinessDetailsViewModel bdVm) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30.0),
          height: MediaQuery.of(context).size.height / 4,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 40.0,
                ),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                        ),
                        Text(
                          '${widget.bspSignupCommonModel.businessLegalName}',
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '${widget.bspSignupCommonModel.businessLegalAddress}',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/user.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessOwnerDetails(BusinessDetailsViewModel bdVm) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Business Owner Details:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Divider(),
          ListTile(
            title: Text("User Name"),
            subtitle: Text(
                "${bdVm.user.user.profile.firstName} ${bdVm.user.user.profile.lastName}"),
            leading: Icon(Icons.supervised_user_circle),
          ),
          ListTile(
            title: Text("Email"),
            subtitle: Text("${bdVm.user.user.email}"),
            leading: Icon(Icons.email),
          ),
          ListTile(
            title: Text("Phone"),
            subtitle: Text("${bdVm.user.user.mobile}"),
            leading: Icon(Icons.phone),
          ),
          ListTile(
            title: Text("Country"),
            subtitle: Text("${bdVm.user.user.country.name}"),
            leading: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessDetails(BusinessDetailsViewModel bdVm) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Business details:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: 'Edit Business details:',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BspSignupPage(),
                            settings: RouteSettings(
                              arguments: widget.bspSignupCommonModel,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Bussiness Name"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.businessLegalName}',
            ),
            leading: Icon(Icons.business),
          ),
          ListTile(
            title: Text("Bussiness Phone"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.businessPhoneNumber}',
            ),
            leading: Icon(Icons.phone),
          ),
          ListTile(
            title: Text("Business Est. year"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.businessYear}',
            ),
            leading: Icon(Icons.date_range),
          ),
          ListTile(
            title: Text("Number of Employees"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.numberofEmployees}',
            ),
            leading: Icon(Icons.account_box),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessLicenseDeails(BusinessDetailsViewModel bdVm) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Business License Details:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: 'Edit Business License Details:',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BspLicensedSignupPage(
                              bspSignupCommonModel: widget.bspSignupCommonModel,
                            ),
                            settings: RouteSettings(
                              arguments: widget.bspSignupCommonModel,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Business license"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.licensed[0].bspLicenseNumber}',
            ),
            leading: Icon(Icons.business),
          ),
          ListTile(
            title: Text("Business License expiry Date"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.licensed[0].bspExpiryDate}',
            ),
            leading: Icon(Icons.phone),
          ),
          ListTile(
            title: Text("License issuing authority"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.licensed[0].bspAuthority}',
            ),
            leading: Icon(Icons.date_range),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Uploaded Business Profile Pictures"),
          SizedBox(
            height: 5,
          ),
          _buildbusinessLicenseimages(),
        ],
      ),
    );
  }

  Widget _buildBusinessUnLicenseDeails(BusinessDetailsViewModel bdVm) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Business Unlicense Details:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: 'Edit Business Unlicense Details:',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BspLicensedSignupPage(
                                      bspSignupCommonModel:
                                          widget.bspSignupCommonModel,
                                    )));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Business Unlicense"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.licensed[0].bspLicenseNumber}',
            ),
            leading: Icon(Icons.business),
          ),
          ListTile(
            title: Text("Business UnLicense expiry Date"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.unlicensed[0].bspExpiryDate}',
            ),
            leading: Icon(Icons.phone),
          ),
          ListTile(
            title: Text("License issuing authority"),
            subtitle: Text(
              '${widget.bspSignupCommonModel.licensed[0].bspAuthority}',
            ),
            leading: Icon(Icons.date_range),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Uploaded Business Profile Pictures"),
          SizedBox(
            height: 5,
          ),
          _buildbusinessLicenseimages(),
        ],
      ),
    );
  }

  Widget _buildBusinessServiceDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Business Service Details:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: 'Edit Business Service Details:',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BspLicensedSignupTermsPage(
                                      bspSignupCommonModel:
                                          widget.bspSignupCommonModel,
                                    )));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Services your business offeres to your customers:"),
          ),
          SizedBox(
            child: TudoConditionWidget(
              readOnly: true,
              intialValue: widget.bspSignupCommonModel.isWalkin,
              text:
                  "Customer visits my business facility for services rendered by my business (Walk-In Services)",
            ),
          ),
          SizedBox(
            child: TudoConditionWidget(
              readOnly: true,
              intialValue: widget.bspSignupCommonModel.isHome,
              text:
                  "My business personal visits to the customer's place(s) to render business services (In-House Services)",
            ),
          ),
          SizedBox(
            child: TudoConditionWidget(
              readOnly: true,
              intialValue: widget.bspSignupCommonModel.isOnDemand,
              text:
                  "My business personal visits to the customer's place(s) to render business services (In-House Services)",
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _subWidgetBspService(Service services) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              (services.subCategory.length > 0) ? services.mainCategory : '',
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            // height: 500,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: (services.subCategory.length > 0)
                  ? services.subCategory
                      .map(
                        (data) => ListTile(
                          leading: Icon(
                            Icons.check_box,
                            color: colorStyles["primary"],
                          ),
                          title: Text(data.name),
                        ),
                      )
                      .toList()
                  : [
                      Container(),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessService() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "Selected Business Services:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SizedBox(
            // height: 500,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              itemCount: widget.bspSignupCommonModel.services.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int i) {
                return _subWidgetBspService(
                    widget.bspSignupCommonModel.services[i]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedConsents() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Selected Consents",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: 'Edit Selected Consents',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Services your business offeres to your customers:"),
          ),
          SizedBox(
            // height: 500,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: _seletedConsents
                  .map((data) => ListTile(
                        leading: Icon(
                          Icons.check_box,
                          color: colorStyles["primary"],
                        ),
                        title: Text(data),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _onBspSignupClick(BusinessDetailsViewModel bdVm) async {
    setState(() {
      _isLoading = true;
    });
    List<MultipartFile> profileImages = [];
    // List<File> profileImages = [];
    List<BusinessProfilePicture> bspPictures =
        widget.bspSignupCommonModel.businessProfilePictures;

    for (int i = 0; i < bspPictures.length; i++) {
      var byteData = bspPictures[i].imageFile.readAsBytesSync();
      var multipartFile = MultipartFile.fromBytes(
        'photo',
        byteData,
        filename: '${DateTime.now().second}.jpg',
        contentType: MediaType("image", "jpg"),
      );
      profileImages.add(multipartFile);
      // profileImages.add(await multipartFileFrom(bspPictures[i].imageFile));
      print('profileImages');
      print(profileImages);
    }
    // widget.bspSignupCommonModel.businessProfilePictures
    //     .map((BusinessProfilePicture profilePicture) {
    //   var byteData = profilePicture.imageFile.readAsBytesSync();

    //   var multipartFile = MultipartFile.fromBytes(
    //     'photo',
    //     byteData,
    //     filename: '${DateTime.now().second}.jpg',
    //     contentType: MediaType("image", "jpg"),
    //   );
    //   profileImages.add(multipartFile);
    //   print('profileImages');
    //   print(profileImages);
    //   // profileImages.add(profilePicture.imageFile);
    // });

    Map<String, dynamic> bspUserSignUpMap = {
      "userId": int.parse(bdVm.user.user.id),
      "name": widget.bspSignupCommonModel.businessLegalName,
      "phone": widget.bspSignupCommonModel.businessPhoneNumber,
      "businessTypeId": int.parse(widget.bspSignupCommonModel.businessType),
      "settings": {
        "providesOnDemand": widget.bspSignupCommonModel.isOnDemand,
        "providesWalkin": widget.bspSignupCommonModel.isWalkin
      },
      "profilePictures": profileImages,
      "employeesCount":
          int.parse(widget.bspSignupCommonModel.numberofEmployees),
      "agreeToPayForVerification": true,
      "termsAndConditions": [1, 2, 3]
    };
    print('bspUserSignUpMap = $bspUserSignUpMap');
    BSPSignupRepository _bspSignupRepository = BSPSignupRepository();
    Map<String, dynamic> bspSignupResponse =
        await _bspSignupRepository.createMyBusiness(bspUserSignUpMap);
    setState(() {
      _isLoading = false;
    });
    print('bspSignupResponse');
    print(bspSignupResponse);
    if (bspSignupResponse['error'] != null) {
      var errors = bspSignupResponse['error'][0];
      print('errors $errors');
      String errorMsg = errors.message;
      var redirectTo = false;
      _showDialogOnGQLFinished(
        context,
        'Error',
        errorMsg,
        redirectTo,
      );
    } else {
      var redirectTo = true;
      _showDialogOnGQLFinished(
        context,
        'Done',
        'Thank you for signing up as Business Service Provider (BSP), TUDO team review uploaded documents and activate your BSP account once satisfied. Up until then, your Business Profile will be in "Under Review" state. Stay tuned. Any questions? Reach us @1-800-888-TUDO',
        redirectTo,
      );
    }
  }

  // Widget _stickyheader() {
  //   return CustomScrollView(
  //     shrinkWrap: true,
  //     slivers: <Widget>[
  //       SliverToBoxAdapter(
  //         child: Padding(
  //           padding: const EdgeInsets.all(26.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text("Good Morning",
  //                   style: TextStyle(
  //                       fontSize: 32,
  //                       fontWeight: FontWeight.w800,
  //                       color: Colors.white)),
  //               Text("Everyone",
  //                   style: TextStyle(
  //                       fontSize: 32,
  //                       fontWeight: FontWeight.w800,
  //                       color: Colors.white)),
  //               SizedBox(
  //                 height: 40,
  //               ),
  //               Material(
  //                 elevation: 5.0,
  //                 borderRadius: BorderRadius.all(Radius.circular(30)),
  //                 child: TextField(
  //                   controller: TextEditingController(text: 'Search...'),
  //                   cursorColor: Theme.of(context).primaryColor,
  //                   style: TextStyle(color: Colors.black, fontSize: 18),
  //                   decoration: InputDecoration(
  //                       suffixIcon: Material(
  //                         elevation: 2.0,
  //                         borderRadius: BorderRadius.all(Radius.circular(30)),
  //                         child: Icon(Icons.search),
  //                       ),
  //                       border: InputBorder.none,
  //                       contentPadding:
  //                           EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget content(BuildContext context, BusinessDetailsViewModel bdVm) {
    final appbar = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          NavigationHelper.navigatetoBack(context);
        },
      ),
      title: Text("Business Details"),
      centerTitle: true,
    );

    final bottomNavigationBar = Container(
      color: Colors.transparent,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new FlatButton.icon(
            icon: Icon(FontAwesomeIcons.arrowCircleRight),
            label: Text('Next'),
            color: colorStyles["primary"],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onPressed: () => _onBspSignupClick(bdVm),
          ),
        ],
      ),
    );

    return new Scaffold(
        appBar: appbar,
        bottomNavigationBar: bottomNavigationBar,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              child: new Container(
                child: Column(
                  children: <Widget>[
                    _buildBusinessHeaders(bdVm),
                    SizedBox(height: 20.0),
                    _buildbusinessprofilepicture(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildBusinessOwnerDetails(bdVm),
                    SizedBox(height: 20.0),
                    _buildBusinessDetails(bdVm),
                    SizedBox(height: 20.0),
                    // widget.bspSignupCommonModel.isLicensed
                    // ? _buildBusinessLicenseDeails(bdVm)
                    // // : _buildBusinessUnLicenseDeails(bdVm),

                    _buildBusinessLicenseDeails(bdVm),
                    SizedBox(height: 20.0),
                    _buildBusinessServiceDetails(),
                    SizedBox(height: 20.0),
                    _buildBusinessService(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildSelectedConsents(),
                  ],
                ),
              ),
            ),
            _isLoading ? FullScreenLoader() : SizedBox(),
          ],
        )

        //  SingleChildScrollView(
        //   child: Stack(
        //     children: <Widget>[
        //       Container(
        //         margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        //         child: Column(
        //           children: <Widget>[
        //             _buildBusinessHeaders(bdVm),
        //             SizedBox(height: 20.0),
        //             _buildbusinessprofilepicture(),
        //             SizedBox(
        //               height: 20.0,
        //             ),
        //             _buildBusinessOwnerDetails(bdVm),
        //             SizedBox(height: 20.0),
        //             _buildBusinessDetails(bdVm),
        //             SizedBox(height: 20.0),
        //             // widget.bspSignupCommonModel.isLicensed
        //             // ? _buildBusinessLicenseDeails(bdVm)
        //             // // : _buildBusinessUnLicenseDeails(bdVm),

        //             _buildBusinessLicenseDeails(bdVm),
        //             SizedBox(height: 20.0),
        //             _buildBusinessServiceDetails(),
        //             SizedBox(height: 20.0),
        //             _buildBusinessService(),
        //             SizedBox(
        //               height: 20.0,
        //             ),
        //             _buildSelectedConsents(),
        //           ],
        //         ),
        //       ),
        //       _isLoading ? FullScreenLoader() : SizedBox(),
        //     ],
        //   ),
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BusinessDetailsViewModel>(
      converter: (Store<AppState> store) =>
          BusinessDetailsViewModel.fromStore(store),
      builder: (BuildContext context, BusinessDetailsViewModel bdVm) =>
          content(context, bdVm),
    );
  }
}

class BusinessDetailsViewModel {
  final LoginUser user;
  BusinessDetailsViewModel({this.user});

  static BusinessDetailsViewModel fromStore(Store<AppState> store) {
    return BusinessDetailsViewModel(
      user: store.state.auth.loginUser,
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
