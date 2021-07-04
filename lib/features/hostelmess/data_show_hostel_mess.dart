import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manipal_locals/utils/widget.dart';

class DataShowHostelMess extends StatelessWidget {
  final String? name;
  DataShowHostelMess({this.name});
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
              backgroundColor: Colors.transparent,
            ),
            body: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("hostel_mess")
                  .doc(name)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                if (snapshot.hasError)
                  return Center(
                    child: Text(snapshot.error as String),
                  );
                return DataShowStf(name: name, data: snapshot.data!["data"]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DataShowStf extends StatelessWidget {
  final String? name;
  final List? data;

  DataShowStf({this.name, this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            name!,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        for (String article in data as Iterable<String>)
          Padding(
            padding: const EdgeInsets.only(left: 33.0, right: 33.0),
            child: Text(
              article,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
