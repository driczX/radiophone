import 'package:testing/bsp_service/bsp_service_bloc.dart';
import 'package:testing/bsp_service/bsp_service_event.dart';
import 'package:testing/bsp_service/bsp_service_model.dart';
import 'package:testing/bsp_service/bsp_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BspServiceScreen extends StatefulWidget {
  final BspServiceBloc _bspServiceBloc;
  
  final List<int> servicesIds;
  final Map<String, bool> selection;

  const BspServiceScreen({
    Key key,
    @required BspServiceBloc bspServiceBloc,
    @required this.servicesIds,
    @required this.selection,
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
    this._bspServiceBloc.dispatch(LoadBspServiceEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  ListView _renderServices(List<ServicesByCountry> lovCountryServices) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: lovCountryServices.length,
      itemBuilder: (BuildContext context, int index) {
        var item =
            lovCountryServices[index]; // should be outside build function
        List items = item.services;
        return ExpansionTile(
          title: Text(item.name),
          children: List.generate(items.length, (i) {
            widget.selection[items[i].name] =
                widget.selection[items[i].name] ?? items[i].isSelected;
            return CheckboxListTile(
              title: Text(items[i].name),
              value: widget.selection[items[i].name],
              onChanged: (val) {
                setState(() {
                  widget.selection[items[i].name] = val;
                  if (val) {
                    widget.servicesIds.add(items[i].id);
                    print('widget.servicesIds');
                    print(widget.servicesIds);
                  } else {
                    widget.servicesIds.removeWhere((service) {
                      return service == items[i].id;
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BspServiceBloc, BspServiceState>(
      bloc: widget._bspServiceBloc,
      builder: (
        BuildContext context,
        BspServiceState currentState,
      ) {
        if (currentState is UnBspServiceState) {
          return Center(
            child: CircularProgressIndicator()
          );
        }
        if (currentState is ErrorBspServiceState) {
          return new Container(
            child: new Center(
              child: new Text(currentState.errorMessage ?? 'Error'),
            ),
          );
        }
        if (currentState is InBspServiceState) {
          return new Container(
            child: _renderServices(currentState.bspServices.servicesByCountry),
          );
        }
        return Container();
      },
    );
  }
}
