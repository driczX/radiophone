import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_repository.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart'
    as BspServices;
import 'package:tudo/src/modules/bsp_signup/business_profile/business_profile_page.dart';
import 'package:tudo/src/styles/colors.dart';
import 'package:tudo/src/widgets/fullscreenloader.dart';
import 'package:tudo/src/widgets/tudo_custom_widget/TudoErrorDialog.dart';

class BspServicePage extends StatefulWidget {
  BspServicePage({Key key, this.bspSignupCommonModel}) : super(key: key);

  final BspSignupCommonModel bspSignupCommonModel;

  _BspServicePageState createState() => _BspServicePageState();
}

class _BspServicePageState extends State<BspServicePage> {
  List<int> servicesIds = [];
  Map<String, bool> _selection = {};
  List<BspServices.Service> selectedServices = [];
  SearchBarController _controller = new SearchBarController();
  String _searchText = '';
  dynamic _bspServices;
  // Map<String, bool> _selection = {};
  List<dynamic> finalList = new List();
  List<dynamic> searchList = new List();
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    super.initState();
    BspServiceRepository _bspServiceRepo = new BspServiceRepository();
    _bspServiceRepo
        .getBspServices(
      widget.bspSignupCommonModel.countryId,
      widget.bspSignupCommonModel.isHome,
      widget.bspSignupCommonModel.isOnDemand,
      widget.bspSignupCommonModel.isWalkin,
    )
        .then((bspServiceResponse) {
      print('bspServiceResponse');
      print(bspServiceResponse);
      if (bspServiceResponse['error'] != null) {
      } else {
        setState(() {
          _bspServices = bspServiceResponse['data'];
          isLoading = false;
          if (_bspServices != null) {
            finalList = _bspServices['servicesByCountry'];
          }
        });
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ShowErrorDialog(
        title: Text('Service Selection Required!'),
        content: Text(message),
      ),
    );
  }

  Widget _renderServices() {
    setState(() {
      isLoading = false;
    });
    List lovCountryServices = searchList.length != 0 ? searchList : finalList;
    if (lovCountryServices == null || lovCountryServices.length == 0) {
      return Container(
        child: Center(
          child: Text("No Services available for this combination"),
        ),
      );
    }
    // print(lovCountryServices);
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: lovCountryServices.length,
      itemBuilder: (BuildContext context, int index) {
        var item =
            lovCountryServices[index]; // should be outside build function
        List items = item['services'];
        return ExpansionTile(
          title: Text(item['name']),
          children: List.generate(items.length, (i) {
            _selection[items[i]['name']] =
                _selection[items[i]['name']] ?? items[i]['isSelected'];
            return CheckboxListTile(
              title: Text(items[i]['name']),
              value: _selection[items[i]['name']] == null
                  ? false
                  : _selection[items[i]['name']],
              onChanged: (val) {
                setState(() {
                  _selection[items[i]['name']] = val;
                  if (val) {
                    servicesIds.add(items[i]['id']);
                    List<BspServices.Service> services =
                        selectedServices.where((service) {
                      return service.mainCategory == item['name'];
                    }).toList();
                    SubCategory subService = new SubCategory(
                      id: items[i]['id'],
                      name: items[i]['name'],
                    );
                    List<SubCategory> subCategories = [];
                    if (services.length == 0) {
                      subCategories.add(subService);
                      selectedServices.add(
                        new BspServices.Service(
                          mainCategory: item['name'],
                          mainCategoryId: item['id'],
                          subCategory: subCategories,
                        ),
                      );
                    } else {
                      print('services in else');
                      print(services[0].subCategory);
                      subCategories = services[0].subCategory;
                      subCategories.add(subService);
                    }
                  } else {
                    servicesIds.removeWhere((service) {
                      return service == items[i]['id'];
                    });
                    List<BspServices.Service> services =
                        selectedServices.where((service) {
                      return service.mainCategory == item['name'];
                    }).toList();
                    services[0].subCategory.removeWhere((subService) {
                      return subService.id == items[i]['id'];
                    });
                  }
                });
                print('servicesIds after set state');
                print(servicesIds);
              },
            );
          }),
        );
      },
    );
  }

  void _searchFilter() {
    if (_searchText != '') {
      searchList.clear();
      finalList.forEach((dynamic data) {
        print('data');
        print(data);
        if (data['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          setState(() {
            searchList.add(data);
          });
        } else {
          data['services'].forEach((dynamic services) {
            setState(() {
              isLoading = false;
            });
            if (services['name']
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
              setState(() {
                searchList.add(data);
              });
            }
          });
        }
      });
    } else {
      setState(() {
        searchList.clear();
        searchList.addAll(finalList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = SearchBar(
      controller: _controller,
      onQueryChanged: (String query) {
        print('Search Query $query');
        setState(() {
          _searchText = query;
        });
        _searchFilter();
      },
      defaultBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
              // NavigationHelper.navigatetoBack(context);
            }),
        title: Text('Select Services'),
      ),
    );

    final bottomNavigationBar = Container(
      height: 56,
      // margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
              print('reseting the state');
              setState(() {
                _selection = {};
                servicesIds = [];
              });
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
            onPressed: () {
              BspSignupCommonModel model = widget.bspSignupCommonModel;
              model.servicesIds = servicesIds;
              model.services = selectedServices;
              print('servicesIds at the next button');
              print(servicesIds);
              print(model.toJson());
              if (servicesIds.length == 0) {
                _showErrorDialog(
                    'You need to select atleast one service to proceed next!');
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessProfilePage(
                      bspSignupCommonModel: model,
                    ),
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
      body: new Container(
        child: isLoading ? FullScreenLoader() : _renderServices(),
      ),
    );
  }
}
