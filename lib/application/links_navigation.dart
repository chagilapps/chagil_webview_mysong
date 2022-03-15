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


  
  static  launchURL(url) async {
    String _url;
    _url = url.toString();

    if (Platform.isIOS) {
      if (url != null && _url.isNotEmpty) {
        if (await canLaunch(_url)) {
          final bool _nativeAppLaunchSucceeded = await launch(
            _url,
            forceSafariVC: false,
            universalLinksOnly: true,
          );
          if (!_nativeAppLaunchSucceeded) {
            await launch(_url, forceSafariVC: true);
          }
        }
      }
      } else {
        if (await canLaunch(_url)) {
          await launch(_url);
        } else {
          throw 'Could not launch $url';
        }
      }

  }
  
  //launcher

  _launchURL(url)  {
    launchURL(url);
  }

    NavigationActionPolicy navDecision(int value) {
      switch (value) {
        case 0:
        //load inapp webview
          {
            // _loadUrlInApp(controller,uri.toString());
            return NavigationActionPolicy.ALLOW;
          }

        case 1:
        //load with launcher
          {
            _launchURL(uri);
            return NavigationActionPolicy.CANCEL;
          }

        case 2:
        //open new tab
          {
            openInNewTab(uri: uri);
            return NavigationActionPolicy.CANCEL;
          }

        default:
          {
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
        return 1;
      } else {
        //if the link is not at teh same host of the app host launch in browser
        if (openExternalLinksInBrowser) {
          if (uri.host != appUri.host) {
            return 0;
          }
        }
        // if the host start with is iin excluded list of app openning
        if (excludeHostList) {
          for (var h in hostStartWith) {
            if (uri.host.contains(h)) {
              return 0;
            }
          }
        }
        // if the path contain excluded list of app openning
        if (excludePathList) {
          for (var p in pathContain) {
            if (uri.host.contains(p)) {
              return 0;
            }
          }
        }
        //ifg host is specify to be open in browser
        if (openSpecifichostsInLauncher) {
          for (var p in specificHostInBrowser) {
            if (uri.host == p) {
              return 1;
            }
          }
        }
        //ifg host is specify to be open in tab
        if (openSpecificHostsInTab) {
          for (var p in specificHostInTab) {
            if (uri.host.contains(p)) {
              return 2;
            }
          }
        }
      }
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