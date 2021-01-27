import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/MityMeal/FoodCart/food_cart.dart';
import 'package:manipal_locals/MityMeal/UpdateProfile.dart';
import 'package:manipal_locals/MityMeal/Utils.dart';
import 'package:manipal_locals/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'FoodCart/AfterOrder.dart';

class FoodMenuScreen extends StatefulWidget {
  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("food_menu")
                  .document("1bF1qLEpWuhKj9n7Af8P")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ));
                  default:
                    return Menu(
                      snapshot: snapshot,
                    );
                }
              }),
        ),
      ],
    );
  }
}

class Menu extends StatefulWidget {
  final AsyncSnapshot<DocumentSnapshot> snapshot;
  Menu({@required this.snapshot});
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> with TickerProviderStateMixin {
  List<int> itemCount = [];
  List<String> cartItems = [];
  TabController _tabController;
  static List<FoodItem> foodItemList = [];
  SharedPreferences prefs;
  String text = "The Indian Kitchen";
  bool isVeg = false;
  static AsyncSnapshot<DocumentSnapshot> ds;
  Future result;
  int lengthoftab;
  @override
  void initState() {
    lengthoftab = widget.snapshot.data["cuisines"].length;
    _tabController = TabController(
        length: widget.snapshot.data["cuisines"].length,
        vsync: this,
        initialIndex: 0);
    prefs = SharedPreferenceClass.sharedPreferences;
    super.initState();
    ds = widget.snapshot;
    if (!widget.snapshot.data["closed"]) {
      getMenu(widget.snapshot);
    } else {
      foodItemList = [];
    }
  }

  getMenu(AsyncSnapshot<DocumentSnapshot> ds) {
    if (widget.snapshot.data["cuisines"].length != lengthoftab) {
      _tabController.dispose();
      _tabController = TabController(
          length: widget.snapshot.data["cuisines"].length,
          vsync: this,
          initialIndex: 0);
      setState(() {
        lengthoftab = widget.snapshot.data["cuisines"].length;
      });
    }
    foodItemList.clear();
    for (int i = 0; i < ds.data['foodItems'].length; i++) {
      if (ds.data[ds.data['foodItems'][i]]["is_available"])
        foodItemList.add(FoodItem(
            ds.data['foodItems'][i],
            ds.data[ds.data['foodItems'][i]]["name"],
            ds.data[ds.data['foodItems'][i]]["cuisine"],
            ds.data[ds.data['foodItems'][i]]["price"],
            ds.data[ds.data['foodItems'][i]]["is_veg"],
            ds.data[ds.data['foodItems'][i]]["image_url"]));
    }
    getData(ds);
  }

  getData(AsyncSnapshot<DocumentSnapshot> ds) {
    prefs = SharedPreferenceClass.sharedPreferences;
    List<String> list = prefs.getStringList("listItems");
    List<String> numbers = prefs.getStringList("count");
    itemCount = List.filled(widget.snapshot.data["foodItems"].length, 0);
    for (int i = 0; i < ds.data['foodItems'].length; i++) {
      if (list != null) {
        if (list.contains(ds.data['foodItems'][i])) {
          itemCount[i] =
              int.parse(numbers[list.indexOf(ds.data['foodItems'][i])]);
        }
      }
    }
    if (prefs.getBool("after") == true)
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    AfterOrder(orderId: prefs.getString("orderId"))));
      });
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      getData(widget.snapshot);
      if (mounted) setState(() {});
    }
    if (widget.snapshot.data["closed"] != ds.data["closed"]) {
      setState(() {
        ds = widget.snapshot;
      });
    }
    if (!widget.snapshot.data["closed"]) {
      getMenu(widget.snapshot);
    } else if (widget.snapshot.data["closed"]) {
      foodItemList = [];
    }

    return Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        height:
                            MediaQuery.of(context).size.height * 0.206756757,
                        child: Container(
                          color: Colors.black,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                    "assets/images/mitymeal.png",
                                    fit: BoxFit.fitWidth,
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Veg Only",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              )),
                          Theme(
                            data:
                                ThemeData(unselectedWidgetColor: Colors.white),
                            child: Checkbox(
                              value: isVeg,
                              onChanged: (val) {
                                if (mounted)
                                  setState(() {
                                    isVeg = val;
                                  });
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => UpdateProfile()));
                      },
                      child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Profile",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Icon(
                            Icons.people,
                            size: 28.0,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 35.0),
                            child: Text(
                              "Connect with Us:",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var url =
                                'https://www.instagram.com/manipallocals/';
                            if (await UrlLauncher.canLaunch(url)) {
                              await UrlLauncher.launch(url,
                                  universalLinksOnly: true,
                                  forceSafariVC: false,
                                  forceWebView: false);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/images/instagram.png",
                              height: 25.0,
                              width: 25.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final Uri params = Uri(
                              scheme: 'mailto',
                              path: 'manipallocals@gmail.com',
                              query: '',
                            );
                            var url = params.toString();
                            if (await UrlLauncher.canLaunch(url)) {
                              await UrlLauncher.launch(url,
                                  universalLinksOnly: true,
                                  forceSafariVC: false,
                                  forceWebView: false);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/images/gmail.png",
                              height: 25.0,
                              width: 25.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var url = 'https://twitter.com/LocalsManipal';
                            if (await UrlLauncher.canLaunch(url)) {
                              await UrlLauncher.launch(url,
                                  universalLinksOnly: true,
                                  forceSafariVC: false,
                                  forceWebView: false);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/images/twitter.png",
                              height: 25.0,
                              width: 25.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Firestore.instance
                                .collection("SideBar")
                                .document("24gilAUR9c7Mp96RtBAg")
                                .get()
                                .then((DocumentSnapshot ds) async {
                              if (ds.data["whatsapp"] != "null") {
                                var url = ds.data["whatsapp"];
                                if (await UrlLauncher.canLaunch(url)) {
                                  await UrlLauncher.launch(url,
                                      universalLinksOnly: true,
                                      forceSafariVC: false,
                                      forceWebView: false);
                                }
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset(
                              "assets/images/whatsapp.png",
                              height: 25.0,
                              width: 25.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        prefs.setBool("selected", true);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => BeforeMain()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Icon(
                                Icons.autorenew,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Switch to ManipalLocals",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: itemCount.any((element) {
                if (element != 0) {
                  return true;
                } else
                  return false;
              })
                  ? Icon(Icons.shopping_cart)
                  : Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                result = Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FoodCartData()));
              },
            )
          ],
          bottom: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              indicator: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.shade900, Colors.grey.shade900]),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green),
              tabs: [
                for (int i = 0;
                    i < widget.snapshot.data['cuisines'].length;
                    i++)
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.snapshot.data['cuisines'][i],
                          style: TextStyle(
                              color: Color(0xFFFCAE20),
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
              ]),
          backgroundColor: Colors.black,
          title: Container(
            padding: EdgeInsets.only(top: 0.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                for (int i = 0;
                    i < widget.snapshot.data['cuisines'].length;
                    i++)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 8.0,
                      right: 8.0,
                      bottom: 16.0,
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 16.0,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: foodItemList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (foodItemList[index].cuisine ==
                                        widget.snapshot.data['cuisines'][i] &&
                                    (!isVeg || foodItemList[index].isVeg)) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        //  color: Colors.grey.shade900,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0,
                                                2.0), // shadow direction: bottom right
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                    ),
                                                    width: 100,
                                                    height: 100,
                                                    padding: EdgeInsets.all(10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image(
                                                        image: NetworkImage(
                                                            foodItemList[index]
                                                                .image_url),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 3,
                                                        right: 3,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: foodItemList[
                                                                          index]
                                                                      .isVeg
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                              width: 1),
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        child: Icon(
                                                          Icons
                                                              .fiber_manual_record,
                                                          color: foodItemList[
                                                                      index]
                                                                  .isVeg
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  3 +
                                                              20,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 4.0,
                                                                left: 5,
                                                                right: 5,
                                                                top: 4),
                                                        child: Text(
                                                          foodItemList[index]
                                                              .name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color(
                                                                  0xFFFFC800),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Text(
                                                        '\u20B9${foodItemList[index].price}',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xFFFFC800),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      color: itemCount[index] ==
                                                              0
                                                          ? Color(0xFFFFC800)
                                                          : Colors
                                                              .grey.shade200,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  child: itemCount[index] == 0
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            if (mounted)
                                                              setState(() {
                                                                itemCount[
                                                                    index] = 1;

                                                                cartItems.add(
                                                                    foodItemList[
                                                                            index]
                                                                        .id);

                                                                prefs.setStringList(
                                                                    "listItems",
                                                                    cartItems);
                                                                prefs.setStringList(
                                                                    "count",
                                                                    itemCount
                                                                        .map((el) =>
                                                                            el.toString())
                                                                        .toList());
                                                              });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        20),
                                                            child: Text(
                                                              'Add',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (mounted)
                                                                  setState(() {
                                                                    itemCount[
                                                                        index]--;

                                                                    if (itemCount[
                                                                            index] ==
                                                                        0) {
                                                                      cartItems.remove(
                                                                          foodItemList[index]
                                                                              .id);

                                                                      prefs.setStringList(
                                                                          "listItems",
                                                                          cartItems);
                                                                    }
                                                                    prefs.setStringList(
                                                                        "count",
                                                                        itemCount
                                                                            .map((el) =>
                                                                                el.toString())
                                                                            .toList());
                                                                  });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .horizontal_rule,
                                                                  size: 25,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              itemCount[index]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 22),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (mounted)
                                                                  setState(() {
                                                                    itemCount[
                                                                        index]++;
                                                                    prefs.setStringList(
                                                                        "count",
                                                                        itemCount
                                                                            .map((el) =>
                                                                                el.toString())
                                                                            .toList());
                                                                  });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 25,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else
                                  return SizedBox();
                              }))
                    ]),
                  )
              ],
            ),
            if (itemCount.any((element) {
              if (element != 0) {
                return true;
              } else
                return false;
            }))
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: Color(0xFFFFC800),
                  ),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      result = Navigator.push(context,
                          MaterialPageRoute(builder: (_) => FoodCartData()));
                    },
                    child: Center(
                      child: Text(
                        'Order now'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ));
  }
}
