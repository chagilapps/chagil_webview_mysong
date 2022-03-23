import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/links_navigation.dart';

class DevPrint extends StatelessWidget {
  DevPrint({Key? key}) : super(key: key);

  static createLog(String log){
    print(log);
    logs.add(
    Card(
      color: Colors.white,child: Column(
        children: [
        Text(DateTime.now().toString()),
      Text(log,style: TextStyle(fontSize: 15),),

    ]),
    ),
    );
  }

  static List<Card> logs =[];




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton(onPressed: (){
              LinksNavigation.launchURL(Uri.parse("tel:57836389"));
            }, child: Text("app launcher")),
            TextButton(onPressed: () async {

            await launch("tel:57836389",forceSafariVC: false,universalLinksOnly:true,forceWebView: false,).then((value) =>  DevPrint.createLog("started ...")).whenComplete(() =>  DevPrint.createLog("compleated ")) .onError((error, stackTrace) =>  DevPrint.createLog("error... $error"));;

            }, child: Text("original launcher"))
          ],
        ),
        Container(
          height: 70,
          child: Card(

            color: Colors.blueGrey,
            child: Column(
              children: [
                Text(DateTime.now().toString()),
                Text("Showing Logs",style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            reverse: true,
            children:
            logs
            // [Container()]
            ,),
        ),
      ],
    );
  }
}
