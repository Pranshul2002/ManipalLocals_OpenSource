import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:manipal_locals/MityMeal/HomePage.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'MityMeal/LoginCode.dart';

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePageMM(),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 1.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      });
}

Route _createRoute1() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SplashScreenImage(),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 1.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      });
}

void main() {
  runApp(SplashScreen());
}

class BeforeMain extends StatefulWidget {
  @override
  _BeforeMainState createState() => _BeforeMainState();
}

class _BeforeMainState extends State<BeforeMain> {
  SharedPreferences prefs;

  var selected;
  @override
  Future<dynamic> getSelection() async {
    prefs = await SharedPreferenceClass.getInstance();
    selected =
        prefs.getBool("selected") != null ? prefs.getBool("selected") : null;
    return selected;
  }

  void initState() {
    super.initState();
    getSelection().then((value) {
      if (value != null) {
        if (value) {
          Navigator.of(context).pushReplacement(_createRoute1());
        } else {
          Navigator.of(context).push(_createRoute());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.5;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(top: 32, bottom: 32),
            child: CircleAvatar(
              radius: 100,
              child: GestureDetector(
                onTap: () {
                  prefs.setBool("selected", true);
                  Navigator.of(context).pushReplacement(_createRoute1());
                },
                child: Image.asset(
                  "assets/images/ML.png",
                  fit: BoxFit.contain,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            height: MediaQuery.of(context).size.height / 2,
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 32, bottom: 32),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  prefs.setBool("selected", false);
                  Navigator.of(context).push(_createRoute());
                },
                child: Image.asset(
                  "assets/images/mitymeal.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height / 2,
          )
        ],
      ),
    );
  }
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
        body: BeforeMain(),
      ),
    );
  }
}

class SplashScreenImage extends StatelessWidget {
  Future<void> delay(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser() != null)
      await FirebaseAuth.instance.signInAnonymously();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
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
