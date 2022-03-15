import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:audio_webview/webview_types/inapp_webview/flutter_inappwebview_main_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_config.dart';
import 'webview_types/flutter_webview_plugin_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {

  ReceivePort _port = ReceivePort();


  @override
  void initState() {
    // initializeObeSignal();
    FlutterNativeSplash.remove();
    // if (Platform.isAndroid){ WebView.platform = SurfaceAndroidWebView();}
    if(!Platform.isIOS){
      IsolateNameServer.registerPortWithName(
          _port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        String id = data[0];
        DownloadTaskStatus status = data[1];
        int progress = data[2];
        setState(() {});
      });

      FlutterDownloader.registerCallback(downloadCallback);
    }



    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle().copyWith(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced:  true,
          systemNavigationBarColor: Colors.deepPurple
          // systemNavigationBarColor: Colors.pinkAccent,
        ));
    //
    // SystemUiOverlayStyle.dark.copyWith(
    //   statusBarColor: Colors.black,
    //   statusBarBrightness: Brightness.dark,
    //   statusBarIconBrightness: Brightness.dark,
    //
    // );



    super.initState();
  }

  @override
  void dispose() {
    if(!Platform.isIOS) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        // theme: ThemeData(
        //
        //  backgroundColor: Colors.blue,
        //   // primarySwatch: ,
        //   navigationBarTheme: NavigationBarThemeData(backgroundColor: Colors.green),
        // ),
        // color: Colors.pink,
        debugShowCheckedModeBanner: false,
        home:  Scaffold(
            appBar:
            showAppBar
                ? AppBar(
              // systemOverlayStyle: SystemUiOverlayStyle(
              //   systemStatusBarContrastEnforced: true,
              //   statusBarBrightness: Brightness.light,
              //    ),
                    centerTitle: true,
                    title: Text(appBarTitle),
                    backgroundColor: mainAppColor,
                  )
                : PreferredSize(

                    child:SafeArea(child: SizedBox(),),
                    preferredSize: Size.zero,
                  ),
            body:appWebView[0],
        ));
  }
}
