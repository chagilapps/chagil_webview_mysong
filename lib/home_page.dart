import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:audio_webview/webview_types/inapp_webview/Question.dart';
import 'package:audio_webview/webview_types/inapp_webview/disk.dart';
import 'package:audio_webview/webview_types/inapp_webview/flutter_inappwebview_main_view.dart';
import 'package:audio_webview/webview_types/inapp_webview/home.dart';
import 'package:audio_webview/webview_types/inapp_webview/inapp_webview_config.dart';
import 'package:audio_webview/webview_types/inapp_webview/phone.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:audio_webview/widget/offline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_config.dart';
import 'application/links_navigation.dart';
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


  Future checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setConnectivityState(connectivityResult);
  }

  setConnectivityState(rlt) {
    if (rlt == ConnectivityResult.mobile || rlt == ConnectivityResult.wifi) {
      setState(() {
        internetConnected = true;
      });
      // I am connected to a mobile network.
    } else {
      // I am connected to a wifi network.
      setState(() {
        internetConnected = false;
      });
    }
  }
  InAppWebViewController? controller;
  int _selectedIndex = 0;
  static const List<String> _widgetOptions = <String>[
    "https://www.mysong.co.il",
    "https://www.mysong.co.il/taklitia",
    "https://www.mysong.co.il/faq",
    "https://www.mysong.co.il/contact"
  ];

  List<Widget> screen = <Widget>[
    // Question(),

    Home(),
    Disk(),
    Phone(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      screen[index];
    });
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    if (!Platform.isIOS) {
      IsolateNameServer.registerPortWithName(
          _port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        String id = data[0];
        DownloadTaskStatus status = data[1];
        int progress = data[2];
        setState(() {
          this._selectedIndex = _selectedIndex;
        });
      });

      FlutterDownloader.registerCallback(downloadCallback);
    }
    if (!Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle().copyWith(
        statusBarColor: mainAppColor,
        //shows white text on status bar IOS
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        // systemStatusBarContrastEnforced:  true,
        systemNavigationBarColor: mainAppColor,
        // systemNavigationBarColor: Colors.pinkAccent,
      ));
    }

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setConnectivityState(result);
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!Platform.isIOS) {
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
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle().copyWith(
        statusBarColor: mainAppColor,
        //shows white text on status bar IOS
        statusBarBrightness: Brightness.light,
      ));
    }

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: showAppBar
                ? AppBar(
                    centerTitle: true,
                    title: Text(appBarTitle),
                    backgroundColor: mainAppColor,
                  )
                : const PreferredSize(
                    child: SafeArea(
                      child: SizedBox(),
                    ),
                    preferredSize: Size.zero,
                  ),
            bottomNavigationBar: Directionality(
              textDirection: TextDirection.rtl,
              child: BottomNavigationBar(
                  // backgroundColor: Colors.,
                  items: <BottomNavigationBarItem>[
                    // BottomNavigationBarItem(
                    //   icon: SvgPicture.asset('assets/icon/question.svg',color: _selectedIndex==1?Colors.red:Colors.white70,),
                    //   label: 'שאלות ותשובות',
                    //   backgroundColor: Colors.black87,
                    // ),

                    BottomNavigationBarItem(
                       icon: Icon(
                Icons.home_outlined,
                color: _selectedIndex == 0 ? Colors.red : Colors.grey,
                size: 30,
              ),
              // icon: SvgPicture.asset('assets/icon/phone.svg',color: _selectedIndex==2?Colors.red:Colors.grey,),
              label: 'בית',
                    ),
                    BottomNavigationBarItem(
                      // icon: Icon(Icons.music_video_outlined,color: _selectedIndex==0?Colors.red:Colors.grey,size: 30,),
                      icon:Icon(
                        Icons.music_note_outlined,
                        color: _selectedIndex == 1 ? Colors.red : Colors.grey,
                        size: 30,
                      ),
                      label: 'התקליטייה',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.mail_outline,
                        color: _selectedIndex == 2 ? Colors.red : Colors.grey,
                        size: 30,
                      ),
                      // icon: SvgPicture.asset('assets/icon/phone.svg',color: _selectedIndex==2?Colors.red:Colors.grey,),
                      label: 'יצירת קשר',
                    ),
                  ],
                  // type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  showUnselectedLabels: true,
                  selectedItemColor: Colors.red,
                  showSelectedLabels: true,
                  unselectedItemColor: Colors.grey,
                  selectedLabelStyle: const TextStyle(fontSize: 12),
                  iconSize: 40,
                  onTap: (index) {
                    setState(() {
                      _onItemTapped(index);
                      _selectedIndex = index;
                      // screen[index];
                    });
                  },
                  elevation: 5),
            ),
            body: (!internetConnected)
                ? OfflineScreen()
                : screen[_selectedIndex]));
  }
}
