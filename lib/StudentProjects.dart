import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/DataShowPTV.dart';

import 'DataShow.dart';
import 'DataShowSC.dart';

class StudentProjects extends StatelessWidget {
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
          title: Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Student Projects",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: StudentProjectsData(),
      ),
    );
  }
}

class StudentProjectsData extends StatefulWidget {
  @override
  _StudentProjectsDataState createState() => _StudentProjectsDataState();
}

class _StudentProjectsDataState extends State<StudentProjectsData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("StudentProjects")
                  .document("Ud9VpgYNLbhPEIJU6WVl")
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
                          height: 32.0,
                        ),
                        for (String name in snapshot.data["projects"])
                          Container(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0
                            ),
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
                                          child: Image(
                                            image:
                                            FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+name.replaceAll(new RegExp(r"\s+"), "")+".png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  /*  BackdropFilter(
                                      child: Container(
                                        color: Colors.black12,
                                      ),
                                      filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
                                    ),*/
                                 /*   Center(
                                      child: Container(
                                        child: Text(
                                          name,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),*/
                                  ],
                                ),
                              ),
                              onTap: () {
                                if(snapshot.data[name] != null){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DataShowSC(name: name,data: snapshot.data[name])));
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
