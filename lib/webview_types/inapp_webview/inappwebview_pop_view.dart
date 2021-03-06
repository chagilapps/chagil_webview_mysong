// import 'package:mysong/app_config.dart';
import 'dart:io';

import 'package:audio_webview/widget/loading_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../api/native_sharing.dart';
import '../../app_config.dart';
import '../../application/files_downloader.dart';
import '../../widget/progress_bar.dart';
import '../../widget/tab_close_button.dart';
import 'inapp_webview_config.dart';

class InappwebviewPopView extends StatefulWidget {
  int? windowId;
  Uri? uri;
  bool showAppBar;

  InappwebviewPopView({
    Key? key,
    this.windowId,
    this.uri,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  _InappwebviewPopViewState createState() => _InappwebviewPopViewState();
}

class _InappwebviewPopViewState extends State<InappwebviewPopView> {
  InAppWebViewController? _webViewController;
  late double progress;
  InappWebviewConfig _config = InappWebviewConfig();
  bool isLoading = false;
  String url = "";
  String source = ".mobile_app{display:none!important};";

  @override
  void initState() {
    setState(() {
      progress = 0;
      isLoading = false;
    });
    if (Platform.isIOS) {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      // SystemChrome.setSystemUIOverlayStyle(
      //     SystemUiOverlayStyle().copyWith(
      //       statusBarColor: mainAppColor,
      //       //shows white text on status bar IOS
      //       statusBarBrightness: Brightness.dark,
      //       statusBarIconBrightness: Brightness.light,
      //       systemStatusBarContrastEnforced:  true,
      //       systemNavigationBarColor: mainAppColor,
      //       // systemNavigationBarColor: Colors.pinkAccent,
      //     ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle().copyWith(
        statusBarColor: mainAppColor,
        //shows white text on status bar IOS
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: mainAppColor,
        // systemNavigationBarColor: Colors.pinkAccent,
      ));
    }

    super.initState();
  }

  Icon backIcon = Icon(Icons.close);

  popBackButton(ctx) async {
    bool _canBack = false;

    await _webViewController!.canGoBack().then((value) => _canBack = value);
    if (_canBack) {
      _webViewController!.goBack();
    } else {
      Navigator.of(ctx).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle().copyWith(
        statusBarColor: mainAppColor,
        //shows white text on status bar IOS
        statusBarBrightness: Brightness.dark,
      ));
    }

    if (progress < 1.0) {
      setState(() {
        isLoading = true;
      });
    }
    // }else {
    return WillPopScope(
      onWillPop: () async {
        bool _canBack = false;
        await _webViewController!.canGoBack().then((value) => _canBack = value);
        if (_canBack) {
          _webViewController!.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: (widget.showAppBar)
                ? PreferredSize(
                    preferredSize: Size.fromHeight(35.0),
                    child: AppBar(
                      // systemOverlayStyle: SystemUiOverlayStyle(
                      //     systemStatusBarContrastEnforced: true,
                      //
                      //     statusBarBrightness: Brightness.dark,
                      //      ),
                      automaticallyImplyLeading: false,
                      // brightness: Brightness.dark,
                      // systemOverlayStyle: SystemUiOverlayStyle.dark,
                      // backwardsCompatibility: false,
                      actions: [
                        NativeSharing().shareButton(url:url),
                        TabCloseButton(),

                        // IconButton(
                        //     icon: Icon(
                        //       Icons.close,
                        //       textDirection: TextDirection.ltr,
                        //       size: 20,
                        //     ),
                        //     onPressed: () {
                        //       // popBackButton(context);
                        //       Navigator.of(context).pop();
                        //       if (Platform.isIOS) {
                        //         SystemChrome.setSystemUIOverlayStyle(
                        //             SystemUiOverlayStyle().copyWith(
                        //           statusBarColor: mainAppColor,
                        //           //shows white text on status bar IOS
                        //           statusBarBrightness: Brightness.light,
                        //         ));
                        //       }
                        //     }),
                      ],

                      backgroundColor: mainAppColor,
                      iconTheme: IconThemeData(color: Colors.white),
                    ),
                  )
                : PreferredSize(
                    preferredSize: Size.zero,
                    child: SizedBox(),
                  ),
            body: Column(
              children: [
                WebviewProgressBar( progress: progress,),

                Expanded(
                  child: InAppWebView(
                        windowId: widget.windowId,
                        initialUrlRequest: URLRequest(
                          url: widget.uri,
                        ),
                        initialOptions: InAppWebViewGroupOptions(
                          android: _config.androidOptions,
                          ios: _config.IOSOptions,
                          crossPlatform: _config.crossPlatform,
                        ),
                        onWebViewCreated: (InAppWebViewController controller) {
                          controller.getUrl().then((urli) {
                            setState(() {
                              url = urli.toString();
                            });
                          });
                          _webViewController = controller;
                        },
                        onLoadStart:
                            (InAppWebViewController controller, url) {

                          setState(() {
                            isLoading = true;
                          });
                            },
                        onLoadStop: (InAppWebViewController controller, url) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                        onProgressChanged:
                            (InAppWebViewController controller, int p) {

                          print("progress    ${progress / 100}");
                          setState(() {
                            progress = p / 100;
                          });

                          injectCSS(controller,source);
                        },
                        shouldOverrideUrlLoading: (controller, action) async =>
                            _config.shouldOverrideUrlLoading(
                                controller, action),
                        onCreateWindow: (controller, action) {
                          return _config.onCreateWindow(
                              context, controller, action);
                        },
                        onDownloadStart: (controller, uri) {
                          print("onDownloadStart");
                          _config.onDownload(controller, uri);
                        },
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// }
