import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DataShow.dart';

class HostelMess extends StatelessWidget {
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
          backgroundColor: Color(0xffFF8C00),
          title: Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "HOSTEL/MESS",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: HostelMessBody(),
      ),
    );
  }
}

class HostelMessBody extends StatefulWidget {
  @override
  _HostelMessBodyState createState() => _HostelMessBodyState();
}

class _HostelMessBodyState extends State<HostelMessBody> {
  double Height = 100;
bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image:
              FirebaseImage("gs://manipallocals-2f95e.appspot.com/hostel.png"),
        ),
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("hostel_mess")
                  .document("oc3MvodVps5V8qhiN0qu")
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
                        for (String name in snapshot.data["hostel_mess_data"])
                          Container(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0
                            ),
                            height: 100,
                            child: GestureDetector(
                              child: Card(
                                color: Color(0xff1e1e1e),
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24))),
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                if(snapshot.data[name] != null){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DataShow(name: name,data: snapshot.data[name])));
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
