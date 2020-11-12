import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:manipal_locals/StudentClub.dart';
import 'College.dart';
import 'Directory.dart';
import 'FAQ.dart';
import 'Gallery/gallery_screen.dart';
import 'GetARide.dart';
import 'HostelMess.dart';
import 'Notification.dart';
import 'PlacesToVisit.dart';
import 'Feed.dart';
import 'MessageBean.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 1;
  static int selectedtab = 0;
  static int faqtab = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  FirebaseMessaging _firebaseMessaging;
  MessageBean messageBean = new MessageBean();
  static bool newNotification = false;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        setState(() {
          newNotification = true;
          messageBean.input_data(message);
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        try {
          setState(() {
            messageBean.input_data(message);
            selectedIndex = 2;
          });
        } catch (e) {
          print(e);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        try {
          setState(() {
            messageBean.input_data(message);
            selectedIndex = 2;
          });
        } catch (e) {
          print(e);
        }
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  void initState() {
    setUpFirebase();
    super.initState();
    NotificationPage.item = messageBean;

    try {
      NotificationPage.item.addListener(() {
        setState(() {
          NotificationPageState.items = NotificationPage.item;
          print(NotificationPageState.items);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  final list = [
    GalleryScreen(),
    TopPart(),
    NotificationPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.black,
          brightness: Brightness.dark,
          fontFamily: "banglamn"),
      home: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/ML_doodles.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: (selectedIndex == 2)
                  ? AppBar(
                      backgroundColor: Colors.transparent,
                      leading: Builder(
                        builder: (context) => Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            child: Icon(
                              Icons.menu,
                              size: 33,
                            ),
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Notifications",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    )
                  : null,
              drawer: Drawer(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height *
                                0.206756757,
                            child: Container(
                              color: Colors.black,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Image.asset(
                                        "assets/images/ml_drawer.png",
                                        fit: BoxFit.fitWidth,
                                      ))
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
                      height: 30.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Firestore.instance
                                .collection("SideBar")
                                .document("24gilAUR9c7Mp96RtBAg")
                                .get()
                                .then((DocumentSnapshot ds) async {
                              if (ds.data["feedback"] != "null") {
                                var url = ds.data["feedback"];
                                if (await UrlLauncher.canLaunch(url)) {
                                  await UrlLauncher.launch(url,
                                      universalLinksOnly: true,
                                      forceSafariVC: false,
                                      forceWebView: false);
                                }
                              }
                            });
                            // showModalBottomSheet<void>(
                            //     backgroundColor: Colors.transparent,
                            //     context: context,
                            //     builder: (BuildContext bc) => Container(
                            //           child: Padding(
                            //             padding: EdgeInsets.only(
                            //               left: 20.0,
                            //               top: 32.0,
                            //               bottom: 16.0,
                            //             ),
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Row(
                            //                   mainAxisSize: MainAxisSize.max,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.spaceBetween,
                            //                   children: [
                            //                     CircleAvatar(
                            //                       radius: 35,
                            //                       child: ClipRRect(
                            //                           borderRadius:
                            //                               BorderRadius.circular(35),
                            //                           child: Image.asset(
                            //                             "assets/images/Pranshul.png",
                            //                             fit: BoxFit.cover,
                            //                           )),
                            //                       backgroundColor: Colors.black,
                            //                     ),
                            //                     Column(
                            //                         mainAxisSize: MainAxisSize.min,
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment.center,
                            //                         children: [
                            //                           Text(
                            //                             "Pranshul Goyal",
                            //                             style: TextStyle(
                            //                                 fontFamily: "banglamn",
                            //                                 fontSize: 20,
                            //                                 color: Colors.white),
                            //                           ),
                            //                           SizedBox(
                            //                             height: 2,
                            //                           ),
                            //                           //    Text("Head Developer",style: TextStyle(fontSize: 15,fontFamily: "banglamn",color: Colors.white),),
                            //                         ]),
                            //                     Container(
                            //                       alignment: Alignment.topCenter,
                            //                       padding:
                            //                           EdgeInsets.only(right: 64),
                            //                       child: GestureDetector(
                            //                         onTap: () async {
                            //                           var url =
                            //                               'https://www.instagram.com/pranshul_2002/';
                            //                           if (await UrlLauncher
                            //                               .canLaunch(url)) {
                            //                             await UrlLauncher.launch(
                            //                                 url,
                            //                                 universalLinksOnly:
                            //                                     true,
                            //                                 forceSafariVC: false,
                            //                                 forceWebView: false);
                            //                           }
                            //                         },
                            //                         child: Icon(
                            //                           FontAwesomeIcons.instagram,
                            //                           color: Colors.white,
                            //                           size: 20,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 SizedBox(
                            //                   height: 16.0,
                            //                 ),
                            //                 Row(
                            //                   mainAxisSize: MainAxisSize.max,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.spaceBetween,
                            //                   children: [
                            //                     CircleAvatar(
                            //                       radius: 35,
                            //                       backgroundColor: Colors.black,
                            //                       child: ClipRRect(
                            //                           borderRadius:
                            //                               BorderRadius.circular(35),
                            //                           child: Image.asset(
                            //                             "assets/images/vaibhav.png",
                            //                             fit: BoxFit.cover,
                            //                           )),
                            //                     ),
                            //                     Column(
                            //                         mainAxisSize: MainAxisSize.min,
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment.center,
                            //                         children: [
                            //                           Text(
                            //                             "Vaibhav Awasthi",
                            //                             style: TextStyle(
                            //                                 fontFamily: "banglamn",
                            //                                 fontSize: 20,
                            //                                 color: Colors.white),
                            //                           ),
                            //                           SizedBox(
                            //                             height: 2,
                            //                           ),
                            //                           //  Text("App Designer",style: TextStyle(fontSize: 15,fontFamily: "banglamn",color: Colors.white),),
                            //                         ]),
                            //                     Container(
                            //                       alignment: Alignment.topCenter,
                            //                       padding:
                            //                           EdgeInsets.only(right: 64),
                            //                       child: GestureDetector(
                            //                         onTap: () async {
                            //                           var url =
                            //                               'https://www.instagram.com/_vaibhavawasthi_/';
                            //                           if (await UrlLauncher
                            //                               .canLaunch(url)) {
                            //                             await UrlLauncher.launch(
                            //                                 url,
                            //                                 universalLinksOnly:
                            //                                     true,
                            //                                 forceSafariVC: false,
                            //                                 forceWebView: false);
                            //                           }
                            //                         },
                            //                         child: Icon(
                            //                           FontAwesomeIcons.instagram,
                            //                           color: Colors.white,
                            //                           size: 20,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 SizedBox(
                            //                   height: 16.0,
                            //                 ),
                            // Row(  mainAxisSize: MainAxisSize.max,
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     CircleAvatar(radius: 35,
                            //       backgroundColor: Colors.black,child: ClipRRect(
                            //           borderRadius: BorderRadius.circular(35),
                            //           child: Image.asset("assets/images/kushagra.png",fit: BoxFit.cover,)),
                            //     ),
                            //     Column(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,children: [Text("Kushagra Garg",style: TextStyle(fontFamily: "banglamn",fontSize: 20,color: Colors.white),),SizedBox(height: 2,),Text("Data Manager",style: TextStyle(fontSize: 15,fontFamily: "banglamn",color: Colors.white),),]),
                            //     Container(
                            //
                            //       alignment: Alignment.topCenter,
                            //       padding: EdgeInsets.only(right: 64),
                            //       child: GestureDetector(onTap: ()
                            //       async {
                            //         var url = 'https://www.instagram.com/kushagra__garg/';
                            //         if(await UrlLauncher.canLaunch(url))
                            //         {await UrlLauncher.launch(url,universalLinksOnly: true,forceSafariVC: false, forceWebView: false);
                            //         }
                            //       },
                            //         child: Icon(FontAwesomeIcons.instagram,color: Colors.white,size: 20,),),
                            //     ),
                            //   ],
                            //
                            // ),
                            //       ],
                            //     ),
                            //   ),
                            //   decoration: new BoxDecoration(
                            //       color: Color(0xff3B3B3B),
                            //       borderRadius: new BorderRadius.only(
                            //           topLeft: const Radius.circular(40.0),
                            //           topRight:
                            //               const Radius.circular(40.0))),
                            // ));
                          },
                          child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Feedback",
                                style: TextStyle(fontSize: 16.0),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAboutDialog(
                                context: context,
                                applicationName: "ManipalLocals");
                          },
                          child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Licenses",
                                style: TextStyle(fontSize: 16.0),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext bc) => Container(
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: ListView(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(
                                                      "About Us",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "banglamn",
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(height: 16),
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(
                                                      "Honestly, it's tough moving to a new city, freshers start wondering about settling themselves and wonder why can't they find everything easily, that too from the right places near them. We made ManipalLocals just to make sure that our juniors don’t face the difficulties we did and also to make their life at Manipal easy and smooth.",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "banglamn",
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                          color: Color(0xff3B3B3B),
                                          borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(40.0),
                                              topRight:
                                                  const Radius.circular(40.0))),
                                    ));
                          },
                          child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "About Us",
                                style: TextStyle(fontSize: 16.0),
                              )),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Icon(
                                Icons.people,
                                size: 28.0,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 35.0),
                                child: Text(
                                  "Connect with Us:",
                                  style: TextStyle(fontSize: 20.0),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                var url =
                                    'https://www.instagram.com/manipallocals/';
                                if (await UrlLauncher.canLaunch(url)) {
                                  await UrlLauncher.launch(url,
                                      universalLinksOnly: true,
                                      forceSafariVC: false,
                                      forceWebView: false);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Image.asset(
                                  "assets/images/instagram.png",
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final Uri params = Uri(
                                  scheme: 'mailto',
                                  path: 'manipallocals@gmail.com',
                                  query: '',
                                );
                                var url = params.toString();
                                if (await UrlLauncher.canLaunch(url)) {
                                  await UrlLauncher.launch(url,
                                      universalLinksOnly: true,
                                      forceSafariVC: false,
                                      forceWebView: false);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Image.asset(
                                  "assets/images/gmail.png",
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                var url = 'https://twitter.com/LocalsManipal';
                                if (await UrlLauncher.canLaunch(url)) {
                                  await UrlLauncher.launch(url,
                                      universalLinksOnly: true,
                                      forceSafariVC: false,
                                      forceWebView: false);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Image.asset(
                                  "assets/images/twitter.png",
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Firestore.instance
                                    .collection("SideBar")
                                    .document("24gilAUR9c7Mp96RtBAg")
                                    .get()
                                    .then((DocumentSnapshot ds) async {
                                  if (ds.data["whatsapp"] != "null") {
                                    var url = ds.data["whatsapp"];
                                    if (await UrlLauncher.canLaunch(url)) {
                                      await UrlLauncher.launch(url,
                                          universalLinksOnly: true,
                                          forceSafariVC: false,
                                          forceWebView: false);
                                    }
                                  }
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Image.asset(
                                  "assets/images/whatsapp.png",
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              body: list[selectedIndex],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.collections),
                      label: 'Gallery',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark),
                      label: 'Notifications',
                    ),
                  ],
                  currentIndex: selectedIndex,
                  type: BottomNavigationBarType.shifting,
                  fixedColor: Colors.orangeAccent.shade700,
                  onTap: onItemTapped,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopPart extends StatelessWidget {
  double iconsize = 33;
  double fontsize = 13;
  double buttonsize = 70;

  Widget homeButton(
      {String title1, String title2, IconData icon, Function onPressed}) {
    return Column(
      children: [
        RawMaterialButton(
          onPressed: onPressed,
          elevation: 2.0,
          shape: CircleBorder(),
          fillColor: Color(0xff1e1e1e),
          constraints:
              BoxConstraints(minWidth: buttonsize, minHeight: buttonsize),
          child: Center(
              child: Icon(
            icon,
            size: iconsize,
            color: Colors.white,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title1,
            style: TextStyle(color: Colors.white, fontSize: fontsize),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title2,
            style: TextStyle(color: Colors.white, fontSize: fontsize),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/home_page.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.304054054,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: GestureDetector(
                child: Icon(
                  Icons.menu,
                  size: 33,
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
        ),
        Expanded(
            child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 35.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  homeButton(
                    title1: "college".toUpperCase(),
                    icon: Icons.school,
                    title2: '',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => College()));
                    },
                  ),
                  Expanded(
                    child: homeButton(
                      title1: 'hostel/mess'.toUpperCase(),
                      title2: '',
                      icon: Icons.fastfood,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => HostelMess()));
                      },
                    ),
                  ),
                  homeButton(
                    title1: 'maps'.toUpperCase(),
                    title2: '',
                    icon: Icons.explore,
                    onPressed: () {
                      UrlLauncher.launch(
                          "https://goo.gl/maps/xBGTvCw7SwaUvvya8");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  homeButton(
                    title1: 'directory'.toUpperCase(),
                    title2: '',
                    icon: Icons.library_books,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Directory()));
                    },
                  ),
                  Expanded(
                    child: homeButton(
                        title1: 'get a ride'.toUpperCase(),
                        title2: '',
                        icon: Icons.local_taxi,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Get_A_Ride()));
                        }),
                  ),
                  homeButton(
                    title1: 'student'.toUpperCase(),
                    title2: 'clubs'.toUpperCase(),
                    icon: Icons.people_sharp,
                    onPressed: () {
                      // Fluttertoast.showToast(
                      // msg: "Coming Soon!",
                      // backgroundColor: Colors.grey,
                      // toastLength: Toast.LENGTH_SHORT,
                      // textColor: Colors.white);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StudentClub()));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 10.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  homeButton(
                      title2: 'to visit'.toUpperCase(),
                      title1: 'places'.toUpperCase(),
                      icon: Icons.directions,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PlacesToVisit()));
                      }),
                  Expanded(
                    child: homeButton(
                        title1: 'feed'.toUpperCase(),
                        title2: '',
                        icon: Icons.article,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Feed()));
                        }),
                  ),
                  homeButton(
                      title2: '',
                      title1: 'FAQs',
                      icon: Icons.question_answer,
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Faq()));
                      }),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}
