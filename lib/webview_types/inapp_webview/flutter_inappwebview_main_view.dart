import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../app_config.dart';
import '../../application/links_navigation.dart';
import '../../widget/app_button_bar.dart';
import '../../widget/progress_bar.dart';
import 'inapp_webview_config.dart';

class FlutterInappWebviewMainView extends StatefulWidget {

  Uri uri;
  FlutterInappWebviewMainView(this.uri);

  @override
  _FlutterInappWebviewMainViewState createState() =>
      _FlutterInappWebviewMainViewState();
}

class _FlutterInappWebviewMainViewState
    extends State<FlutterInappWebviewMainView> {
  InAppWebViewController? _webViewController;
  InappWebviewConfig _config = InappWebviewConfig();
  int _tst = 0;
  String source = """"
  #mobile_menu>ul>li:nth-child(6)>a{display:none!important;}#mobile_menu>ul>li:nth-child(7)>a{display:none!important;}
  .mobile_app{display:none!important}
  #contact_form > div.inner > div.col-md-5.col-xs-12 > ul > li:nth-child(1) > a:nth-child(3){display:none !important;}
  #contact_form > div.inner > div.col-md-5.col-xs-12 > ul > li:nth-child(1) > a:nth-child(4){display:none !important;}
  """;
  // String url = kDevView? devUri.host: appUri.host;
  // Uri _uri = kDevView? devUri : appUri;
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
                    url: widget.uri,
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
                        this.widget.uri = uri;
                      });
                    }
                  },
                  onLoadStop: (controller, uri) async {
                    if (uri != null) {
                      setState(() {
                        this.widget.uri = uri;
                        // controller.injectCSSCode(source: source);
                      });
                    }
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                      injectCSS(controller,source);

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
