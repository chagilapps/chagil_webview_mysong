import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../app_config.dart';
import '../../application/links_navigation.dart';
import '../../widget/app_button_bar.dart';
import '../../widget/progress_bar.dart';
import 'inapp_webview_config.dart';

class FlutterInappWebviewMainView extends StatefulWidget {
  const FlutterInappWebviewMainView({Key? key}) : super(key: key);

  @override
  _FlutterInappWebviewMainViewState createState() =>
      _FlutterInappWebviewMainViewState();
}

class _FlutterInappWebviewMainViewState
    extends State<FlutterInappWebviewMainView> {
  InAppWebViewController? _webViewController;
  InappWebviewConfig _config = InappWebviewConfig();
  int _tst = 0;
  String url = appUri.host;
  Uri _uri = appUri;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool _canBack = false;
         await _webViewController!.canGoBack().then((value) => _canBack =value);
        if(_canBack){
          _webViewController!.goBack();
        }
         print("on will pop");
        return false;
        },
      child: Container(
        child: Column(children: <Widget>[
          WebviewProgressBar( progress: progress,),


          Expanded(
            child: Container(
              child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: _uri,
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    android: _config.androidOptions,
                    ios: _config.IOSOptions,
                    crossPlatform: _config.crossPlatform,
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  shouldOverrideUrlLoading: (controller, action) async =>
                      _config.shouldOverrideUrlLoading(controller, action),
                  onLoadStart: (controller, uri) async {
                    if (uri != null) {
                      setState(() {
                        this._uri = uri;
                      });
                    }
                  },
                  onLoadStop: (controller, uri) async {
                    if (uri != null) {
                      setState(() {
                        this._uri = uri;
                      });
                    }
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  onDownloadStart: (controller, uri) {
                    print("onDownloadStart");
                    _config.onDownload(controller, uri);
                  },
                  onCreateWindow: (controller, action) {

                      return _config.onCreateWindow(
                          context, controller, action);


                  }

                  //     (controller, action) async {
                  //   var _linksNavigation = LinksNavigation(
                  //       uri: action.request.url!, controller: controller);
                  //   print("action.request.url ${action.request.runtimeType}");
                  //
                  //   var windowId = print("onCreateWindow");
                  //   print(action.windowId);
                  //   _linksNavigation.onCreateWindow(context, controller, action);
                  //
                  //   return true;
                  // },
                  ),
            ),
          ),
          // appButtonBar(_webViewController),
          // appButtonBar(_webViewController),
        ]),
      ),
    );
  }
}
