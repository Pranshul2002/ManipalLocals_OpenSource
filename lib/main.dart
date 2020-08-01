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
      theme: ThemeData(fontFamily: "bangla mn"),
      home: Scaffold(
        body: SplashScreenImage(),
      ),
    );
  }
}

class SplashScreenImage extends StatelessWidget {
  Future<void> delay(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    delay(context);
    return SizedBox.expand(
      child: Container(
        color: Color.fromRGBO(255, 150, 9, 1.0),
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
