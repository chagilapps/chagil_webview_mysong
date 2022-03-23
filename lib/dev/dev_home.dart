import 'package:audio_webview/application/links_navigation.dart';
import 'package:audio_webview/home_page.dart';
import 'package:flutter/material.dart';

import 'dev_prints.dart';

class DevHome extends StatefulWidget {
  const DevHome({Key? key}) : super(key: key);

  @override
  State<DevHome> createState() => _DevHomeState();
}

class _DevHomeState extends State<DevHome> {
  int index = 0;

  List displayView = [
    HomePage(),
    DevPrint(),

  ];



  @override
  Widget build(BuildContext context) {
    return

      MaterialApp(
        home: Scaffold(
          body:
          // Column(
          //   children: [
          //     Expanded(flex:70,child: displayView[0]),
          //     Expanded(flex:30,child: displayView[1]),
          //   ],
          // ),
          SafeArea(child:
          displayView[index],),
          
          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){
          //     LinksNavigation.launchURL(Uri.parse("tel://57836389"));
          //   },
          // ),

          bottomNavigationBar: BottomNavigationBar(
            onTap: (currentIndex){
              print (currentIndex);
              setState(() {
                index = currentIndex;
              });
            },

            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.developer_board),label: "dev"),
          ],)
        ),
      );

  }
}
