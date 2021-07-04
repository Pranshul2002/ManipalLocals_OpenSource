import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/utils/widget.dart';

import 'gallery_image_container.dart';

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("gallery")
            .doc("VU38e36gySgxCHnJaFk3")
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
              return Stack(
                children: [
                  background(MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width),
                  Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Expanded(
                              child: GridView.builder(
                            itemCount: snapshot.data!["images"].length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return ImageContainer(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                url: snapshot.data!["images"][index],
                                credit: snapshot.data!["credit"][index],
                              );
                            },
                          )),
                        ],
                      )),
                ],
              );
          }
        });
  }
}
