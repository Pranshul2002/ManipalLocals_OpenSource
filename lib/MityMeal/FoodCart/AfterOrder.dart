import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/MityMeal/food_menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils.dart';
import 'calc_brain.dart';
import 'constants.dart';
import 'lists.dart';

class AfterOrder extends StatefulWidget {
  String orderId;
  AfterOrder({this.orderId});
  @override
  _AfterOrderState createState() => _AfterOrderState();
}

class _AfterOrderState extends State<AfterOrder> {
  SharedPreferences prefs;
  CalcBrain calcBrainObj = CalcBrain();

  double itemTotal;

  double cartTotal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // MyLists.getItems();
    prefs = SharedPreferenceClass.sharedPreferences;
  }

  LockthePage(AsyncSnapshot<DocumentSnapshot> ds) {
    String data = ds.data[widget.orderId];
    if (data == "rejected") {
      Fluttertoast.showToast(
          msg:
              "Error: Your order was rejected by the restaurant. Please try again.",
          toastLength: Toast.LENGTH_LONG);
      prefs.setBool("after", false);
      prefs.setString("orderId", null);

      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context)
            .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
      });
    }
    if (data == "3") {
      prefs.setBool("after", false);
      prefs.setString("orderId", null);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => FoodMenuScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 36 - 48 * 3;
    return WillPopScope(
      onWillPop: () async => false,
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .document("status")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(
                  msg: "Error: ${snapshot.error}",
                  toastLength: Toast.LENGTH_SHORT);
              return Container();
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ));
              default:
                LockthePage(snapshot);
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        border: Border.all(color: Colors.grey)),
                                  ),
                                  if (snapshot.data[widget.orderId] == "1" ||
                                      snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3")
                                    Container(
                                      height: 8,
                                      width: width / 3,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  if (snapshot.data[widget.orderId] == "1" ||
                                      snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3")
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                  if (!(snapshot.data[widget.orderId] == "1" ||
                                      snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3"))
                                    Container(
                                      height: 8,
                                      width: width / 3,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  if (!(snapshot.data[widget.orderId] == "1" ||
                                      snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3"))
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                  if (snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3")
                                    Container(
                                      height: 8,
                                      width: width / 3,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  if (snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3")
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                  if (!(snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3"))
                                    Container(
                                      height: 8,
                                      width: width / 3,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  if (!(snapshot.data[widget.orderId] == "2" ||
                                      snapshot.data[widget.orderId] == "3"))
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                  if (snapshot.data[widget.orderId] == "3")
                                    Container(
                                      height: 8,
                                      width: width / 3,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  if ((snapshot.data[widget.orderId] == "3"))
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                  if (!(snapshot.data[widget.orderId] == "3"))
                                    Container(
                                      height: 8,
                                      width: width / 3,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  if (!(snapshot.data[widget.orderId] == "3"))
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        " Order \nPlaced",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: width / 6 + 16),
                                      child: Text(
                                        "Confirmed",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: width / 6 + 16),
                                      child: Text(
                                        "On the\n  way",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: width / 6 + 16),
                                      child: Text(
                                        "Delivered",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: kDividerLineThin,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 3.0),
                            itemCount: MyLists.itemName.length,
                            itemBuilder: (context, int i) {
                              if (MyLists.qty[i] > 0)
                                return Container(
                                  height: 80.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 32.0),
                                              child: Text(
                                                MyLists.itemName[i],
                                                style: kItemTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                                // softWrap: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Text(
                                                "x    " +
                                                    MyLists.qty[i].toString(),
                                                style: kTextStyle,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Text(
                                                  '\u20B9  ${(MyLists.price[i] * MyLists.qty[i]).toString()}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0,
                                                      fontFamily: 'Cabin')),
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
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // Expanded(
                            //   flex: 2,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       setState(() {});
                            //     },
                            //     child: Container(
                            //       margin: EdgeInsets.only(top: 10.0),
                            //       padding: EdgeInsets.all(8.0),
                            //       height: 30.0,
                            //       width: MediaQuery.of(context).size.width * 0.8,
                            //       decoration: BoxDecoration(
                            //         color: Color(0xFFFFEFC6),
                            //         borderRadius: BorderRadius.circular(20.0),
                            //       ),
                            //       child: Center(
                            //         child: Text(
                            //           '%   APPLY COUPONS ',
                            //           style: TextStyle(
                            //             fontFamily: 'Cabin',
                            //             fontSize: 20.0,
                            //             fontWeight: FontWeight.bold,
                            //             color: Colors.black,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                                height: 20.0,
                                width: 250.0,
                                child: kDividerLine),
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
                                      child: Text(
                                          '\u20B9 ${MyLists.deliveryCharges}',
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
                                  Text('Cart Total',
                                      style: kCartTotalTextStyle),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                );
            }
          }),
    );
  }
}
