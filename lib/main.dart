import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'HomePage.dart';

void main() {
  runApp((SplashScreen()));
}

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(
        body: SplashScreenImage(),
      ),
    );
  }
}

class SplashScreenImage extends StatelessWidget {
  Future<void> delay(BuildContext context) async {
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    delay(context);

    return SizedBox.expand(
      child: Container(
        color: Color(0xffFF9609),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                  width: MediaQuery.of(context).size.width - 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
