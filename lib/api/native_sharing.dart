import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class NativeSharing {


  void share ({required String title, required String url}){
    FlutterShare.share(
        title: title,
        linkUrl: url,
    );
  }

  Widget shareButton ({  String? url}){
    var title = "My Song link";
    String _url;
    if(url != null){
      _url =url;
    }else{
      _url = "";
    }
    return IconButton(
        onPressed:()=> share(title: title,url: url!),
        icon: FaIcon(FontAwesomeIcons.solidShareSquare,size: 17),

    );
  }

}