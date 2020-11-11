import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'HomePage.dart';

class ClubContent extends StatefulWidget {
  AsyncSnapshot<DocumentSnapshot> ds;
  String name;
  int index;
  ClubContent(this.ds, this.name, this.index);

  @override
  _ClubContentState createState() => _ClubContentState();
}

class _ClubContentState extends State<ClubContent> {
  Future<void> _showMyDialog(BuildContext context, String url) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              Image(
                  image: FirebaseImage(
                    url,
                  ),
                  fit: BoxFit.fill),
            ],
          )),
        );
      },
    );
  }

  Widget getWidget(String article) {
    if (article == "club_image1") {
      return GestureDetector(
        onTap: () {
          _showMyDialog(
            context,
            widget.ds.data["club_image1"][widget.name],
          );
        },
        child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image(
                  image: FirebaseImage(
                    widget.ds.data["club_image1"][widget.name],
                  ),
                  width: 200,
                  fit: BoxFit.fill),
            ),
            radius: 70.0,
          ),
        ),
      );
    }
    if (article == "club_image2") {
      return GestureDetector(
        onTap: () {
          _showMyDialog(
            context,
            widget.ds.data["club_image2"][widget.name],
          );
        },
        child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image(
                  image: FirebaseImage(
                    widget.ds.data["club_image2"][widget.name],
                  ),
                  width: 200,
                  fit: BoxFit.fill),
            ),
            radius: 70.0,
          ),
        ),
      );
    }
    if (article == "club_image3") {
      return GestureDetector(
        onTap: () async {
          var url = widget.ds.data["video_url"][widget.name];
          if (await UrlLauncher.canLaunch(url)) {
            await UrlLauncher.launch(url,
                universalLinksOnly: true,
                forceSafariVC: false,
                forceWebView: false);
          }
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image(
                      image: FirebaseImage(
                        widget.ds.data["club_image3"][widget.name],
                      ),
                      width: 200,
                      fit: BoxFit.fill),
                ),
                radius: 70.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.center,
                height: 140,
                width: 140,
                child: Icon(
                  Icons.play_arrow,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 33.0, right: 33.0),
        child: Text(
          article,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      HomePageState.selectedtab = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image(
            image: FirebaseImage(
              widget.ds.data["club_icon"][widget.name],
            ),
            height: 300,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ), //club logo
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff1e1e1e),
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: ListView(
                children: [
                  for (String article in widget.ds.data[widget.name])
                    getWidget(article),
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
                              var url = widget.ds.data["insta"][widget.name];
                              if (await UrlLauncher.canLaunch(url)) {
                                await UrlLauncher.launch(url,
                                    universalLinksOnly: true,
                                    forceSafariVC: false,
                                    forceWebView: false);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 50.0, minWidth: 150),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              var url = widget.ds.data["register"][widget.name];
                              if (await UrlLauncher.canLaunch(url)) {
                                await UrlLauncher.launch(url,
                                    universalLinksOnly: true,
                                    forceSafariVC: false,
                                    forceWebView: false);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
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
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 50.0, minWidth: 150),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
  }
}
