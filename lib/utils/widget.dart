import 'package:flutter/material.dart';

Widget background(double height, double width) {
  return Image.asset(
    "assets/images/ML_doodles.png",
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}

class Convert {
  static String convertString(String str) {
    String str1 =
        'https://firebasestorage.googleapis.com/v0/b/manipallocals-2f95e.appspot.com/o/';
    String str2;
    String str3 = '?alt=media';

    if (str.startsWith('gs') == true) {
      str2 = str.substring(37);
      str = str1 + str2 + str3;
    }

    return str;
  }
}
