import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_radio/flutter_radio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radiophone/src/main_drawer.dart';
import 'package:radiophone/src/modules/song_screen.dart';
import 'package:radiophone/src/utils/app_constants.dart';
import 'package:radiophone/src/utils/fullscreenloader.dart';
import 'package:radiophone/src/utils/network_http.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  dynamic radioStationData;
  String countryN;
  String locationCountryName;
  List<Address> addresses;
  String mainCountryName;
  Address first;
  Position currentLocation;
  int productcount = 0;
  void initState() {
    super.initState();
    getRadioStation();
    getLocation();
  }

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    final coordinates = new Coordinates(position.latitude, position.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    // print(" ${first.countryName}");
    setState(() {
      locationCountryName = first.countryName;
      print("Country Name");
      print(locationCountryName);
    });
  }

  getRadioStation() async {
    try {
      setState(() {
        print("Loading True");
        _isLoading = true;
      });
      if (countryN == null || countryN == "") {
        setState(() {
          mainCountryName = locationCountryName;
          print("***********in If*********");
          print(mainCountryName);
        });
      } else {
        mainCountryName = countryN;
        print("***********in else*********");
        print(mainCountryName);
      }
      Map radioStationResponse = await NetworkHttp.getHttpMethod(
          '${AppConstants.apiEndPoint}australia');
      String condition = radioStationResponse['body']['success'];
      print(condition);
      print('=============Get All Slider Response=========================');
      if (condition == "false") {
        print("Not Found");
        setState(() {
          _isLoading = false;
          productcount = 0;
        });
      } else {
        setState(() {
          print("Found");
          print(radioStationResponse);
          productcount = 1;
          _isLoading = false;
          radioStationData = radioStationResponse['body'];
          print(radioStationData);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget country(dynamic countryName, String img) {
    String imagename = img.toLowerCase();

    return InkWell(
      onTap: () async {
        String _sysLng = ui.window.locale.countryCode;
        print(_sysLng);
        setState(() {
          countryN = countryName;
          print("==");
          print(countryN);
        });

        try {
          setState(() {
            print("Loading True");
            _isLoading = true;
          });

          Map radioStationResponse = await NetworkHttp.getHttpMethod(
              '${AppConstants.apiEndPoint}$countryN');

          print(
              '=============Get All Slider Response=========================');
          print(radioStationResponse['body']);

          setState(() {
            _isLoading = false;
            productcount = 1;
            radioStationData = radioStationResponse['body'];
          });
          Navigator.pop(context);
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } catch (e) {
          print(e);
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/flag/$imagename.png',
              height: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Text('${countryName.toString()}'),
          ],
        ),
      ),
    );
  }

  Future<void> countryDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Country'),
          content: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.height / 2,
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/country.json'),
                    builder: (context, snapshot) {
                      File file = new File("assets/demo.png");
                      String fileName = file.path.split('/').last;
                      print(fileName);
                      var countryData = json.decode(snapshot.data.toString());
                      print("---------------Conutry Data");
                      print(countryData);
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: countryData == null
                            ? 0
                            : countryData['results'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return country(
                            countryData['results'][index]['country'],
                            countryData['results'][index]['flag_name'],
                          );
                        },
                      );
                    }),
              ),
              _isLoading ? FullScreenLoader() : SizedBox()
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _radioListCard() {
    String url =
        "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3";

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SongScreen()));
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SingleChildScrollView(
                child: (radioStationData['data'].length != null &&
                        radioStationData['data'].length != 0)
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (radioStationData['data'].length != null &&
                                radioStationData['data'].length != 0)
                            ? radioStationData['data'].length
                            : 0,
                        itemBuilder: (BuildContext context, index) {
                          String img = NetworkImage('https://youradio.tv/png/' +
                                  radioStationData['data'][index]['logo_top'])
                              .toString();
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 80.0,
                                      width: 80.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: 'https://youradio.tv/png/' +
                                              radioStationData['data'][index]
                                                  ['logo_top'],
                                          placeholder: (context, url) =>
                                              SizedBox(
                                            height: 20,
                                            width: 20,
                                            child:
                                                new CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                        // child: Image(
                                        //   image: NetworkImage(
                                        //       'https://youradio.tv/png/' +
                                        //           radioStationData['data']
                                        //               [index]['logo_top']),
                                        // ),
                                      ),
                                    ),
                                    Container(
                                        height: 80.0,
                                        width: 80.0,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.play_circle_filled,
                                            size: 42,
                                          ),
                                          color: Colors.white.withOpacity(0.7),
                                          onPressed: () {
                                            // FlutterRadio.play(url: url);
                                          },
                                          // size: 42.0,
                                        ))
                                  ],
                                ),
                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      radioStationData['data'][index]
                                                  ['name_en'] !=
                                              null
                                          ? radioStationData['data'][index]
                                              ['name_en']
                                          : "Station Name not found!",
                                      style: TextStyle(
                                          color: Color(0xff2F0D35),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      radioStationData['data'][index]
                                                  ['category_gr'] !=
                                              null
                                          ? radioStationData['data'][index]
                                              ['category_gr']
                                          : "Station Name not found!",
                                      style: TextStyle(
                                          color:
                                              Colors.blueGrey.withOpacity(0.8),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.favorite),
                                  color: Color(0xff2F0D35),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        child: Center(
                        child: Text("No Station Found!"),
                      )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: new MainDrawer(),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xff2F0D35),
        elevation: 0,
        centerTitle: true,
        title: Text("Top Stations"),
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.globe,
                color: Colors.white,
              ),
              onPressed: () {
                countryDialog();
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => MyApp()));
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: SingleChildScrollView(
              child: _isLoading
                  ? FullScreenLoader()
                  : Column(
                      children: productcount == 1
                          ? <Widget>[
                              _radioListCard(),
                            ]
                          : <Widget>[
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Image.asset("assets/no2.png"),
                              ),
                            ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
