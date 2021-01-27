import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'DataShowFeed.dart';
import 'MityMeal/Utils.dart';

class Feed extends StatelessWidget {
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
              elevation: 0,
              title: Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Feed",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            body: FeedData(),
          ),
        ],
      ),
    );
  }
}

class FeedData extends StatefulWidget {
  @override
  _FeedDataState createState() => _FeedDataState();
}

class _FeedDataState extends State<FeedData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("feed")
                  .document("Ny7eY5zxTDgm8VAig6r6")
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
                    return ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 16.0,
                        ),
                        for (String name
                            in snapshot.data["article_name"].reversed.toList())
                          Container(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0),
                            height: 200,
                            child: GestureDetector(
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Color(0xff1e1e1e),
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24))),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Image(
                                            image: NetworkImage(
                                                Convert.convertString(
                                                    "gs://manipallocals-2f95e.appspot.com/" +
                                                        name.replaceAll(
                                                            new RegExp(r"\s+"),
                                                            "") +
                                                        ".png")),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ],
                                    ),
                                    BackdropFilter(
                                      child: Container(
                                        color: Colors.black12,
                                      ),
                                      filter: ImageFilter.blur(
                                          sigmaY: 4, sigmaX: 4),
                                    ),
                                    Center(
                                      child: Container(
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (snapshot.data[name] != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DataShowFeed(
                                                name: name,
                                                data: snapshot.data[name],
                                              )));
                                }
                              },
                            ),
                          ),
                      ],
                    );
                }
              }),
        ),
      ],
    );
  }
}
