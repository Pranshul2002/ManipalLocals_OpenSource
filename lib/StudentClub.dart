import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manipal_locals/AnsewerShow.dart';
import 'package:manipal_locals/HomePage.dart';
import 'package:manipal_locals/SCShowData.dart';

class StudentClub extends StatefulWidget {
  @override
  _StudentClubState createState() => _StudentClubState();
}

class _StudentClubState extends State<StudentClub>
    with TickerProviderStateMixin {
  bool loading = true;
  TabController _tabController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("studentclubs")
                .document("oX9cjF5GdUXWVdNfuVCx")
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
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ));
                default:
                  _tabController = new TabController(
                      length: snapshot.data['type_names'].length,
                      vsync: this,
                      initialIndex: HomePageState.selectedtab);

                  return Scaffold(
                      appBar: AppBar(
                        bottom: TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Colors.blue.shade400,
                            indicatorSize: TabBarIndicatorSize.tab,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.deepPurpleAccent.shade400,
                                  Colors.blueAccent
                                ]),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.blueAccent),
                            tabs: [
                              for (int i = 0;
                                  i < snapshot.data['type_names'].length;
                                  i++)
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        snapshot.data['type_names'][i],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                        backgroundColor: Colors.black,
                        title: Container(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Text(
                            "Student Clubs",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      body: TabBarView(
                        controller: _tabController,
                        children: [
                          for (int i = 0;
                              i < snapshot.data['type_names'].length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                                left: 8.0,
                                right: 8.0,
                                bottom: 16.0,
                              ),
                              child: Column(children: [
                                SizedBox(
                                  height: 16.0,
                                ),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            snapshot.data["clubs"].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          index =
                                              snapshot.data["clubs"].length -
                                                  index -
                                                  1;
                                          if (snapshot.data["type"][snapshot
                                                  .data["clubs"][index]] ==
                                              snapshot.data['type_names'][i])
                                            // return homeButton(
                                            //     title1: snapshot.data["clubs"]
                                            //         [index],
                                            //     title2: "",
                                            //     url: snapshot.data["club_icon"][
                                            //         snapshot.data["clubs"]
                                            //             [index]],
                                            //     onPressed: () {});
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0, bottom: 32.0),
                                              child: Container(
                                                height: 100,
                                                child: GestureDetector(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0.0),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              height: 100,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image(
                                                                  image: FirebaseImage(snapshot
                                                                          .data[
                                                                      "club_icon"][snapshot
                                                                              .data[
                                                                          "clubs"]
                                                                      [index]]),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            16.0,
                                                                        top:
                                                                            16.0,
                                                                        bottom:
                                                                            16.0,
                                                                        right:
                                                                            16.0),
                                                                child: Text(
                                                                  snapshot.data[
                                                                          "clubs"]
                                                                      [index],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) => ClubContent(
                                                                snapshot,
                                                                snapshot.data[
                                                                        "clubs"]
                                                                    [index],
                                                                _tabController
                                                                    .index)));
                                                  },
                                                ),
                                              ),
                                            );
                                          else
                                            return SizedBox();
                                        }))
                              ]),
                            )
                        ],
                      ));
              }
            }));
  }
}
