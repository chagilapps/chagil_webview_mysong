
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'webview_types/flutter_webview_plugin_widget.dart';
import 'webview_types/inapp_webview/flutter_inappwebview_main_view.dart';

const bool kDevView = false;

//webview Package
// List<Widget> appWebView = [
//  const FlutterInappWebviewMainView(),
// // FlutterWebviewPluginWidget(),
// // FlutterWebviewProWidget(),
// ];



//website
// String appUrl = "https://www.mysong.co.il/";
// String appUrl = "https://west-wind.com/wconnect/wcscripts/fileupload.wwd";

Uri appUri =  Uri(
  scheme: 'https',
  host: 'www.mysong.co.il',
  // host:"chagiltest.netlify.app",
  path: '',
);

Uri devUri =  Uri(
  scheme: 'https',
  host: 'www.w3schools.com',
  path: '/html',
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
List<String> specificHostInBrowser = ["www.facebook.com","www.instegram.com"];


const String oneSignalAndroid = "032d972e-3b84-42d0-9c42-9e6650829d45";
const String oneSignalIOS = "ae236871-9e59-445b-aaa9-089edef4bb27";

void injectCSS(InAppWebViewController controller, String source) {
  controller.injectCSSCode(source: source);


}