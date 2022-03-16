import 'package:flutter/material.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/loading.png"),
    );
  }
}

// (progress != 1)?
// Expanded(
// child: Container(
// color: Colors.white,
//
// child: Center(
// child: Container(
// decoration:
// BoxDecoration(
// color: Colors.white,
// image:DecorationImage(
// colorFilter: ColorFilter.mode(Colors.black.withOpacity(1-progress), BlendMode.dstATop),  image: AssetImage("assets/loading.png",),
// ),
// )),
// ),
// ),
// )
// // Image.asset("assets/loading.png"),)
// :SizedBox(height: 0,width: 0,),