import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GFImageOverlay(
              height: 200,
              width: 200,
              shape: BoxShape.circle,
              image:AssetImage('images/1.png'),
              boxFit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: temail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                  hintText: 'Enter valid mail id as abc@gmail.com'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tpassword,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GFButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: temail.text,
                      password: tpassword.text
                  );
                  print(userCredential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    Fluttertoast.showToast(
                        msg: "The password provided is too weak.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    Fluttertoast.showToast(
                        msg: "The account already exists for that email.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              text: "Register",
              size: 50,
              shape: GFButtonShape.square,
              blockButton: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GFButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: temail.text,
                      password: tpassword.text
                  );
                  print(userCredential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                    Fluttertoast.showToast(
                        msg: "No user found for that email.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    Fluttertoast.showToast(
                        msg: "Wrong password provided for that user.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                }
              },
              text: "Login",
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
