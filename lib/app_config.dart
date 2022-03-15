
import 'package:flutter/material.dart';

import 'webview_types/flutter_webview_plugin_widget.dart';
import 'webview_types/inapp_webview/flutter_inappwebview_main_view.dart';

//webview Package
List<Widget> appWebView = [
 const FlutterInappWebviewMainView(),
// FlutterWebviewPluginWidget(),
// FlutterWebviewProWidget(),
];



//website
// String appUrl = "https://www.mysong.co.il/";
// String appUrl = "https://west-wind.com/wconnect/wcscripts/fileupload.wwd";

Uri appUri =  Uri(
  scheme: 'https',
  host: 'www.mysong.co.il',
  path: '',
);


//appbar
String appBarTitle =  "";
Color mainAppColor = Colors.black;


// settings
bool audioBackground = false;
bool showAppBar = false;
bool newTabShowAppBar = true;

//open links settings:
bool openExternalLinksInBrowser = false;
bool excludeHostList = true;
bool excludePathList = true;
bool openSpecificHostsInTab = true;
bool openSpecifichostsInLauncher = true;



//url lists
List<String> hostStartWith = ["api","wa"];
List<String> pathContain = ["download"];
List<String> specificHostInTab = ["download",];
List<String> specificHostInBrowser = ["www.facebook.com","www.youtube.com","www.instegram.com"];


const String oneSignalAndroid = "032d972e-3b84-42d0-9c42-9e6650829d45";
const String oneSignalIOS = "032d972e-3b84-42d0-9c42-9e6650829d45";