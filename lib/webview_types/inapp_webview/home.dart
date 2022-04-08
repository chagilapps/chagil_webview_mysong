import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_inappwebview_main_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FlutterInappWebviewMainView(Uri.parse("https://www.mysong.co.il"))
    ));
  }
}
