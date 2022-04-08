import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_inappwebview_main_view.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body:
      FlutterInappWebviewMainView(Uri.parse("https://www.mysong.co.il/contact")),
    ));
  }
}
