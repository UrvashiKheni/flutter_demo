import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/contactbook/viewdata.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';

class insertdata extends StatefulWidget {
  const insertdata({Key? key}) : super(key: key);

  @override
  _insertdataState createState() => _insertdataState();
}

class _insertdataState extends State<insertdata> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  String path = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fill the details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tname,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  suffixIcon: Icon(CupertinoIcons.pencil),
                  border: OutlineInputBorder(),
                  labelText: 'name',
                  hintText: 'Enter your name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tcontact,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: 'contact',
                  hintText: 'Enter your contact'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GFButton(
              onPressed: () {
                String name = tname.text;
                String contact = tcontact.text;

                DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook").push();

                String? userid = ref.key;
                Map m = {"userid" : userid , "name" : name , "contact" : contact};
                ref.set(m);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return viewdata();
                },));
              },
              text: "submit",
              size: 50,
              shape: GFButtonShape.square,
              blockButton: true,
            ),
          ),
        ],
      ),
    );
  }
}
