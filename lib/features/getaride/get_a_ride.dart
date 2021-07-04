import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/utils/widget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class GetARide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(
          MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Container(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Get A Ride",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          body: GetARideBody(),
        ),
      ],
    );
  }
}

class GetARideBody extends StatelessWidget {
  Widget custom(List contacts) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            UrlLauncher.launch("tel://" + contacts[index]);
          },
          title: Row(children: [
            Icon(Icons.phone),
            SizedBox(
              width: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "${contacts[index]}",
                style: TextStyle(fontSize: 16.0),
              ),
            )
          ]),
        );
      },
      itemCount: contacts.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CachedNetworkImage(
            placeholder: (_, String a) => Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
            imageUrl: Convert.convertString(
                "gs://manipallocals-2f95e.appspot.com/AUTO.png")),
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("get_a_ride")
                  .doc("P4LTcIxxXczvJmkDAxOW")
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
                              itemCount: snapshot.data!["document_data"].length,
                              itemBuilder: (context, int index) {
                                return Padding(
                                  child: ExpansionTile(
                                    title: Text(
                                      snapshot.data!["document_data"][index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    children: [
                                      custom(snapshot.data![snapshot
                                          .data!["document_data"][index]]),
                                    ],
                                  ),
                                  padding:
                                      EdgeInsets.only(top: 16.0, bottom: 16.0),
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
    ;
  }
}
