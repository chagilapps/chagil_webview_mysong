
import 'dart:io';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../app_config.dart';

class OneSignalClass {

  void initializeOneSignal () async {
    if(Platform.isAndroid){
      await OneSignal.shared.setAppId(oneSignalAndroid);
    }

    if(Platform.isIOS){
      await OneSignal.shared.setAppId(oneSignalIOS);
    }
    // await OneSignal.shared.setAppId("4e89ebde-4787-40b3-8301-15f978d6ff43"); //Android


// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }


}

