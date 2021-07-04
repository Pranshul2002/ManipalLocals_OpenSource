import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/bloc/home_page/home_page_bloc.dart';
import 'package:manipal_locals/features/studentclubpage/sc_show_data.dart';
import 'package:manipal_locals/utils/widget.dart';

class StudentClub extends StatefulWidget {
  @override
  _StudentClubState createState() => _StudentClubState();
}

class _StudentClubState extends State<StudentClub>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int i = 0;
  void fixMyMistakes() {
    FirebaseFirestore.instance.collection("studentclubs").get().then((value) {
      LinkedHashMap<String, dynamic> type = LinkedHashMap<String, dynamic>();
      LinkedHashMap<String, dynamic>? snapshot;
      for (DocumentSnapshot ds in value.docs) {
        if (ds.id == "oX9cjF5GdUXWVdNfuVCx") {
          snapshot = ds.data() as LinkedHashMap<String, dynamic>?;
          continue;
        }
        type.addAll({ds.id: ds["type"]});
      }
      snapshot!.addAll({"type": type});
      FirebaseFirestore.instance
          .collection("studentclubs")
          .doc("oX9cjF5GdUXWVdNfuVCx")
          .update(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("studentclubs")
                .doc("oX9cjF5GdUXWVdNfuVCx")
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
                      length: snapshot.data!['type_names'].length,
                      vsync: this,
                      initialIndex: BlocProvider.of<HomePageBloc>(context)
                          .studentClubTabIndex);
                  _tabController!.addListener(() {
                    BlocProvider.of<HomePageBloc>(context).add(
                        HomePageChangeStudentClubTab(_tabController!.index));
                  });

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
                                      i < snapshot.data!['type_names'].length;
                                      i++)
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data!['type_names'][i],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                    ),
                                ]),
                            backgroundColor: Colors.transparent,
                            title: Container(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Text(
                                "Student Clubs",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          body: TabBarView(
                            controller: _tabController,
                            children: [
                              for (int i = 0;
                                  i < snapshot.data!['type_names'].length;
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
                                                snapshot.data!["clubs"].length,
                                            itemBuilder: (BuildContext context,
                                                int? index) {
                                              index = snapshot
                                                      .data!["clubs"].length -
                                                  index -
                                                  1;
                                              if (snapshot.data!["type"][
                                                      snapshot.data!["clubs"]
                                                          [index]] ==
                                                  snapshot.data!['type_names']
                                                      [i])
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16.0,
                                                          bottom: 32.0),
                                                  child: Container(
                                                    height: 100,
                                                    child: GestureDetector(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
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
                                                                          .all(
                                                                              10),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl: Convert.convertString(snapshot
                                                                              .data![
                                                                          "club_icon"][snapshot
                                                                              .data!["clubs"]
                                                                          [
                                                                          index]]),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            16.0,
                                                                        top:
                                                                            16.0,
                                                                        bottom:
                                                                            16.0,
                                                                        right:
                                                                            16.0),
                                                                    child: Text(
                                                                      snapshot.data![
                                                                              "clubs"]
                                                                          [
                                                                          index],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                builder: (_) =>
                                                                    ClubContent(
                                                                        snapshot.data!["clubs"]
                                                                            [
                                                                            index]),
                                                                settings:
                                                                    RouteSettings(
                                                                        name:
                                                                            "/HomePage/StudentClub/${snapshot.data!["clubs"][index]}")));
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
                          )),
                    ],
                  );
              }
            }),
      ],
    ));
  }
}
