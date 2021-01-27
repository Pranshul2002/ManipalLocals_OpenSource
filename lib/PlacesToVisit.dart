import 'dart:ui';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MityMeal/Utils.dart';

class PlacesToVisit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/ML_doodles.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Places To Visit",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            body: PlacesToVisitData(),
          ),
        ],
      ),
    );
  }
}

class PlacesToVisitData extends StatefulWidget {
  @override
  PlacesToVisitDataState createState() => PlacesToVisitDataState();
}

class PlacesToVisitDataState extends State<PlacesToVisitData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("placestovisit")
                  .document("iYIQDpSKtWjKPo3E4965")
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
                    return ListView.builder(
                      itemCount: snapshot.data["places_name"].length,
                      itemBuilder: (BuildContext context, int index) {
                        index = snapshot.data["places_name"].length - index - 1;
                        return Column(
                          children: [
                            SizedBox(
                              height: 16.0,
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 16.0,
                                    right: 16.0),
                                height: 300,
                                child: CardDesign(
                                    snapshot.data["places_name"][index],
                                    snapshot)),
                          ],
                        );
                      },
                    );
                }
              }),
        ),
      ],
    );
  }
}

class CardDesign extends StatefulWidget {
  String name;
  AsyncSnapshot<DocumentSnapshot> ds;
  CardDesign(this.name, this.ds);

  @override
  _CardDesignState createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign>
    with SingleTickerProviderStateMixin {
  AnimationController animation;
  String name;

  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  Animation<double> animate;

  int index = 1;
  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animate = Tween<double>(begin: 0, end: 180).animate(animation);
    animate.addListener(() {
      setState(() {});
    });
    setState(() {
      name = widget.name;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animation.dispose();
  }

  String article = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()..rotateY(math.pi * animate.value / 180),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xff1e1e1e),
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Column(
            children: [
              if (animate.value < 90)
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: Image(
                                image: NetworkImage(Convert.convertString(
                                    "gs://manipallocals-2f95e.appspot.com/" +
                                        name.replaceAll(
                                            new RegExp(r"\s+"), "") +
                                        index.toString() +
                                        ".png")),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            icon: Icon(
                              Icons.navigate_next,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                if (index < 3) {
                                  index = index + 1;
                                }
                              });
                            }),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(
                              Icons.navigate_before,
                              size: 40,
                            ),
                            onPressed: () {

                              setState(() {
                                if (index > 1) {
                                  index = index - 1;
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              if (animate.value >= 90)
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.topCenter,
                        child: Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()..rotateY(math.pi),
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      for (article in widget.ds.data[name])
                        Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.topCenter,
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()..rotateY(math.pi),
                            child: Text(
                              article,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (_animationStatus == AnimationStatus.dismissed) {
          animation.forward();
          _animationStatus = AnimationStatus.completed;
        } else {
          animation.reverse();
          _animationStatus = AnimationStatus.dismissed;
        }
        // if (widget.ds.data[name] != null) {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (_) => DataShowPTV(
        //                 name: name,
        //                 data: widget.ds.data[name],
        //                 location: widget.ds.data["location"][name],
        //               )));
        // }
      },
    );
  }
}
