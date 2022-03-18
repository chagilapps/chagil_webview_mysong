import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_config.dart';
import '../dev/dev_prints.dart';
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
      // DevPrint.createLog(.createLog('start Launching url $_url');
       DevPrint.createLog("start Launching url $_url");
      if (Platform.isIOS) {
         DevPrint.createLog("IOS Platform");
        if (_url != null && _url.isNotEmpty) {
           DevPrint.createLog("_url != null");
           DevPrint.createLog(await canLaunch(_url).toString());

          if (await canLaunch(_url)) {
             DevPrint.createLog("canLaunch url");
            final bool _nativeAppLaunchSucceeded = await launch(
              _url,
              forceSafariVC: false,
              universalLinksOnly: true,
            );
            if (!_nativeAppLaunchSucceeded) {
               DevPrint.createLog(" _nativeAppLaunchSucceeded false");
              await launch(_url, forceSafariVC: true);
            } else {
               DevPrint.createLog(" _nativeAppLaunchSucceeded true");
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
       DevPrint.createLog("url luncher error $e");
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
           DevPrint.createLog("0: navigate to page in webview");
          // _loadUrlInApp(controller,uri.toString());
          return NavigationActionPolicy.ALLOW;
        }

      case 1:
        //load with launcher
        {
           DevPrint.createLog("1: navigate to url launcher");
          _launchURL(uri);
          return NavigationActionPolicy.CANCEL;
        }

      case 2:
        //open new tab
        {
           DevPrint.createLog("2: navigate to new tab");
          openInNewTab(uri: uri);
          return NavigationActionPolicy.CANCEL;
        }

      default:
        {
           DevPrint.createLog("default: open in webview");
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
       DevPrint.createLog("linksHandler choice: not start with http \n return 1");
      return 1;
    } else {
       DevPrint.createLog("linksHandler choice: start with http");
      //if the link is not at teh same host of the app host launch in browser
      if (openExternalLinksInBrowser) {
        if (uri.host != appUri.host) {
           DevPrint.createLog("linksHandler choice:extrenal link, open in browser \n return 0");
          return 0;
        }
      }
      // if the host start with is iin excluded list of app openning
      if (excludeHostList) {
        for (var h in hostStartWith) {
          if (uri.host.contains(h)) {
             DevPrint.createLog("linksHandler choice: in excluded host list open in browser,  continue to open in webview \n return 0");
            return 0;
          }
        }
      }
      // if the path contain excluded list of app openning
      if (excludePathList) {
        for (var p in pathContain) {
          if (uri.host.contains(p)) {
             DevPrint.createLog("linksHandler choice: in excluded path list open in browser \n return 0");
            return 0;
          }
        }
      }
      //ifg host is specify to be open in browser
      if (openSpecifichostsInLauncher) {
        for (var p in specificHostInBrowser) {
          if (uri.host == p) {
             DevPrint.createLog("linksHandler choice: specific host open in browser \n return 1");
            return 1;
          }
        }
      }
      //ifg host is specify to be open in tab
      if (openSpecificHostsInTab) {
        for (var p in specificHostInTab) {
          if (uri.host.contains(p)) {
             DevPrint.createLog("linksHandler choice: in excluded list open in tab \n return 2");
            return 2;
          }
        }
      }
    }
     DevPrint.createLog("default http open in webview \n return 0");
    return 0;
  }

  // void loadUrlInExtrenal({required Uri uri}) {
  //   if (!uri.scheme.startsWith("http")) {
  //     _launchURL(uri.toString());
  //     _doNotLoad(controller!);
  //   }
  // }

  onCreateWindow(context, controller, action) {
    DevPrint.createLog("opened new tab with new window created");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return newWindow(windowId: action.windowId);
        },
      ),
    );
  }
}
