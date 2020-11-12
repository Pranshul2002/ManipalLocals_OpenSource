import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Get_A_Ride extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          body: Get_A_RideStateful(),
        ),
      ],
    );
  }
}

class Get_A_RideStateful extends StatefulWidget {
  @override
  _Get_A_RideStatefulState createState() => _Get_A_RideStatefulState();
}

class _Get_A_RideStatefulState extends State<Get_A_RideStateful> {
  final global = GlobalKey();
  Widget custom(List contacts) {
    print(contacts);
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
        Image(
          image: FirebaseImage("gs://manipallocals-2f95e.appspot.com/AUTO.png"),
        ),
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("get_a_ride")
                  .document("P4LTcIxxXczvJmkDAxOW")
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
                        for (String name in snapshot.data["document_data"])
                          Padding(
                            child: ExpansionTile(
                              title: Text(
                                name,
                                style: TextStyle(fontSize: 16),
                              ),
                              children: [
                                custom(snapshot.data[name]),
                              ],
                            ),
                            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          ),
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
