import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// Import the generated file
import '../../firebase_options.dart';
class FirebaseClass {


// Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
        //   options: FirebaseOptions(
        //       // apiKey: apiKey,
        //       // appId: appId,
        //       // messagingSenderId: messagingSenderId,
        //       // projectId: projectId)
      );

      _initialized = true;
      if (kDebugMode) {
        print("_initialized = $_initialized ,_error = $_error ");
      }
      if (kDebugMode) {
        print(Firebase
          .app()
          .name);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // Set `_error` state to true if Firebase initialization fails
      _error = true;
    }
    if (kDebugMode) {
      print("_initialized = $_initialized ,_error = $_error ");
    }
  }
}

