import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/MityMeal/FoodCart/AfterOrder.dart';
import 'package:manipal_locals/MityMeal/Utils.dart';
import 'package:manipal_locals/MityMeal/food_menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'calc_brain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'lists.dart';

class FoodCartData extends StatefulWidget {
  @override
  _FoodCartDataState createState() => _FoodCartDataState();
}

class _FoodCartDataState extends State<FoodCartData> {
  CalcBrain calcBrainObj = CalcBrain();
  double cartTotal;
  String orderId;
  double itemTotal;
  SharedPreferences prefs;
  bool isOpen = true;
  @override
  void initState() {
    MyLists.getItems();

    super.initState();
    prefs = SharedPreferenceClass.sharedPreferences;
  }

  @override
  Widget build(BuildContext context) {
    MyLists.getItems();

    if (isOpen == MenuState.ds.data["closed"]) {
      setState(() {
        isOpen = !MenuState.ds.data["closed"];
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Color(0xFFFFC800),
          centerTitle: true,
          title: Text('Order Summary',
              style: TextStyle(
                color: Color(0xFF515151),
                fontFamily: 'Cabin',
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
              ))),
      body: isOpen
          ? Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 3.0),
                    itemCount: MyLists.itemName.length,
                    itemBuilder: (context, int i) {
                      // if (MyLists.qty.length < MyLists.itemName.length) {
                      //   MyLists.qty.add(1);
                      // }
                      if (MyLists.qty[i] > 0)
                        return Container(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width * 0.1,
                          margin: EdgeInsets.all(3.0),
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        MyLists.itemName[i],
                                        style: kItemTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        // softWrap: true,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RawMaterialButton(
                                          child: Icon(
                                            FontAwesomeIcons.minus,
                                            color: Color(0xFFFFC800),
                                            size: 15.0,
                                          ),
                                          constraints: BoxConstraints.tightFor(
                                              height: 25.0, width: 25.0),
                                          shape: CircleBorder(),
                                          fillColor: Color(0xFFFFEFC6),
                                          onPressed: () {
                                            setState(() {
                                              if (MyLists.qty[i] > 1) {
                                                MyLists.qty[i]--;
                                                prefs.setStringList(
                                                    "count",
                                                    MyLists.qty
                                                        .map((el) =>
                                                            el.toString())
                                                        .toList());
                                              }
                                            });
                                          },
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              MyLists.qty[i].toString(),
                                              style: kTextStyle,
                                            )),
                                        RawMaterialButton(
                                          child: Icon(
                                            FontAwesomeIcons.plus,
                                            color: Color(0xFFFFC800),
                                            size: 15.0,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              MyLists.qty[i]++;
                                              prefs.setStringList(
                                                  "count",
                                                  MyLists.qty
                                                      .map(
                                                          (el) => el.toString())
                                                      .toList());
                                            });
                                          },
                                          constraints: BoxConstraints.tightFor(
                                              height: 25.0, width: 25.0),
                                          shape: CircleBorder(),
                                          fillColor: Color(0xFFFFEFC6),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        '\u20B9  ${(MyLists.price[i] * MyLists.qty[i]).toString()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontFamily: 'Cabin')),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            MyLists.qty[i] = 0;

                                            MyLists.itemName.removeAt(i);
                                            MyLists.price.removeAt(i);
                                            prefs.setStringList(
                                                "count",
                                                MyLists.qty
                                                    .map((el) => el.toString())
                                                    .toList());

                                            prefs.setStringList(
                                                "listItems", MyLists.itemId);
                                          });
                                        },
                                        icon: Icon(FontAwesomeIcons.trash),
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        color: Color(0xFFFFC800),
                                        iconSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      else
                        return SizedBox.shrink();
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(msg: "No coupons available");
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0),
                            padding: EdgeInsets.all(8.0),
                            height: 30.0,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFEFC6),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                '%   APPLY COUPONS ',
                                style: TextStyle(
                                  fontFamily: 'Cabin',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0, width: 250.0, child: kDividerLine),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Item Total', style: kTextStyle),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    '\u20B9 ${itemTotal = calcBrainObj.totalPerItem()}',
                                    style: kTextStyle),
                              ),
                            ),
                          ],
                        ),
                      ),
                      kDividerLineThin,
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Delivery and Packaging Charges',
                                style: kTextStyle),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text('\u20B9 ${MyLists.deliveryCharges}',
                                    style: kTextStyle),
                              ),
                            ),
                          ],
                        ),
                      ),
                      kDividerLineThin,
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Cart Total', style: kCartTotalTextStyle),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    '\u20B9 ${cartTotal = calcBrainObj.entireCartTotal()}',
                                    style: kCartTotalTextStyle),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () async {
                            int sum = 0;
                            MyLists.qty.forEach((num e) {
                              sum += e;
                            });
                            await Firestore.instance
                                .collection("food_menu")
                                .document("1bF1qLEpWuhKj9n7Af8P")
                                .get()
                                .then((value) {
                              setState(() {
                                isOpen = !value.data["closed"];
                              });
                            });
                            if (sum != 0 && isOpen) {
                              Map order = Map();
                              MyLists.itemName.forEach((element) {
                                var dex = MyLists.itemName.indexOf(element);
                                order.addAll({element: MyLists.qty[dex]});
                              });
                              FirebaseAuth.instance.currentUser().then((value) {
                                order
                                    .addAll({"phoneNumber": value.phoneNumber});
                              });
                              await Firestore.instance
                                  .collection("orders")
                                  .document("h5i5dYLy8BC33umrteH4")
                                  .get()
                                  .then((ds) async {
                                Random random = new Random();
                                int randomNumber = random.nextInt(1000000);
                                setState(() {
                                  orderId = "order" +
                                      ds.data["count"].toString() +
                                      randomNumber.toString();
                                });

                                List<dynamic> list12 = ds.data["orderId"];
                                list12.add(orderId);

                                var count = ds.data["count"] + 1;
                                await Firestore.instance
                                    .collection("orders")
                                    .document("h5i5dYLy8BC33umrteH4")
                                    .updateData({
                                  "orderId": list12,
                                  "count": count,
                                  orderId: order
                                });
                                await Firestore.instance
                                    .collection("orders")
                                    .document("status")
                                    .updateData({orderId: "0"});
                              });
                              prefs.setBool("after", true);
                              prefs.setString("orderId", orderId);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AfterOrder(
                                            orderId: orderId,
                                          )));
                            } else if (!isOpen) {
                              Fluttertoast.showToast(
                                  msg: "Error: Restaurant closed");
                              Navigator.of(context).pop();
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Error: Cart is empty.\nPlease add some items.");
                            }
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'PLACE ORDER',
                                style: kCartTotalTextStyle,
                              ),
                            ),
                            color: Color(0xFFFFC800),
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.only(top: 15.0),
                            width: double.infinity,
                            height: 70.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                "The Indian Kitchen is closed.",
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}

// Color(0xFF515151),
//that's hex for dark grey
