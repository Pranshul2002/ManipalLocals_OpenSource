import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/utils/widget.dart';

import 'data_show_college.dart';

class College extends StatelessWidget {
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
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.black,
                    height: 3.0,
                  ),
                  preferredSize: Size.fromHeight(3.0)),
              backgroundColor: Colors.transparent,
              title: Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "COLLEGE",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            body: CollegeData(),
          ),
        ],
      ),
    );
  }
}

class CollegeData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("college_data")
                  .doc("gHyYe7RUaRgKARY0i4xW")
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
                    break;
                  default:
                    return Column(
                      children: [
                        CachedNetworkImage(
                            placeholder: (_, String a) =>
                                CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                            imageUrl: Convert.convertString(
                                "gs://manipallocals-2f95e.appspot.com/COLLEGE.png")),
                        SizedBox(
                          height: 16.0,
                        ),
                        Expanded(
                            child: ListView.builder(
                                reverse: true,
                                itemCount:
                                    snapshot.data!["document_names"].length,
                                itemBuilder: (context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        top: 16.0,
                                        bottom: 16.0,
                                        left: 16.0,
                                        right: 16.0),
                                    height: 100,
                                    child: GestureDetector(
                                      child: Card(
                                        color: Color(0xff1e1e1e),
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(48))),
                                        child: Center(
                                          child: Container(
                                            child: Text(
                                              snapshot.data!["document_names"]
                                                  [index],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (snapshot.data!["document_names"]
                                                [index] !=
                                            null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataShowCollege(
                                                        name: snapshot.data![
                                                                "document_names"]
                                                            [index],
                                                      ),
                                                  settings: RouteSettings(
                                                      name:
                                                          "/HomePage/College/${snapshot.data!["document_names"][index]}")));
                                        }
                                      },
                                    ),
                                  );
                                }))
                      ],
                    );
                }
              }),
        ),
      ],
    );
  }
}
