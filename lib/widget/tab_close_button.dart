import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_config.dart';

class TabCloseButton extends StatelessWidget {
  Function? onTap;
  var textColor,iconColor;
  double iconSize,textSize;
   TabCloseButton({Key? key,
     this.onTap, this.iconColor = Colors.white,this.textColor=Colors.white,this.iconSize = 25.0,this.textSize = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        // color: Colors.redAccent,
        child: InkWell(
          onTap: (){
            print("onTap tapped");
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle().copyWith(
                    statusBarColor: mainAppColor,
                    //shows white text on status bar IOS
                    statusBarBrightness: Brightness.light,
                  ));
            }
            onTap;
          },
          child: Row(

            children: [
              Icon(Icons.close,size: iconSize,color: iconColor,),
              Text("סגור עמוד", style: TextStyle(fontSize: textSize,color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
