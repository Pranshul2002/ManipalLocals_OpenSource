import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/MityMeal/MenuPage.dart';
import 'package:manipal_locals/MityMeal/TeddyController.dart';
import 'package:manipal_locals/MityMeal/food_menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils.dart';

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
  Future<void> start(
      bool signup, List<dynamic> users, UserInfoP userInfo) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 90),
        verificationCompleted: (AuthCredential Auth) async {
          await auth.signInWithCredential(Auth).then((value) async {
            if (value.user != null) {
              tc.success();
              if (signup) {
                users.add(phone);
                await Firestore.instance
                    .collection("users")
                    .document("7JOEExxZ3goV9mKPwcUO")
                    .updateData(
                        {"user_number": users, "$phone": userInfo.getMap()});
              }
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool("signup", false);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => FoodMenuScreen()));
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
          print("codesent");
          this.verId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verid) {});
  }

  Future<void> verify(
      String code, bool signup, List<dynamic> users, UserInfoP userInfo) async {
    AuthCredential phoneAuthProvider =
        PhoneAuthProvider.getCredential(verificationId: verId, smsCode: code);

    try {
      AuthResult ar = await auth.signInWithCredential(phoneAuthProvider);
      print(ar.user);
      if (ar.user != null) {
        tc.success();
        if (signup) {
          users.add(phone);
          await Firestore.instance
              .collection("users")
              .document("7JOEExxZ3goV9mKPwcUO")
              .updateData({"user_number": users, "$phone": userInfo.getMap()});
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("signup", false);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => FoodMenuScreen()));
      } else {
        tc.fail();
      }
    } catch (PlatformException) {
      tc.fail();
    }
  }
}
