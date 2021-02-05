import 'package:shared_preferences/shared_preferences.dart';
import '../food_menu_screen.dart';
import '../Utils.dart';

class MyLists {
  static List<String> itemId = [];
  static SharedPreferences prefs;
  static List<String> itemName = [];
  static List<int> price = [];
  static List<int> qty = [];
  static double deliveryCharges = 0.0;
  static List<int> Qty = [];
  static getItems() {
    itemId = [];
    itemName = [];
    price = [];
    qty = [];
    Qty = [];
    prefs = SharedPreferenceClass.sharedPreferences;
    List<String> list = prefs.getStringList("listItems") != null
        ? prefs.getStringList("listItems")
        : [];
    itemId = list;
    if (list.length != 0)
      qty = prefs.getStringList("count").map(int.parse).toList();
    if (MenuState.foodItemList.length != 0)
      for (String a in list) {
        var name = MenuState
            .foodItemList[MenuState.foodItemList.indexWhere((element) {
          if (element.id == a) {
            return true;
          } else {
            return false;
          }
        })]
            .name;
        if (!itemName.contains(name)) {
          itemName.add(name);
          price.add(MenuState
              .foodItemList[MenuState.foodItemList.indexWhere((element) {
            if (element.id == a) {
              return true;
            } else {
              return false;
            }
          })]
              .price);
        }
      }
  }
}
