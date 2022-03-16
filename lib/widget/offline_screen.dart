import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icon/icon.png"),
          Text('אין חיבור לאינטרנט, תוכן האפליקציה יעלה מייד עם חידוש החיבור לאינטרנט',
          style: TextStyle(),
          textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
