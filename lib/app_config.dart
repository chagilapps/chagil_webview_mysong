
import 'package:flutter/material.dart';

import 'webview_types/flutter_webview_plugin_widget.dart';
import 'webview_types/inapp_webview/flutter_inappwebview_main_view.dart';

//webview Package
List<Widget> appWebView = [
 const FlutterInappWebviewMainView(),
// FlutterWebviewPluginWidget(),
// FlutterWebviewProWidget(),
];


// settings
bool audioBackground = false;
bool showAppBar = true;
//website
// String appUrl = "https://www.mysong.co.il/";
// String appUrl = "https://west-wind.com/wconnect/wcscripts/fileupload.wwd";

Uri appUri =  Uri(
  scheme: 'https',
  host: 'www.mysong.co.il',
  path: '',
);
// Uri appUri =  Uri(
//   scheme: 'https',
//   host: 'west-wind.com',
//   path: 'wconnect/wcscripts/fileupload.wwd',
// );
//developer.mozilla.org/en-US/docs/Web/API/Navigator/share
// Uri appUri =  Uri(
//   scheme: 'https',
//   host: 'developer.mozilla.org',
//   path: 'en-US/docs/Web/API/Navigator/share',
// );

//appbar
String appBarTitle = "My Song App";
Color mainAppColor = Colors.black;

//open links settings: 
bool newTabShowAppBar = true;
bool openExternalLinksInBrowser = false;
bool excludeHostList = true;
bool excludePathList = true;
bool openSpecificHostsInTab = true;
bool openSpecifichostsInLauncher = true;



//url lists
List<String> hostStartWith = ["api","wa"];
List<String> pathContain = ["download"];
List<String> specificHostInTab = ["download",];
List<String> specificHostInBrowser = ["www.facebook.com","www.youtube.com"];


const String oneSignalAndroid = "ed43dc76-674a-485d-b2d0-022cc85ff004";
const String oneSignalIOS = "";