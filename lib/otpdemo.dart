import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class otpdemo extends StatefulWidget {
  const otpdemo({Key? key}) : super(key: key);

  @override
  _otpdemoState createState() => _otpdemoState();
}

class _otpdemoState extends State<otpdemo> {
  TextEditingController tphone = TextEditingController();
  TextEditingController totp = TextEditingController();

  String mverificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: tphone,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    color: Colors.cyan,
                  ),
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "Enter Your Phone Number...",
                  fillColor: Colors.white70),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GFButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  timeout: const Duration(seconds: 60),
                  phoneNumber: '+91${tphone.text}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    mverificationId=verificationId;
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: Text('Enter your OTP'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: totp,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30),
                                ),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: mverificationId,
                                        smsCode: totp.text);
                                await auth.signInWithCredential(credential).then((value) {
                                  UserCredential userCredential = value;
                                    print(userCredential);
                                });

                              },
                              child: Text("Verify OTP"))
                        ],
                      );
                    });
              },
              text: "Generate OTP",
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
