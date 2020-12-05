import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodMenuScreen extends StatefulWidget {
  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen>
    with SingleTickerProviderStateMixin {
  List<String> cuisines = [
    'Salads',
    'Chinese',
    'Italian',
    'Indian',
    'Desserts'
  ];
  List<String> foodItems = [
    'Caeser salad',
    'Manchurian',
    'Pasta',
    'Paneer Masala',
    'Gulab Jamun',
    'Russian Salads',
  ];
  List<int> itemCount = [ 0,0,0,0,0,0];
  List<int> foodItemPrice = [
    100,200,300,400,500,600
  ];
  List<String> correspondingCuisine = [
    'Salads',
    'Chinese',
    'Italian',
    'Indian',
    'Desserts',
    'Salads'
  ];
  List<String> cartItems = [];
  List<int> price = [];
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    // TODO: implement initState
    super.initState();
  }

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
                    return Scaffold(
                        backgroundColor: Colors.deepPurple,
                        appBar: AppBar(
                          bottom: TabBar(
                              controller: _tabController,
                              unselectedLabelColor: Colors.black54,
                              indicatorSize: TabBarIndicatorSize.tab,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.green[700],
                                    Colors.green[400],
                                  ]),
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.green),
                              tabs: [
                                for (int i = 0; i < cuisines.length; i++)
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          cuisines[i],
                                          style: TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                          backgroundColor: Colors.transparent,
                          title: Container(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Text(
                              "Menu",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        body: TabBarView(
                          controller: _tabController,
                          children: [
                            for (int i = 0; i < cuisines.length; i++)
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
                                          itemCount: foodItems.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            if (correspondingCuisine[index] == cuisines[i]) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 16.0, ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(30)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal:20),
                                                            child: Text(foodItems[index],
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal:  20),
                                                            child: Text('\u20B9${foodItemPrice[index]}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Column(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                              BorderRadius.all(
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
                                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(30)),
                                                                  color: itemCount[i]==0?Colors.red:Colors.grey.shade100,
                                                                  border: Border.all(color: Colors.black12)),
                                                              child: itemCount[i] == 0?GestureDetector(
                                                                onTap: (){
                                                                  setState(() {
                                                                    itemCount[i] = 1;
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 20),
                                                                  child: Text('Add',style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.white,
                                                                  ),),
                                                                ),
                                                              ):Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        itemCount[i]--;
                                                                      });
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(right: 3.0),
                                                                      child: Icon(Icons.horizontal_rule,size: 30,color: Colors.black54,),
                                                                    ),
                                                                  ),
                                                                  Text(itemCount[i].toString(),style: TextStyle(
                                                                      fontSize: 22
                                                                  ),),
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        itemCount[i]++;
                                                                      });
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left:2.0),
                                                                      child: Icon(Icons.add,size: 30,color: Colors.black54,),
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
              }),
        ),
      ],
    );
  }
}
