import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_inappwebview_main_view.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:
      FlutterInappWebviewMainView(Uri.parse("https://www.mysong.co.il/faq")),
    ));
  }
}
