import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/MityMeal/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class FoodMenuScreen extends StatefulWidget {
  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  @override
  Widget build(BuildContext context) {
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
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  List<int> itemCount;
  List<String> cartItems = [];
  TabController _tabController;
  List<FoodItem> foodItemList = [];
  SharedPreferences prefs;
  String text = "Menu";
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    super.initState();
    getMenu(widget.snapshot);
  }

  getMenu(AsyncSnapshot<DocumentSnapshot> ds) {
    prefs = SharedPreferenceClass.sharedPreferences;
    List<String> list = prefs.getStringList("listItems");
    List<String> numbers = prefs.getStringList("count");
    itemCount = List.filled(widget.snapshot.data["foodItems"].length, 0);
    for (int i = 0; i < ds.data['foodItems'].length; i++) {
      if (ds.data[ds.data['foodItems'][i]]["is_available"])
        foodItemList.add(FoodItem(
            ds.data['foodItems'][i],
            ds.data[ds.data['foodItems'][i]]["name"],
            ds.data[ds.data['foodItems'][i]]["cuisine"],
            ds.data[ds.data['foodItems'][i]]["price"],
            ds.data[ds.data['foodItems'][i]]["is_veg"]));
      if (list != null) {
        if (list.contains(ds.data['foodItems'][i])) {
          itemCount[i] =
              int.parse(numbers[list.indexOf(ds.data['foodItems'][i])]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
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
        body: TabBarView(
          controller: _tabController,
          children: [
            for (int i = 0; i < widget.snapshot.data['cuisines'].length; i++)
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
                                widget.snapshot.data['cuisines'][i]) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey.shade900,
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0, horizontal: 20),
                                            child: Text(
                                              foodItemList[index].name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFFFFC800),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              '\u20B9${foodItemList[index].price}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFFFFC800),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                            width: 100,
                                            height: 100,
                                            padding: EdgeInsets.all(10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image(
                                                image: NetworkImage(
                                                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  color: itemCount[index] == 0
                                                      ? Color(0xFFFFC800)
                                                      : Colors.grey.shade100,
                                                  border: Border.all(
                                                      color: Colors.black12)),
                                              child: itemCount[index] == 0
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          itemCount[index] = 1;
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
                                                                  .map((el) => el
                                                                      .toString())
                                                                  .toList());
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5.0,
                                                                horizontal: 20),
                                                        child: Text(
                                                          'Add',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              itemCount[
                                                                  index]--;
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
                                                                    right: 3.0),
                                                            child: Icon(
                                                              Icons
                                                                  .horizontal_rule,
                                                              size: 30,
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
                                                                    left: 2.0),
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 30,
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
        ));
  }
}
