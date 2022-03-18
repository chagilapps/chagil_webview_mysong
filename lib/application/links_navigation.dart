import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_config.dart';
import '../webview_types/inapp_webview/inappwebview_pop_view.dart';

class LinksNavigation {
  Uri uri;
  InAppWebViewController? controller;

  LinksNavigation({required this.uri, required this.controller});

  newWindow({required int windowId}) {
    return InappwebviewPopView(
      windowId: windowId,
      showAppBar: newTabShowAppBar,
    );
  }

  //specific links to open in new tab

  void openInNewTab({required Uri uri}) {
    AndroidInAppWebViewOptions _android = AndroidInAppWebViewOptions();

    InappwebviewPopView(
      uri: uri,
      showAppBar: newTabShowAppBar,
    );
  }

  static launchURL(url) async {
    String _url;
    _url = url.toString();
    try {
      print("start Launching url $_url");
      if (Platform.isIOS) {
        print("IOS Platform");
        if (_url != null && _url.isNotEmpty) {
          print("_url != null");
          print(await canLaunch(_url));

          if (await canLaunch(_url)) {
            print("canLaunch url");
            final bool _nativeAppLaunchSucceeded = await launch(
              _url,
              forceSafariVC: false,
              universalLinksOnly: true,
            );
            if (!_nativeAppLaunchSucceeded) {
              print(" _nativeAppLaunchSucceeded false");
              await launch(_url, forceSafariVC: true);
            } else {
              print(" _nativeAppLaunchSucceeded true");
            }
          } else {
            await launch(
              _url,
              forceSafariVC: false,
              universalLinksOnly: true,
            );
          }
        }
      } else {
        if (await canLaunch(_url)) {
          await launch(_url);
        } else {
          throw 'Could not launch $url';
        }
      }
    } catch (e) {
      print("url luncher error $e");
    }
  }

  //launcher

  _launchURL(url) {
    launchURL(url);
  }

  NavigationActionPolicy navDecision(int value) {
    switch (value) {
      case 0:
        //load inapp webview
        {
          print("navigate to page in webview");
          // _loadUrlInApp(controller,uri.toString());
          return NavigationActionPolicy.ALLOW;
        }

      case 1:
        //load with launcher
        {
          print("navigate to url launcher");
          _launchURL(uri);
          return NavigationActionPolicy.CANCEL;
        }

      case 2:
        //open new tab
        {
          print("navigate to new tab");
          openInNewTab(uri: uri);
          return NavigationActionPolicy.CANCEL;
        }

      default:
        {
          print("default - open in webview");
          return NavigationActionPolicy.ALLOW;
          // _loadUrlInApp(controller,uri.toString());
        }
    }
  }

  // //do not load - because already strated load, it will go back or reload the current page
  // void _doNotLoad(InAppWebViewController controller) {
  //   controller.goBack();
  // }
  //
  // void _loadUrlInApp(ctr, url) {
  //   ctr!.loadUrl(urlRequest: URLRequest(url: url));
  // }

//on loading page methoscheck url if to launch in different method
  int linksHandler({required Uri uri}) {
    //if the scheme is not http or https (usually api like waze:// or mailto:)
    if (!uri.scheme.startsWith("http")) {
      print("linksHandler choice: not start with http");
      return 1;
    } else {
      print("linksHandler choice: start with http");
      //if the link is not at teh same host of the app host launch in browser
      if (openExternalLinksInBrowser) {
        if (uri.host != appUri.host) {
          print("linksHandler choice:extrenal link, open in browser");
          return 0;
        }
      }
      // if the host start with is iin excluded list of app openning
      if (excludeHostList) {
        for (var h in hostStartWith) {
          if (uri.host.contains(h)) {
            print("linksHandler choice: in excluded host list open in browser");
            return 0;
          }
        }
      }
      // if the path contain excluded list of app openning
      if (excludePathList) {
        for (var p in pathContain) {
          if (uri.host.contains(p)) {
            print("linksHandler choice: in excluded path list open in browser");
            return 0;
          }
        }
      }
      //ifg host is specify to be open in browser
      if (openSpecifichostsInLauncher) {
        for (var p in specificHostInBrowser) {
          if (uri.host == p) {
            print("linksHandler choice: specific host open in browser");
            return 1;
          }
        }
      }
      //ifg host is specify to be open in tab
      if (openSpecificHostsInTab) {
        for (var p in specificHostInTab) {
          if (uri.host.contains(p)) {
            print("linksHandler choice: in excluded list open in tab");
            return 2;
          }
        }
      }
    }
    print("default http open in webview");
    return 0;
  }

  // void loadUrlInExtrenal({required Uri uri}) {
  //   if (!uri.scheme.startsWith("http")) {
  //     _launchURL(uri.toString());
  //     _doNotLoad(controller!);
  //   }
  // }

  onCreateWindow(context, controller, action) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return newWindow(windowId: action.windowId);
        },
      ),
    );
  }
}
