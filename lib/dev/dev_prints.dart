import 'package:flutter/material.dart';

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

  static List<Card> logs =[


  ];




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            children: logs,),
        ),
      ],
    );
  }
}
