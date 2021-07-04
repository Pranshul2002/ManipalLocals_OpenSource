import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipal_locals/bloc/home_page/home_page_bloc.dart';

import 'home_page_constants.dart';

Widget homePageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "Notifications",
        style: TextStyle(fontSize: 22),
      ),
    ),
  );
}

Widget showBottomSheetWidget() {
  return Container(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "About Us",
                    style: TextStyle(
                        fontFamily: "banglamn",
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    aboutUsContent,
                    style: TextStyle(
                        fontFamily: "banglamn",
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
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0))),
  );
}

Widget homePageDrawer(HomePageLoaded state, BuildContext context) {
  return Drawer(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                height: state.height * 0.206756757,
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
              onTap: () => BlocProvider.of<HomePageBloc>(context)
                  .add(HomePageFeedback()),
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
                    context: context, applicationName: "ManipalLocals");
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
                    builder: (BuildContext bc) => showBottomSheetWidget());
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
                  onTap: () {
                    BlocProvider.of<HomePageBloc>(context)
                        .add(HomePageInstagram());
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
                  onTap: () => BlocProvider.of<HomePageBloc>(context)
                      .add(HomePageMail()),
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
                  onTap: () => BlocProvider.of<HomePageBloc>(context)
                      .add(HomePageTwitter()),
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
                  onTap: () => BlocProvider.of<HomePageBloc>(context)
                      .add(HomePageWhatsApp()),
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
        SizedBox(
          height: 30.0,
        ),
      ],
    ),
  );
}

Widget homeButton(
    {required String title1, required String title2, IconData? icon, Function? onPressed}) {
  return Column(
    children: [
      RawMaterialButton(
        onPressed: onPressed as void Function()?,
        elevation: 2.0,
        shape: CircleBorder(),
        fillColor: Color(0xff1e1e1e),
        constraints:
            BoxConstraints(minWidth: buttonSize, minHeight: buttonSize),
        child: Center(
            child: Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        )),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          title1,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          title2,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    ],
  );
}

Widget homePageBottom(BuildContext context, HomePageLoaded state) {
  return Theme(
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
      currentIndex: state.selectedIndex,
      type: BottomNavigationBarType.shifting,
      fixedColor: Colors.orangeAccent.shade700,
      onTap: (val) {
        BlocProvider.of<HomePageBloc>(context)
            .add(HomePageChangeBottom(state, val));
      },
    ),
  );
}
