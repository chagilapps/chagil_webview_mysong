import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/icon/icon.png",width: MediaQuery.of(context).size.width *.8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('אופס, כנראה שאין אצלך חיבור לאינטרנט כרגע..\n יש לנסות שוב.\n\n תוכן האפליקציה יוצג מיד עם חידוש הקליטה במכשירך :)',
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.center,textDirection: TextDirection.rtl,),
            ),
          ],
        ),
      ),
    );
  }
}
