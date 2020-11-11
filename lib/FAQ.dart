import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/AnsewerShow.dart';
import 'package:manipal_locals/HomePage.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> with TickerProviderStateMixin {
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
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ));
                default:
                  _tabController = new TabController(
                      length: snapshot.data['category_name'].length,
                      vsync: this,
                      initialIndex: HomePageState.faqtab);
                  return Scaffold(
                      floatingActionButton: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.orangeAccent.shade700,
                          onPressed: () async {
                            var url = snapshot.data["faq"];
                            if (await UrlLauncher.canLaunch(url)) {
                              await UrlLauncher.launch(url,
                                  universalLinksOnly: true,
                                  forceSafariVC: false,
                                  forceWebView: false);
                            }
                          },
                          child: Icon(
                            Icons.question_answer,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      appBar: AppBar(
                        bottom: TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Colors.orangeAccent.shade700,
                            indicatorSize: TabBarIndicatorSize.tab,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.redAccent,
                                  Colors.orangeAccent
                                ]),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.redAccent),
                            tabs: [
                              for (int i = 0;
                                  i < snapshot.data['category_name'].length;
                                  i++)
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data['category_name'][i],
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
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "FAQ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      body: TabBarView(
                        controller: _tabController,
                        children: [
                          for (int i = 0;
                              i < snapshot.data['category_name'].length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 0.0,
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
                                            snapshot.data["questions"].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          index = snapshot
                                                  .data["questions"].length -
                                              index -
                                              1;
                                          if (snapshot.data["category"]
                                                  [index] ==
                                              snapshot.data['category_name'][i])
                                            return Container(
                                              // height: 50,
                                              child: GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 24.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: Colors.white),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.bookmark),
                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          16.0,
                                                                      top: 16.0,
                                                                      bottom:
                                                                          8.0,
                                                                      right:
                                                                          16.0),
                                                              child: Text(
                                                                snapshot.data[
                                                                        "questions"]
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
                                                          builder:
                                                              (_) => AnswerShow(
                                                                    name: snapshot
                                                                            .data["questions"]
                                                                        [index],
                                                                    data: snapshot
                                                                            .data["answers"]
                                                                        [index],
                                                                    index: _tabController
                                                                        .index,
                                                                  )));
                                                },
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
