import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manipal_locals/features/studentclubpage/sc_widgets.dart';
import 'package:manipal_locals/utils/widget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ClubContent extends StatelessWidget {
  final String? name;
  ClubContent(this.name);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("studentclubs")
            .doc(name)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(
                msg: "Error: ${snapshot.error}",
                toastLength: Toast.LENGTH_SHORT);
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
                child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ));

          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                CachedNetworkImage(
                  placeholder: (_, a) => Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  imageUrl: Convert.convertString(
                    (snapshot.data! as Map)["club_icon"],
                  ),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ), //club logo
                Padding(
                  padding: EdgeInsets.only(top: 290),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1e1e1e),
                        border: Border.all(),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: ListView(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                (snapshot.data! as Map)["description"].length,
                            itemBuilder: (context, int index) {
                              return getWidget(
                                  (snapshot.data! as Map)["description"][index],
                                  snapshot.data,
                                  context);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50.0,
                                child: RaisedButton(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  onPressed: () async {
                                    var url = (snapshot.data! as Map)["insta"];
                                    if (await UrlLauncher.canLaunch(url)) {
                                      await UrlLauncher.launch(url,
                                          universalLinksOnly: true,
                                          forceSafariVC: false,
                                          forceWebView: false);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            // Color(0xffF58529),
                                            // Color(0xffFEDA77),
                                            Color(0xffDD2A7B),
                                            Color(0xff8134AF),
                                            Color(0xff515BD4)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          minHeight: 50.0, minWidth: 150),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(FontAwesomeIcons.instagram),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              "Instagram",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 50.0,
                                child: RaisedButton(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  onPressed: () async {
                                    var url =
                                        (snapshot.data! as Map)["register"];
                                    if (await UrlLauncher.canLaunch(url)) {
                                      await UrlLauncher.launch(url,
                                          universalLinksOnly: true,
                                          forceSafariVC: false,
                                          forceWebView: false);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff5151E5),
                                            Color(0xff72EDF2),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          minHeight: 50.0, minWidth: 150),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.description),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              "Register",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
