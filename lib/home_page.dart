import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:audio_webview/widget/offline_screen.dart';
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
  bool internetConnected = true;
  late var subscription;

  Future checkConnection () async  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setConnectivityState(connectivityResult);
  }

  setConnectivityState (rlt){
    if (rlt == ConnectivityResult.mobile  || rlt == ConnectivityResult.wifi ) {
      setState(() {
        internetConnected = true;
      });
      // I am connected to a mobile network.
    } else{
      // I am connected to a wifi network.
      setState(() {
        internetConnected = false;
      });
    }
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
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
    if(!Platform.isIOS){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle().copyWith(
            statusBarColor: mainAppColor,
            //shows white text on status bar IOS
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            // systemStatusBarContrastEnforced:  true,
            systemNavigationBarColor: mainAppColor,
            // systemNavigationBarColor: Colors.pinkAccent,
          ));
    }

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setConnectivityState(result);
    });
    super.initState();
  }

  @override
  void dispose() {
    if(!Platform.isIOS) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    subscription.cancel();
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
    if(Platform.isIOS){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle().copyWith(
            statusBarColor: mainAppColor,
            //shows white text on status bar IOS
            statusBarBrightness: Brightness.light,
          ));
    }

    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home:  Scaffold(
            appBar:
            showAppBar
                ? AppBar(
                    centerTitle: true,
                    title: Text(appBarTitle),
                    backgroundColor: mainAppColor,
                  )
                : PreferredSize(

                    child:SafeArea(child: SizedBox(),),
                    preferredSize: Size.zero,
                  ),
            body:
                ( internetConnected)?
                OfflineScreen()
                    :
            appWebView[0],

        ));
  }
}
