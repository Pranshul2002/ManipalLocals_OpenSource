import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'gallery_image_container.dart';

class GalleryScreen extends StatefulWidget {
  // 150 ,150,120,130,150
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with AutomaticKeepAliveClientMixin {
  List<double> width = [150, 125, 100, 112, 145, 120, 130, 135, 160];
  List<double> height = [150, 125, 100, 112, 145, 120, 130, 135, 160];
  Random random = Random();
  int dimensionIndex1, dimensionIndex2;
  int index1;
  int randomLandscape;
  int prev;
  Widget listItem(AsyncSnapshot<DocumentSnapshot> snapshot) {
    randomLandscape = random.nextInt(5);
    dimensionIndex1 = random.nextInt(9);
    dimensionIndex2 = random.nextInt(9);

    // print(index1);
    // if (index1 >=
    //     snapshot.data["images"].length - 1) {
    //   SchedulerBinding.instance
    //       .addPostFrameCallback((_) {
    //     index1 = -1;
    //   });
    // }
    if (index1 == -1) {
      index1++;
    } else {
      if (randomLandscape == 1 && prev == 1) {
        index1 = index1 + 1;
      } else if (randomLandscape == 1 && prev != 1) {
        index1 = index1 + 2;
      } else if (prev != 1) {
        index1 = index1 + 2;
      } else {
        index1 = index1 + 1;
      }
    }

    prev = randomLandscape;
    if (index1 == 0) prev = 1;
    if (index1 <= snapshot.data["images"].length - 1)
      return (index1 == 0 || randomLandscape == 1)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (index1 <= snapshot.data["images"].length - 1)
                  Expanded(
                    child: ImageContainer(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      credit: snapshot.data["credit"][index1],
                      url: snapshot.data["images"][index1],
                    ),
                  ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (index1 <= snapshot.data["images"].length - 1 &&
                    index1 + 1 <= snapshot.data["images"].length - 1)
                  Expanded(
                    child: ImageContainer(
                      credit: snapshot.data["credit"][index1],
                      height: height[dimensionIndex1],
                      width: width[dimensionIndex1],
                      url: snapshot.data["images"][index1],
                    ),
                  ),
                if (index1 <= snapshot.data["images"].length - 1 &&
                    index1 + 1 > snapshot.data["images"].length - 1)
                  Expanded(
                    child: ImageContainer(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      credit: snapshot.data["credit"][index1],
                      url: snapshot.data["images"][index1],
                    ),
                  ),
                if (index1 + 1 <= snapshot.data["images"].length - 1)
                  Expanded(
                    child: ImageContainer(
                      credit: snapshot.data["credit"][index1 + 1],
                      height: height[dimensionIndex2],
                      width: width[dimensionIndex2],
                      url: snapshot.data["images"][index1 + 1],
                    ),
                  ),
              ],
            );
    else
      return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("gallery")
            .document("VU38e36gySgxCHnJaFk3")
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
              index1 = -1;
              prev = 1;
              return Stack(
                children: [
                  Image.asset(
                    "assets/images/ML_doodles.png",
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   padding: EdgeInsets.all(16),
                          //   child: Text(
                          //     "Gallery",
                          //     style: TextStyle(fontSize: 75),
                          //   ),
                          // ),
                          Expanded(
                              child: ListView(
                            children: [
                              for (;
                                  index1 <= snapshot.data["images"].length - 1;)
                                listItem(snapshot)
                            ],
                          )),
                        ],
                      )),
                ],
              );
          }
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
