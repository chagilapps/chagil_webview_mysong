//
// import 'package:flutter/material.dart';
//
//
// class FlutterWebviewPluginWidget extends StatefulWidget {
//   String? url;
//
//   FlutterWebviewPluginWidget({Key? key, this.url}) : super(key: key);
//
//
//   @override
//   _FlutterWebviewPluginWidgetState createState() => _FlutterWebviewPluginWidgetState();
// }
//
// class _FlutterWebviewPluginWidgetState extends State<FlutterWebviewPluginWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       url: (widget.url != null)?widget.url!:appUri.host,
//       withJavascript: true,
//       allowFileURLs: true,
//       supportMultipleWindows: false,
//       // bottomNavigationBar: Icon(Icons.attractions),
//       // initialChild: Center(heightFactor: 150,),
//         // resizeToAvoidBottomInset:true,
//     );
//   }
// }