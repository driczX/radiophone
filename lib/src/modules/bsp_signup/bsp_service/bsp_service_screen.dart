import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/index.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_signup_common_model.dart'
    as BspServices;
import './bsp_service_model.dart' as ServiceList;

class BspServiceScreen extends StatefulWidget {
  final BspServiceBloc _bspServiceBloc;
  final String searchQuery;
  final List<int> servicesIds;
  final Map<String, bool> selection;
  final BspSignupCommonModel bspSignupCommonModel;
  final List<BspServices.Service> selectedServices;
  final Function refresh;

  const BspServiceScreen({
    Key key,
    @required BspServiceBloc bspServiceBloc,
    @required this.bspSignupCommonModel,
    @required this.servicesIds,
    @required this.selection,
    @required this.selectedServices,
    @required this.refresh,
    this.searchQuery,
  })  : _bspServiceBloc = bspServiceBloc,
        super(key: key);

  @override
  BspServiceScreenState createState() {
    return new BspServiceScreenState(_bspServiceBloc);
  }
}

class BspServiceScreenState extends State<BspServiceScreen> {
  final BspServiceBloc _bspServiceBloc;

  BspServiceScreenState(this._bspServiceBloc);
  // Map<String, bool> _selection = {};

  @override
  void initState() {
    super.initState();
    bool isHome = widget.bspSignupCommonModel.isHome;
    bool isWalkIn = widget.bspSignupCommonModel.isWalkin;
    bool isOnDemand = widget.bspSignupCommonModel.isOnDemand;
    this._bspServiceBloc.dispatch(LoadBspServiceEvent(
          countryId: 1,
          isHome: isHome,
          isOnDemand: isOnDemand,
          isWalkin: isWalkIn,
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BspServiceBloc, BspServiceState>(
      bloc: widget._bspServiceBloc,
      builder: (
        BuildContext context,
        BspServiceState currentState,
      ) {
        if (currentState is UnBspServiceState) {
          return Center(child: CircularProgressIndicator());
        }
        if (currentState is ErrorBspServiceState) {
          return new Container(
            child: new Center(
              child: new Text(currentState.errorMessage ?? 'Error'),
            ),
          );
        }
        if (currentState is InBspServiceState) {
          // print(
          //     'in bsp service state, ${currentState.bspServices.servicesByCountry.length}');
          if (currentState.bspServices.servicesByCountry.length == 0) {
            return Container(
              child: Center(
                child: Text("No Services available for this combination"),
              ),
            );
          } else {
            return new Container(
              child:
                  _renderServices(currentState.bspServices.servicesByCountry),
            );
          }
        }
        return Container();
      },
    );
  }

  List<ServicesByCountry> finalList = new List();

  ListView _renderServices(List<ServicesByCountry> lovCountryServices) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.searchQuery != '') {
        finalList.clear();
        lovCountryServices.forEach((ServicesByCountry data) {
          if (data.name
              .toLowerCase()
              .contains(widget.searchQuery.toLowerCase())) {
            setState(() {
              finalList.add(data);
            });
          } else {
            data.services.forEach((ServiceList.Service services) {
              if (services.name
                  .toLowerCase()
                  .contains(widget.searchQuery.toLowerCase())) {
                setState(() {
                  finalList.add(data);
                });
              }
            });
          }
        });
      } else {
        setState(() {
          finalList.clear();
          finalList.addAll(lovCountryServices);
        });
      }
    });
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: finalList.length,
      itemBuilder: (BuildContext context, int index) {
        ServicesByCountry item = finalList[index];
        List itemsList = item.services;
        return ExpansionTile(
          title: Text(item.name),
          children: List.generate(itemsList.length, (i) {
            widget.selection[itemsList[i].name] =
                widget.selection[itemsList[i].name] ?? itemsList[i].isSelected;
            return CheckboxListTile(
              title: Text(itemsList[i].name),
              value: widget.selection[itemsList[i].name],
              onChanged: (val) {
                setState(() {
                  widget.selection[itemsList[i].name] = val;
                  if (val) {
                    widget.servicesIds.add(itemsList[i].id);

                    List<BspServices.Service> services =
                        widget.selectedServices.where((service) {
                      return service.mainCategory == item.name;
                    }).toList();

                    SubCategory subService = new SubCategory(
                      id: itemsList[i].id,
                      name: itemsList[i].name,
                    );

                    List<SubCategory> subCategories = [];
                    if (services.length == 0) {
                      subCategories.add(subService);
                      widget.selectedServices.add(
                        new BspServices.Service(
                          mainCategory: item.name,
                          mainCategoryId: item.id,
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
                    widget.servicesIds.removeWhere((service) {
                      return service == itemsList[i].id;
                    });

                    List<BspServices.Service> services =
                        widget.selectedServices.where((service) {
                      return service.mainCategory == item.name;
                    }).toList();

                    services[0].subCategory.removeWhere((subService) {
                      return subService.id == itemsList[i].id;
                    });
                  }
                });
                print('widget.servicesIds after set state');
                print(widget.servicesIds);
              },
            );
          }),
        );
      },
    );
  }
}
