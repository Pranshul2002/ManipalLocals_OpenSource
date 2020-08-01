import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DataShow.dart';

class GetARide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black,
                height: 3.0,
              ),
              preferredSize: Size.fromHeight(3.0)),
          backgroundColor: Color(0xffFF9609),
          title: Text(
            "GET A RIDE",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: GetARideBody(),
      ),
    );
  }
}

class GetARideBody extends StatefulWidget {
  @override
  _GetARideBodyState createState() => _GetARideBodyState();
}

class _GetARideBodyState extends State<GetARideBody> {
  double Height = 100;
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image:
          FirebaseImage("gs://manipallocals-2f95e.appspot.com/AUTO.png"),
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
                        SizedBox(height: 16.0,),
                        for (String name in snapshot.data["document_data"])
                          Container(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0),
                            height: Height,
                            child: GestureDetector(
                              child: Card(
                                  elevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(24))),
                                  child: Center(child: Container(padding:EdgeInsets.only(left: 32.0),child: Text(name,style: TextStyle(fontSize: 20),),))
                              ),
                              onTap: (){

                              },
                            ),
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
