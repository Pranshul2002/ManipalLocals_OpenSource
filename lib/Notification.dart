import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/NotificationShow.dart';

import 'MessageBean.dart';

class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => NotificationPageState();
  static MessageBean item;
}

class NotificationPageState extends State<NotificationPage> {
  static MessageBean items = new MessageBean();

  @override
  void initState() {
    super.initState();
  }

  Widget NewNotification() {
    try {
      NotificationPage.item.addListener(() {
        if (mounted) {
          setState(() {
            items = NotificationPage.item;
          });
        }
      });
    } catch (e) {
      print(e);
    }
    return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
        color: Colors.transparent,
        shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.topCenter,
                child: items.head != null
                    ? Text(
                        items.head,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      )
                    : Text("No new notifications"),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: items.body != null ? Text(items.body) : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  final fire = Firestore.instance;

  Widget BottomPart() {
    return Expanded(
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("notification")
              .document("MbVRBNqnOSwu0n5aAZQl")
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
                return ListView.builder(
                  itemCount: snapshot.data["head"].length,
                  itemBuilder: (BuildContext context, int index) {
                    index = snapshot.data["head"].length - index - 1;
                    return Container(
                      height: 50,
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.white),
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.white),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                Icon(Icons.bookmark,color: Colors.orangeAccent.shade700,),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 16.0, top: 8.0),
                                  child: Text(
                                    snapshot.data["head"][index],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          //       print(snapshot.data["pdf_included"][index].toString());
                          if (snapshot.data["body"][index] != "null") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => NotificationShow(
                                          name: snapshot.data["head"][index],
                                          data: snapshot.data["body"][index],
                                          url: snapshot.data["pdf_included"]
                                                          [index]
                                                      .toString() ==
                                                  "null"
                                              ? ["null"]
                                              : snapshot.data[snapshot
                                                  .data["pdf_included"][index]],
                                        )));
                          }
                        },
                      ),
                    );
                  },
                );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewNotification(),
        SizedBox(
          height: 25,
        ),
        BottomPart()
      ],
    );
  }
}
