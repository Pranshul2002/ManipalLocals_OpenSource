import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  static SharedPreferences sharedPreferences;
  static Future<SharedPreferences> getInstance() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    return sharedPreferences;
  }
}

class UserInfoP {
  String name;
  int regno;
  int hostel;
  String roomno;
  int phonenumber;

  Map<String, dynamic> map;
  UserInfoP(this.name, this.regno, this.hostel, this.roomno, this.phonenumber);
  Map<String, dynamic> getMap() {
    map = {
      "Name": this.name,
      "Registration Number": this.regno,
      "Hostel": this.hostel,
      "Room Number": this.roomno,
      "Phone Number": this.phonenumber
    };
    return map;
  }
}

class FoodItem {
  String name;
  String cuisine;
  int price;
  String id;
  String image_url;
  FoodItem(
      this.id, this.name, this.cuisine, this.price, this.isVeg, this.image_url);

  bool isVeg;
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
