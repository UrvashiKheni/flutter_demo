import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signinwithgoogle extends StatefulWidget {
  const signinwithgoogle({Key? key}) : super(key: key);

  @override
  _signinwithgoogleState createState() => _signinwithgoogleState();
}

class _signinwithgoogleState extends State<signinwithgoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: GFButton(
                onPressed: () async {
                  signInWithGoogle().then((value) {
                    print(value);
                  });
                },
                icon: Icon(Icons.email),
                text: "Login with Google",
                size: 50,
                shape: GFButtonShape.square,
                blockButton: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GFButton(
                onPressed: () async {
                  await GoogleSignIn().signOut();
                  print(" you are log out");
                },
                icon: Icon(Icons.logout_sharp),
                text: "Logout",
                size: 50,
                shape: GFButtonShape.square,
                blockButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
