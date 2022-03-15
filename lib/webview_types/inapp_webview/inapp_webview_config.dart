import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../app_config.dart';
import '../../application/files_downloader.dart';
import '../../application/links_navigation.dart';

class InappWebviewConfig {

  AndroidInAppWebViewOptions androidOptions = AndroidInAppWebViewOptions(
    allowFileAccess: true,
    allowContentAccess: true,
    supportMultipleWindows: true,
  );

  IOSInAppWebViewOptions IOSOptions = IOSInAppWebViewOptions(

  );

  InAppWebViewOptions crossPlatform = InAppWebViewOptions(

      useShouldOverrideUrlLoading: true,
      allowFileAccessFromFileURLs: true,
      allowUniversalAccessFromFileURLs: true,
      useOnDownloadStart: true,
      javaScriptCanOpenWindowsAutomatically: true
  );



  NavigationActionPolicy shouldOverrideUrlLoading (controller,action)  {
        var _uri = action.request.url;
        LinksNavigation _linksNavigation = LinksNavigation(uri: _uri!,controller: controller);

        return  _linksNavigation.navDecision(_linksNavigation.linksHandler(uri: _uri));
      }

      Future<bool> onCreateWindow (context,controller, action)  async {
        var _linksNavigation = LinksNavigation(uri: action.request.url!,controller: controller);

        _linksNavigation.onCreateWindow(context, controller, action);

        return true;
      }

      void onDownload (controller, uri){
    String _url =uri.toString();
    _url.lastIndexOf('/');
    String _name = uri.toString().substring(_url.lastIndexOf('/')+1);

        FileDownloader _downloader = FileDownloader();
        print("url to download $uri");

        _downloader.newDownload(_name,uri.toString());
  }


}
