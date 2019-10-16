import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_bloc.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_event.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_model.dart';
import 'package:tudo/src/modules/bsp_signup/bsp_service/bsp_service_state.dart';

class BspServiceScreen extends StatefulWidget {
  final BspServiceBloc _bspServiceBloc;
  final String searchQuery;
  final List<int> servicesIds;
  final Map<String, bool> selection;

  const BspServiceScreen({
    Key key,
    @required BspServiceBloc bspServiceBloc,
    @required this.servicesIds,
    @required this.selection,
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
    this._bspServiceBloc.dispatch(LoadBspServiceEvent());
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
          return new Container(
            child: _renderServices(currentState.bspServices.servicesByCountry),
          );
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
            data.services.forEach((Service services) {
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
                    print('widget.servicesIds');
                    print(widget.servicesIds);
                  } else {
                    widget.servicesIds.removeWhere((service) {
                      return service == itemsList[i].id;
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

  List<TextSpan> _getSpans(String text, String matchWord, TextStyle style) {
    List<TextSpan> spans = [];
    int spanBoundary = 0;
    if (matchWord == '') {
      spans.add(TextSpan(text: text));
      return spans;
    }
    do {
      // look for the next match
      final startIndex = text.indexOf(matchWord, spanBoundary);

      // if no more matches then add the rest of the string without style
      if (startIndex == -1) {
        spans.add(TextSpan(text: text.substring(spanBoundary)));
        return spans;
      }

      // add any unstyled text before the next match
      if (startIndex > spanBoundary) {
        spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
      }

      // style the matched text
      final endIndex = startIndex + matchWord.length;
      final spanText = text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    } while (spanBoundary < text.length);

    return spans;
  }
}
