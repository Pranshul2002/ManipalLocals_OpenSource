import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/AnsewerShow.dart';

class Faq extends StatelessWidget {
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
              "FAQ",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: FaqDesign(),
      ),
    );
  }
}
class FaqDesign extends StatefulWidget {
  @override
  _FaqDesignState createState() => _FaqDesignState();
}

class _FaqDesignState extends State<FaqDesign> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 16.0,),
            Expanded(child: StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection("faq")
                    .document("i8navL8FfkAkSPOARImq")
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
                      return ListView.builder(
                        itemCount: snapshot.data["questions"].length,
                        itemBuilder: (BuildContext context, int index){
                          return
                            Container(
                              height: 50,
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: Colors.white),
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.white),
                                    ),

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.bookmark),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 16.0, top: 8.0),
                                          child: Text(
                                            snapshot.data["questions"][index],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AnswerShow(name: snapshot.data["questions"][index],data:  snapshot.data["answers"][index],)));
                                },
                              ),
                            );
                        },

                      );
                  }
                }),)
          ],
        )
      ],
    );
  }
}


