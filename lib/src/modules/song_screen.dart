import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radiophone/src/style/colors.dart';
import 'package:radiophone/src/utils/app_constants.dart';
import 'package:radiophone/src/utils/fullscreenloader.dart';
import 'package:radiophone/src/utils/network_http.dart';
import 'dart:ui' as ui;

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
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
  bool isPlaying;
  String playingStationName;
  String playingCategory;
  String playingImage;
  String playingtown;
  String playingCountry;
  bool play = false;
  int _selectedIndex;
  String countryImage;

  String streamUrl;

  void initState() {
    super.initState();
    getRadioStation();
    audioStart();
    getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future playingStatus() async {
    bool isP = await FlutterRadio.isPlaying();
    setState(() {
      isPlaying = isP;
      play = true;
    });
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
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
          '${AppConstants.apiEndPoint}$mainCountryName');
      // print(radioStationResponse);
      String condition = radioStationResponse['body']['success'];
      print(condition);
      print(radioStationResponse['body']['data'][0]['streamLink']);
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

  Future<void> countryDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Country',
            style: TextStyle(
              fontFamily: 'Proxima',
            ),
          ),
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

  Widget country(dynamic countryName, String img) {
    String imagename = img.toLowerCase();

    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        String _sysLng = ui.window.locale.countryCode;
        print(_sysLng);
        setState(() {
          countryImage = imagename;
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
              '=============Get All Country Response=========================');
          print(radioStationResponse['body']['success']);
          if (radioStationResponse['body']['success'] == "false") {
            print("Not Found");
            // Navigator.pop(context);
            setState(() {
              _isLoading = false;
              productcount = 0;
            });
          } else {
            // Navigator.pop(context);
            setState(() {
              _isLoading = false;
              productcount = 1;
              radioStationData = radioStationResponse['body'];
            });
          }

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
            Text(
              '${countryName.toString()}',
              style: TextStyle(
                fontFamily: 'Proxima',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      // elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.transparent,
      child: InkWell(
          onTap: onTap != null
              ? () => onTap()
              : () {
                  print('Not set yet');
                },
          child: child),
    );
  }

  Widget _stationCard() {
    return (radioStationData['data'].length != null &&
            radioStationData['data'].length != 0)
        ? StaggeredGridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            shrinkWrap: true,
            crossAxisSpacing: 8.0,
            addRepaintBoundaries: true,
            mainAxisSpacing: 10.0,
            // padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 16.0),
            children: List.generate(radioStationData['data'].length, (index) {
              return _buildTile(
                  Container(
                    // padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            border: _selectedIndex != null &&
                                    _selectedIndex == index
                                ? Border.all(width: 6, color: appcolor)
                                : Border.all(width: 2, color: Colors.grey),
                          ),
                          height: 100.0,
                          width: 100.0,
                          child: InkWell(
                            onTap: () {
                              setState(() => _selectedIndex = index);
                              print(
                                  "Playing Link is -----------------------------");

                              FlutterRadio.playOrPause(
                                  url: radioStationData['data'][index]
                                      ['streamLink']);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: CachedNetworkImage(
                                imageUrl: 'https://youradio.tv/png/' +
                                    radioStationData['data'][index]['logo_top'],
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        SizedBox(
                          width: 150,
                          child: Text(
                            radioStationData['data'][index]['name_en'] != null
                                ? radioStationData['data'][index]['name_en']
                                : "Station Name not found!",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            radioStationData['data'][index]['town'] != null
                                ? radioStationData['data'][index]['town']
                                : "town",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {});
            }),
            staggeredTiles:
                List.generate(radioStationData['data'].length, (index) {
              return StaggeredTile.extent(1, 150.0);
            }))
        : SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset("assets/no2.png"),
          );
  }

  Widget _buildStation() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: _isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: FullScreenLoader())
            : Column(
                children: productcount == 1
                    ? <Widget>[
                        SizedBox(height: 10),
                        _stationCard(),
                      ]
                    : <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Image.asset("assets/no2.png"),
                        ),
                      ],
              ),
      ),
      // child: SingleChildScrollView(
      //   child: Column(
      //     children: <Widget>[
      //       _demo(),
      //       // s()
      //     ],
      //   ),
      // ),
    );
  }

  Widget miniplayer() {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              height: 30.0,
              width: 30.0,
              child: CircleAvatar(
                radius: 150.0,

                // borderRadius: BorderRadius.circular(100.0),
                child: CachedNetworkImage(
                  imageUrl: playingImage != null ? playingImage : 'demo.jpg',
                  placeholder: (context, url) => SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: new CupertinoActivityIndicator(
                        animating: true,
                        radius: 20.0,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  playingStationName != null
                      ? playingStationName.toString()
                      : "Station Name",
                  style: TextStyle(
                      // color: Color(0xff2F0D35),
                      color: Colors.white,
                      fontFamily: 'Proxima',
                      // fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                Text(
                  '${playingtown.toString()}, ${playingCountry.toString()} ',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Proxima',
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: play
                  ? Icon(
                      Icons.pause_circle_filled,
                      size: 30,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.play_circle_filled,
                      size: 30,
                      color: Colors.white,
                    ),
              onPressed: () {
                FlutterRadio.playOrPause(url: streamUrl);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget playingCard() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 0),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 80.0,
                width: 80.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),

                  child: CachedNetworkImage(
                    imageUrl: playingImage != null ? playingImage : 'demo.jpg',
                    placeholder: (context, url) => SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: new CupertinoActivityIndicator(
                          animating: true,
                          radius: 20.0,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  // child: Image.asset('assets/demo.jpg'),
                  // child: Image(
                  //   image: NetworkImage(
                  //       'https://youradio.tv/png/' +
                  //           radioStationData['data']
                  //               [index]['logo_top']),
                  // ),
                ),
              ),
            ],
          ),
          SizedBox(width: 6.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                playingStationName != null
                    ? playingStationName.toString()
                    : "Station Name",
                style: TextStyle(
                    color: Color(0xff2F0D35),
                    fontFamily: 'Proxima',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              Text(
                playingCategory != null
                    ? playingCategory.toString()
                    : "Category name",
                style: TextStyle(
                    color: Colors.pink,
                    fontFamily: 'Proxima',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${playingtown.toString()}, ${playingCountry.toString()} ',
                style: TextStyle(
                    color: Colors.blueGrey.withOpacity(0.8),
                    fontSize: 14.0,
                    fontFamily: 'Proxima',
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
  }

  Widget bigplayer() {
    return Column(
      children: <Widget>[
        SizedBox(height: 75),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/previous.png',
                      width: 25,
                      height: 15,
                    )),
              ),
              onTap: () async {},
            ),
            SizedBox(width: 32.0),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: play
                        ? Image.asset('assets/Pause.png', height: 56, width: 56)
                        : Image.asset(
                            'assets/Play.png',
                            height: 56,
                            width: 56,
                          )),
              ),
              onTap: () {
                if (play == false) {
                  FlutterRadio.play(url: streamUrl);
                  setState(() {
                    play = true;
                    print(play);
                  });
                } else {
                  setState(() {
                    play = false;
                    print(play);
                  });
                }
                // FlutterRadio.playOrPause(url: streamUrl);
                // setState(() {

                //   // FlutterRadio.stop();
                //   // FlutterRadio.playOrPause(url: streamUrl);
                //   play = !play;
                // });
                // FlutterRadio.playOrPause(url: streamUrl);

                // playingStatus();
              },
            ),
            SizedBox(width: 32.0),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/next.png',
                      width: 25,
                      height: 15,
                    )),
              ),
              onTap: () async {},
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2F0D35),
        onPressed: () {},
        child: countryImage != null
            ? InkWell(
                onTap: () {
                  countryDialog();
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.asset(
                      'assets/flag/$countryImage.png',
                      height: 50,
                    ),
                  ),
                ),
              )
            : IconButton(
                icon: Icon(
                  FontAwesomeIcons.globe,
                  color: Colors.white,
                  size: 33,
                ),
                onPressed: () {
                  countryDialog();
                }),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xff2F0D35),
              elevation: 0,
              expandedHeight: 210.0,
              floating: false,
              automaticallyImplyLeading: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Align(
                    alignment: Alignment.bottomCenter,
                    child: miniplayer(),
                  ),
                  background: Stack(
                    children: <Widget>[
                      Container(
                        height: 350,
                        // width: double.infinity,
                        child: Image.asset(
                          'assets/bigplayer.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      bigplayer(),
                    ],
                  )),
            ),
          ];
        },
        body: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          height: double.infinity,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0)),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: new Container(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: playingCard(),
                        ),
                        Container(
                          height: 60,
                          color: Colors.pink,
                          // height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Google Ads",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Proxima',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        _buildStation(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
