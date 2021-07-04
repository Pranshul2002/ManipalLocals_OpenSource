import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/utils/widget.dart';

import 'data_show_feed.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          background(
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
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

class FeedData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("feed")
                  .doc("Ny7eY5zxTDgm8VAig6r6")
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
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 16.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!["article_name"].length,
                              itemBuilder: (context, int index) {
                                return Container(
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
                                                child: CachedNetworkImage(
                                                  imageUrl: Convert.convertString(
                                                      "gs://manipallocals-2f95e.appspot.com/" +
                                                          snapshot.data![
                                                                  "article_name"]
                                                                  [index]
                                                              .replaceAll(
                                                                  new RegExp(
                                                                      r"\s+"),
                                                                  "") +
                                                          ".png"),
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
                                                snapshot.data!["article_name"]
                                                    [index],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DataShowFeed(
                                                  name: snapshot
                                                          .data!["article_name"]
                                                      [index]),
                                              settings: RouteSettings(
                                                  name:
                                                      "/HomePage/College/${snapshot.data!["article_name"][index]}")));
                                    },
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                }
              }),
        ),
      ],
    );
  }
}
