

import 'package:audio_webview/dev/dev_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rxdart/rxdart.dart';

import 'api/firebase_class.dart';
import 'api/one_signal_class.dart';
import 'app_config.dart';
import 'application/audio_handler.dart';
import 'home_page.dart';

// late AudioHandler _audioHandler;
const debug = true;

Future<void> main() async {
  // if(audioBackground){
  //   _audioHandler = await AudioService.init(
  //     builder: () => MyAudioHandler(),
  //     config: AudioServiceConfig(
  //       androidNotificationChannelId: 'com.mycompany.myapp.channel.audio',
  //       androidNotificationChannelName: 'Music playback',
  //     ),
  //   );
  // }

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FirebaseClass().initializeFlutterFire();
  OneSignalClass().initializeOneSignal();
  await FlutterDownloader.initialize(debug: debug);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
print('hahahaha');
  // return MaterialApp(home: DownloaderView(platform: TargetPlatform.android,title: "Download Files",));
  return const DevHome();
  // return const HomePage();
  }
}
