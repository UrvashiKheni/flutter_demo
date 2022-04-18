import 'package:circular_menu/circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/contactbook/insertdata.dart';
import 'package:flutter_demo/contactbook/viewdata.dart';
import 'package:flutter_demo/login.dart';
import 'package:flutter_demo/otpdemo.dart';
import 'package:flutter_demo/signinwithgoogle.dart';
import 'package:flutter_demo/streambuilder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: myapp() ,
  ));
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animated Circular Menu Sample"),
      ),
      body: CircularMenu(
        alignment: Alignment.center,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceInOut,
        toggleButtonColor: Colors.blueAccent,
        items: [
          CircularMenuItem(
              icon: Icons.person,
              color: Colors.greenAccent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return login();
                },));

              }),
          CircularMenuItem(
              icon: Icons.verified_user,
              color: Colors.redAccent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return otpdemo();
                },));
              }),
          CircularMenuItem(
              icon: Icons.email,
              color: Colors.yellowAccent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return signinwithgoogle();
                },));

              }),
          CircularMenuItem(
              icon: Icons.stream,
              color: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return streambuilder();
                },));

              }),
          CircularMenuItem(
              icon: Icons.contacts_rounded,
              color: Colors.teal,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return viewdata();
                },));

              }),
        ],
      ),
    );
  }
}