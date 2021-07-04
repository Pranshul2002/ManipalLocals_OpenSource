import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/utils/widget.dart';

import 'data_show_hostel_mess.dart';

class HostelMess extends StatelessWidget {
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
        ],
      ),
    );
  }
}

class HostelMessBody extends StatefulWidget {
  @override
  _HostelMessBodyState createState() => _HostelMessBodyState();
}

class _HostelMessBodyState extends State<HostelMessBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("hostel_mess")
                  .doc("oc3MvodVps5V8qhiN0qu")
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
                        CachedNetworkImage(
                            placeholder: (_, a) => Center(
                                    child: new CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )),
                            imageUrl: Convert.convertString(
                                "gs://manipallocals-2f95e.appspot.com/hostel.png")),
                        SizedBox(
                          height: 16.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  snapshot.data!["hostel_mess_data"].length,
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(48))),
                                      child: Center(
                                        child: Container(
                                          child: Text(
                                            snapshot.data!["hostel_mess_data"]
                                                [index],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      print(snapshot.data!["hostel_mess_data"]
                                          [index]);
                                      if (snapshot.data!["hostel_mess_data"]
                                              [index] !=
                                          null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    DataShowHostelMess(
                                                      name: snapshot.data![
                                                              "hostel_mess_data"]
                                                          [index],
                                                    ),
                                                settings: RouteSettings(
                                                    name:
                                                        "/HomePage/College/${snapshot.data!["hostel_mess_data"][index]}")));
                                      }
                                    },
                                  ),
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
  }
}
