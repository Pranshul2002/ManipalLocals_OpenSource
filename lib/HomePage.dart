import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manipal_locals/College.dart';
import 'package:manipal_locals/Directory.dart';
import 'package:manipal_locals/GetARide.dart';
import 'package:manipal_locals/HostelMess.dart';
import 'package:manipal_locals/Maps.dart';
import 'package:manipal_locals/PushNotification.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseNotifications firebaseNotifications = new FirebaseNotifications();
  int selectedIndex = 0;
  final widgetOptions = [Text("Home"), Text("SLCM")];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    firebaseNotifications.setUpFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          canvasColor: Colors.black,
          brightness: Brightness.dark,
          fontFamily: "banglamn"),
      home: SafeArea(
        child: Scaffold(
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
                              {await UrlLauncher.launch(url,universalLinksOnly: true);
                              }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.asset("assets/images/instagram.png" , height: 25.0,width: 25.0,),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Image.asset("assets/images/facebook.png" , height: 25.0,width: 25.0,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Image.asset("assets/images/twitter.png" , height: 25.0,width: 25.0,),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Image.asset("assets/images/whatsapp.png" , height: 25.0,width: 25.0,),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          body: TopPart(),
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
                        onPressed: () {},
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
                          onPressed: () {},
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
