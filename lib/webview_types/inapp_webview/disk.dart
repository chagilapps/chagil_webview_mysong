import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_inappwebview_main_view.dart';

class Disk extends StatefulWidget {
  const Disk({Key? key}) : super(key: key);

  @override
  State<Disk> createState() => _DiskState();
}

class _DiskState extends State<Disk> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body:
      FlutterInappWebviewMainView(Uri.parse("https://www.mysong.co.il/taklitia")),
    ));
  }
}
