import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:manipal_locals/food_menu_screen.dart';

import 'HomePage.dart';

void main() {
  runApp((SplashScreen()));
}

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreenImage(),
      ),
    );
  }
}

class SplashScreenImage extends StatelessWidget {
  Future<void> delay(BuildContext context) async {
    if(FirebaseAuth.instance.currentUser() != null)
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => FoodMenuScreen()));
  }

  @override
  Widget build(BuildContext context) {
    delay(context);

    return SizedBox.expand(
      child: Container(
        color: Colors.black,
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
