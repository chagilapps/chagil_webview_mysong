import 'package:flutter/material.dart';

class WebviewProgressBar extends StatelessWidget {
  double progress;
  WebviewProgressBar({Key? key,required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: progress < 1.0
            ? LinearProgressIndicator(
          minHeight:2.0 ,
          value: progress,
          color: Color(0xffCC3B38),
          backgroundColor: Color(0xffCC3B38).withOpacity(0.5),
        )
            : Container()

      //RED = CC3B38 , GOLD = EBC68C
    );
  }
}
