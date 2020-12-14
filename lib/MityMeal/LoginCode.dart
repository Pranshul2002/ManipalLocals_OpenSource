import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/MityMeal/MenuPage.dart';
import 'package:manipal_locals/MityMeal/TeddyController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  String phone = "+91";
  String verId;
  FirebaseAuth auth = FirebaseAuth.instance;
  TeddyController tc;
  BuildContext context;
  Login(String phone, TeddyController tc, BuildContext context) {
    this.phone += phone;
    print(phone);
    this.tc = tc;
    this.context = context;
  }
  Future<void> start() async {
    await auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 90),
        verificationCompleted: (AuthCredential Auth) async {
          await auth.signInWithCredential(Auth).then((value) {
            if (value.user != null) {
              tc.success();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Menu()));
            }
          });
        },
        verificationFailed: (AuthException exc) {
          print("Error " + exc.message);
          tc.fail();
          Fluttertoast.showToast(
              msg: "Error: ${exc.message}",
              backgroundColor: Colors.grey,
              toastLength: Toast.LENGTH_SHORT,
              textColor: Colors.white);
        },
        codeSent: (String verificationId, [int resendCode]) {
          this.verId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verid) {});
  }

  Future<void> verify(String code) async {
    AuthCredential phoneAuthProvider =
        PhoneAuthProvider.getCredential(verificationId: verId, smsCode: code);

    try {
      AuthResult ar = await auth.signInWithCredential(phoneAuthProvider);
      print(ar.user);
      if (ar.user != null) {
        tc.success();
        print("Success");
        Navigator.push(context, MaterialPageRoute(builder: (_) => Menu()));
      } else {
        tc.fail();
      }
    } catch (PlatformException) {
      tc.fail();
    }
  }
}

class SharedPreferenceClass {
  static SharedPreferences sharedPreferences;
  static Future<SharedPreferences> getInstance() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    return sharedPreferences;
  }
}
