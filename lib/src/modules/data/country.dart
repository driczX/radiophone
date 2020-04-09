import 'dart:convert';

import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Load local JSON file"),
        ),
        body: Container(
          child: Center(
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/country.json'),
                builder: (context, snapshot) {
                  var countryData = json.decode(snapshot.data.toString());
                  print(countryData);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // return Text("Name: " + countryData['results'][index]['flag_name']);

                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text("Name: " +
                                countryData['results'][index]['flag_name']),
                          ],
                        ),
                      );
                    },
                    itemCount: countryData == null ? 0 : countryData.length,
                  );
                }),
          ),
        ));
  }
}
