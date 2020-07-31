import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'DataShow.dart';

class College extends StatelessWidget {
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
            "COLLEGE",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: CollegeData(),
      ),
    );
  }
}

class CollegeData extends StatefulWidget {
  @override
  _CollegeDataState createState() => _CollegeDataState();
}

class _CollegeDataState extends State<CollegeData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("college_data")
              .document("gHyYe7RUaRgKARY0i4xW")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(msg: "Error: ${snapshot.error}",toastLength: Toast.LENGTH_SHORT);
              return Container();
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ));
              default:
                return ListView(
                  children: <Widget>[

                    for (String name in snapshot.data["document_names"])
                      Container(
                        padding: EdgeInsets.only(
                            top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                        height: MediaQuery.of(context).size.width * 0.533950617,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => DataShow()));
                          },
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            child: Stack(children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width *
                                      0.533950617,
                                  child: Image.network(
                                    snapshot.data[name],
                                    fit: BoxFit.fill,
                                  )),
                              Center(
                                  child: Text(
                                name,
                                style: TextStyle(fontSize: 20),
                              ))
                            ]),
                          ),
                        ),
                      )
                  ],
                );
            }
          }),
    );
  }
}
