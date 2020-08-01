import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manipal_locals/College.dart';
import 'package:manipal_locals/GetARide.dart';
import 'package:manipal_locals/HostelMess.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final widgetOptions = [Text("Home"), Text("SLCM")];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: SafeArea(
        child: Scaffold(
          drawer: Drawer(),
          body: TopPart(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff737070),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('SLCM')),
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
                  size: 40,
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
        ),
        Expanded(child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => College()));
                        },
                        elevation: 2.0,
                          shape: CircleBorder(),
                        fillColor: Color(0xff737070),
                        constraints: BoxConstraints(minWidth: 84,minHeight: 84),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("COLLEGE",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      )
                    ],
                  ),
                  Expanded(
                    child:Column(
                      children: [
                        RawMaterialButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => HostelMess()));
                          },
                          elevation: 2.0,
                          shape: CircleBorder(),
                          fillColor: Color(0xff737070),
                          constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                            child: Center(child: Icon(Icons.fastfood,size: 50 , color: Colors.white,))
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("HOSTEL/MESS",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: (){},
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff737070),
                        constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                          child: Center(child: Icon(Icons.location_on,size:50, color: Colors.white))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("MAPS",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: (){},
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff737070),
                        constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("CAMPUS",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("STORES",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                    ],
                  ),
                  Expanded(
                    child:Column(
                      children: [
                        RawMaterialButton(
                          onPressed: (){},
                          elevation: 2.0,
                          shape: CircleBorder(),
                          fillColor: Color(0xff737070),
                          constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("DIRECTORY",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: (){},
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff737070),
                        constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("PLACES"
                           ,style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                            "TO VISIT",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => GetARide()));
                        },
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff737070),
                        constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("GET",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("A RIDE",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                    ],
                  ),
                  Expanded(
                    child:Column(
                      children: [
                        RawMaterialButton(
                          onPressed: (){},
                          elevation: 2.0,
                          shape: CircleBorder(),
                          fillColor: Color(0xff737070),
                          constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("FAQs",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("",style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: (){},
                        elevation: 2.0,
                        shape: CircleBorder(),
                        fillColor: Color(0xff737070),
                        constraints: BoxConstraints(minWidth: 84,minHeight: 84),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("STUDENT"
                            ,style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("CLUBS",style: TextStyle(color: Colors.white, fontSize: 16.0),),
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
