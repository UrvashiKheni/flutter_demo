import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class streambuilder extends StatefulWidget {
  const streambuilder({Key? key}) : super(key: key);

  @override
  _streambuilderState createState() => _streambuilderState();
}

class _streambuilderState extends State<streambuilder> {


  Stream<String> gettime() async*
  {
    while(true)
      {
        await Future.delayed(Duration(seconds: 1));
        DateTime d =  DateTime.now();

        String time = "${d.hour} : ${d.minute} : ${d.second}";

        yield time;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: gettime(),
        builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(
              child: GFLoader(type: GFLoaderType.circle),
            );
          }
        if(snapshot.hasData)
          {
                return Center(
                  child: Text(snapshot.data.toString(),style: TextStyle(fontSize: 22),),
                );
          }
        else{
          return Center(child: Text("No Data found",style: TextStyle(fontSize: 22),));
        }
      },),
    );
  }
}
