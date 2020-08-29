import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/DataShowPTV.dart';
import 'package:manipal_locals/NonTechnicalClubs.dart';
import 'package:manipal_locals/StudentProjects.dart';
import 'package:manipal_locals/TechnicalClubs.dart';

import 'DataShow.dart';
import 'DataShowSC.dart';

class StudentClubs extends StatelessWidget {
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
              "Student Clubs",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: StudentClubsData(),
      ),
    );
  }
}

class StudentClubsData extends StatefulWidget {
  @override
  _StudentClubsDataState createState() => _StudentClubsDataState();
}

class _StudentClubsDataState extends State<StudentClubsData> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
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
                          FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+"COLLEGE"+".png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                   BackdropFilter(
                                      child: Container(
                                        color: Colors.black12,
                                      ),
                                      filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
                                    ),
                   Center(
                                      child: Container(
                                        child: Text(
                                          "STUDENT PROJECTS",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => StudentProjects()));
            },
          ),
        ),
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
                          FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+"COLLEGE"+".png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  BackdropFilter(
                    child: Container(
                      color: Colors.black12,
                    ),
                    filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "TECHNICAL STUDENT CLUBS",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TechnicalClubs()));
            },
          ),
        ),
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
                          FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+"COLLEGE"+".png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  BackdropFilter(
                    child: Container(
                      color: Colors.black12,
                    ),
                    filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "NON TECHNICAL CLUBS",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NonTechnicalClubs()));
            },
          ),
        ),

      ],
    );
  }
}
