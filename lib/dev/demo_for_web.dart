import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_config.dart';
import '../widget/offline_screen.dart';

class DemoForWeb extends StatefulWidget {
  const DemoForWeb({Key? key}) : super(key: key);

  @override
  _DemoForWebState createState() => _DemoForWebState();
}

class _DemoForWebState extends State<DemoForWeb> {
  int _selectedIndex = 0;
  static const List<String> _widgetOptions = <String>[
    "https://www.mysong.co.il",
    "https://www.mysong.co.il/taklitia",
    "https://www.mysong.co.il/faq",
    "https://www.mysong.co.il/contact"
  ];

  List<Widget> screen = <Widget>[
    // Question(),

    OfflineScreen(),
    OfflineScreen(),
    OfflineScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      screen[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: showAppBar
              ? AppBar(
            centerTitle: true,
            title: Text(appBarTitle),
            backgroundColor: mainAppColor,
          )
              : const PreferredSize(
            child: SafeArea(
              child: SizedBox(),
            ),
            preferredSize: Size.zero,
          ),
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: BottomNavigationBar(
              // backgroundColor: Colors.,
                items: <BottomNavigationBarItem>[
                  // BottomNavigationBarItem(
                  //   icon: SvgPicture.asset('assets/icon/question.svg',color: _selectedIndex==1?Colors.red:Colors.white70,),
                  //   label: 'שאלות ותשובות',
                  //   backgroundColor: Colors.black87,
                  // ),

                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icon/home.svg',
                      color: _selectedIndex == 0 ? Colors.red : Colors.grey,
                      height: 30,
                    ),
                    // icon: Icon(Icons.home_outlined,color: _selectedIndex==0?Colors.red:Colors.grey,size: 30,),
                    label: 'בית',
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.music_video_outlined,color: _selectedIndex==0?Colors.red:Colors.grey,size: 30,),
                    icon: SvgPicture.asset('assets/icon/disk.svg',
                        color: _selectedIndex == 1 ? Colors.red : Colors.grey,
                        height: 30),
                    label: 'התקליטייה',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.mail_outline,
                      color: _selectedIndex == 2 ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                    // icon: SvgPicture.asset('assets/icon/phone.svg',color: _selectedIndex==2?Colors.red:Colors.grey,),
                    label: 'יצירת קשר',
                  ),
                ],
                // type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                showUnselectedLabels: true,
                selectedItemColor: Colors.red,
                showSelectedLabels: true,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: const TextStyle(fontSize: 12),
                iconSize: 40,
                onTap: (index) {
                  setState(() {
                    _onItemTapped(index);
                    _selectedIndex = index;
                    // screen[index];
                  });
                },
                elevation: 5),
          ),
          body:  screen[_selectedIndex]),
    );
  }
}

class _selectedIndex {
}
