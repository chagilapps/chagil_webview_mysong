 
 
 import 'package:flutter/material.dart';

import '../app_config.dart';

Widget appButtonBar(_webViewController) => ButtonBar(

          alignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: mainAppColor,
              child: Icon(Icons.arrow_back),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController!.goBack();
                }
              },
            ),
            RaisedButton(
              color: mainAppColor,
              child: Icon(Icons.arrow_forward),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController!.goForward();
                }
              },
            ),
            RaisedButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController!.reload();
                }
              },
            ),
          ],
        );