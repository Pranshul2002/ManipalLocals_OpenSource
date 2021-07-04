import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/utils/widget.dart';

class DataShowFeed extends StatelessWidget {
  final String? name;

  DataShowFeed({this.name});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          background(
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("feed")
                .doc(name)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Fluttertoast.showToast(
                    msg: "Error: ${snapshot.error}",
                    toastLength: Toast.LENGTH_SHORT);
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                    child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ));

              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        name!.toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                body: DataShowFeedStf(
                  name: name,
                  data: (snapshot.data! as Map)["data"],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DataShowFeedStf extends StatelessWidget {
  final String? name;
  final List<dynamic>? data;
  DataShowFeedStf({this.name, this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: Convert.convertString(
                  "gs://manipallocals-2f95e.appspot.com/" +
                      name!.replaceAll(new RegExp(r"\s+"), "") +
                      ".png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data!.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 33.0, right: 33.0),
                child: Text(
                  data![index],
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            })
      ],
    );
  }
}
