import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: new Stack(
        children: <Widget>[
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white12,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  // color: Colors.white,
                  borderRadius: new BorderRadius.circular(10.0)),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                      child: new Container(
                        child: CupertinoActivityIndicator(
                          animating: true,
                          radius: 20.0,
                        ),
                      ),
                    ),
                  ),
                  // new Center(
                  //   child: new SizedBox(
                  //     height: 50.0,
                  //     width: 50.0,
                  //     child: new Loader(
                  //       color: colorStyles["primary"],
                  //     ),
                  //     // child: new CircularProgressIndicator(
                  //     //   valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  //     //   value: null,
                  //     //   strokeWidth: 7.0,
                  //     // ),
                  //   ),
                  // ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "Loading.....",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
