import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manipal_locals/College.dart';
import 'package:manipal_locals/Directory.dart';
import 'package:manipal_locals/GetARide.dart';
import 'package:manipal_locals/HostelMess.dart';
import 'package:manipal_locals/Notification.dart';
import 'package:manipal_locals/PlacesToVisit.dart';
import 'package:manipal_locals/StudentClubs.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'MessageBean.dart';
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

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
        try{
          setState(() {
            messageBean.input_data(message);
            selectedIndex = 2;

          });
        }catch(e){
          print(e);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        try{
          setState(() {
            messageBean.input_data(message);
            selectedIndex = 2;
          });
        }catch(e){
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
    }
    catch (e) {
      print(e);
    }
  }
final list = [
  TopPart(),
  Text("Coming Soon"),
  NotificationPage(),
];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          canvasColor: Colors.black,
          brightness: Brightness.dark,
          fontFamily: "banglamn"),
      home: SafeArea(
        child: Scaffold(
          appBar: (selectedIndex == 2)?  AppBar(backgroundColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Notifications",style: TextStyle(fontSize: 22),),
            ),
          ) : null,
          drawer: Drawer(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        height:
                            MediaQuery.of(context).size.height * 0.206756757,
                        child: Container(
                          color: Color(0xff1E1E1E),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      height: 80,
                                      width: 80,
                                      color: Colors.white,
                                      child:Image.asset("assets/images/logo_drawer.png"),
                                    ),
                                    borderRadius: BorderRadius.circular(66.0),
                                  ),
                                SizedBox(height: 16.0,),
                                Container(
                                  child: Text("MANIPAL LOCALS",style: TextStyle(fontSize: 20.0),),
                                )
                                ],

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Developers" , style: TextStyle(fontSize: 16.0),)),
                    Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Privacy Policy" , style: TextStyle(fontSize: 16.0),)),
                    Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text("About Us" , style: TextStyle(fontSize: 16.0),)),
                    SizedBox(height: 45,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Icon(Icons.people , size: 28.0,),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 35.0),
                            child: Text("Connect with Us:" , style: TextStyle(fontSize: 20.0),)
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var url = 'https://www.instagram.com/instagram/';
                            if(await UrlLauncher.canLaunch(url))
                              {await UrlLauncher.launch(url,universalLinksOnly: true,forceSafariVC: false, forceWebView: false);
                              }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/instagram.png" , height: 25.0,width: 25.0,),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final Uri params = Uri(
                              scheme: 'mailto',
                              path: 'pranshul20162002@gmail.com',
                              query: '',
                            );
                            var url = params.toString();
                            if(await UrlLauncher.canLaunch(url))
                            {await UrlLauncher.launch(url,universalLinksOnly: true,forceSafariVC: false, forceWebView: false);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/gmail.png" , height: 25.0,width: 25.0,),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              var url = 'https://twitter.com/PMOIndia';
                              if(await UrlLauncher.canLaunch(url))
                              {await UrlLauncher.launch(url,universalLinksOnly: true,forceSafariVC: false, forceWebView: false);
                              }
                            },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/twitter.png" , height: 25.0,width: 25.0,),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              var url = 'https://chat.whatsapp.com/JLCOqP7SWCH2dwE67xJNLr';
                              if(await UrlLauncher.canLaunch(url))
                              {await UrlLauncher.launch(url,universalLinksOnly: true,forceSafariVC: false, forceWebView: false);
                              }
                            },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/whatsapp.png" , height: 25.0,width: 25.0,),
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff1e1e1e),

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('SLCM')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), title: Text('Notifications')),
            ],
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.shifting,
            fixedColor: Color.fromRGBO(255, 150, 9, 1.0),
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }
}




class TopPart extends StatelessWidget {
  double iconsize = 33;
  double fontsize = 13;
  double buttonsize = 70;
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
                  Icons.format_list_bulleted,
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
                  left: 35.0, right: 35.0, top: 35.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => College()));
                        },
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff1e1e1e),
                        constraints: BoxConstraints(
                            minWidth: buttonsize, minHeight: buttonsize),
                        child: Center(
                            child: Icon(
                          Icons.school,
                          size: iconsize,
                          color: Colors.white,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "COLLEGE",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        RawMaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HostelMess()));
                            },
                            elevation: 2.0,
                            shape: CircleBorder(),
                            fillColor: Color(0xff1e1e1e),
                            constraints: BoxConstraints(
                                minWidth: buttonsize, minHeight: buttonsize),
                            child: Center(
                                child: Icon(
                              Icons.fastfood,
                              size: iconsize,
                              color: Colors.white,
                            ))),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "HOSTEL/MESS",
                            style: TextStyle(
                                color: Colors.white, fontSize: fontsize),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                          onPressed: () {
                           UrlLauncher.launch("https://goo.gl/maps/FxYbhvJQzXoSrS6E8");
                          },
                          elevation: 2.0,
                          shape: CircleBorder(),
                          fillColor: Color(0xff1e1e1e),
                          constraints: BoxConstraints(
                              minWidth: buttonsize, minHeight: buttonsize),
                          child: Center(
                              child: Icon(Icons.explore,
                                  size: iconsize, color: Colors.white))),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "MAPS",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 20.0, bottom: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Directory()));
                          },
                          elevation: 2.0,
                          shape: CircleBorder(),
                          fillColor: Color(0xff1e1e1e),
                          constraints: BoxConstraints(
                              minWidth: buttonsize, minHeight: buttonsize),
                          child: Center(
                              child: Icon(
                            Icons.library_books,
                            size: iconsize,
                            color: Colors.white,
                          ))),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "DIRECTORY",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        RawMaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Get_A_Ride()));
                            },
                            elevation: 2.0,
                            shape: CircleBorder(),
                            fillColor: Color(0xff1e1e1e),
                            constraints: BoxConstraints(
                                minWidth: buttonsize, minHeight: buttonsize),
                            child: Center(
                                child: Icon(
                              Icons.local_taxi,
                              size: iconsize,
                              color: Colors.white,
                            ))),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "GET A RIDE",
                            style: TextStyle(
                                color: Colors.white, fontSize: fontsize),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "",
                            style: TextStyle(
                                color: Colors.white, fontSize: fontsize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        child: Center(
                            child: Icon(
                          Icons.store,
                          size: iconsize,
                          color: Colors.white,
                        )),
                        onPressed: () {},
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff1e1e1e),
                        constraints: BoxConstraints(
                            minWidth: buttonsize, minHeight: buttonsize),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "STORES",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                    ],
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

                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PlacesToVisit()));
                        },
                        child: Center(
                            child: Icon(
                          Icons.directions,
                          size: iconsize,
                          color: Colors.white,
                        )),
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff1e1e1e),
                        constraints: BoxConstraints(
                            minWidth: buttonsize, minHeight: buttonsize),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "PLACES",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "TO VISIT",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => StudentClubs()));
                          },
                          child: Center(
                              child: Icon(
                            Icons.people,
                            size: iconsize,
                            color: Colors.white,
                          )),
                          elevation: 2.0,
                          shape: CircleBorder(),
                          fillColor: Color(0xff1e1e1e),
                          constraints: BoxConstraints(
                              minWidth: buttonsize, minHeight: buttonsize),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "STUDENT",
                            style: TextStyle(
                                color: Colors.white, fontSize: fontsize),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "CLUBS",
                            style: TextStyle(
                                color: Colors.white, fontSize: fontsize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        child: Center(
                            child: Icon(
                              Icons.question_answer,
                              size: iconsize,
                              color: Colors.white,
                            )),
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff1e1e1e),
                        constraints: BoxConstraints(
                            minWidth: buttonsize, minHeight: buttonsize),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "FAQs",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "",
                          style: TextStyle(
                              color: Colors.white, fontSize: fontsize),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}
