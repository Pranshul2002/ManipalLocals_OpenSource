import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/bloc/home_page/home_page_bloc.dart';
import 'package:manipal_locals/features/collegepage/college_page.dart';
import 'package:manipal_locals/features/directorypage/directory.dart';
import 'package:manipal_locals/features/faqpage/faq_page.dart';
import 'package:manipal_locals/features/feedpage/feed_page.dart';
import 'package:manipal_locals/features/getaride/get_a_ride.dart';
import 'package:manipal_locals/features/hostelmess/hostel_mess.dart';
import 'package:manipal_locals/features/placestovisit/places_to_visit.dart';
import 'package:manipal_locals/features/studentclubpage/student_club.dart';
import 'package:manipal_locals/utils/widget.dart';

import 'home_page_widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomePageBloc>(
        create: (_) => HomePageBloc()..add(HomePageInit(context)),
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoading)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            if (state is HomePageLoaded)
              return SafeArea(
                child: Stack(
                  children: [
                    background(state.height, state.width),
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: (state.selectedIndex == 2)
                          ? homePageAppBar(context) as PreferredSizeWidget?
                          : null,
                      drawer: homePageDrawer(state, context),
                      body: state.list[state.selectedIndex],
                      bottomNavigationBar: homePageBottom(context, state),
                    ),
                  ],
                ),
              );
            else
              return Center(
                child: Text("Something went wrong......"),
              );
          },
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
        StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("admin")
                .doc("0vDUGmlw9d3eZky9rzm6")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Fluttertoast.showToast(
                    msg: "Error: ${snapshot.error}",
                    toastLength: Toast.LENGTH_SHORT);
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ));
              }
              return Expanded(
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
                            if (snapshot.data!["permissions"]["college"])
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => College(),
                                    settings: RouteSettings(
                                        name: "/HomePage/College")),
                              );
                            else
                              BlocProvider.of<HomePageBloc>(context)
                                  .add(HomePageComingSoon());
                          },
                        ),
                        Expanded(
                          child: homeButton(
                              title1: 'hostel/mess'.toUpperCase(),
                              title2: '',
                              icon: Icons.fastfood,
                              onPressed: () {
                                if (snapshot.data!["permissions"]
                                    ["hostel_mess"])
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HostelMess(),
                                          settings: RouteSettings(
                                              name: "/HomePage/HostelMess")));
                                else
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(HomePageComingSoon());
                              }),
                        ),
                        homeButton(
                          title1: 'maps'.toUpperCase(),
                          title2: '',
                          icon: Icons.explore,
                          onPressed: () {
                            if (snapshot.data!["permissions"]["map"])
                              BlocProvider.of<HomePageBloc>(context)
                                  .add(HomePageMap());
                            else
                              BlocProvider.of<HomePageBloc>(context)
                                  .add(HomePageComingSoon());
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
                            if (snapshot.data!["permissions"]["directory"])
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Directory(),
                                      settings: RouteSettings(
                                          name: "/HomePage/Directory")));
                            else
                              BlocProvider.of<HomePageBloc>(context)
                                  .add(HomePageComingSoon());
                          },
                        ),
                        Expanded(
                          child: homeButton(
                              title1: 'get a ride'.toUpperCase(),
                              title2: '',
                              icon: Icons.local_taxi,
                              onPressed: () {
                                if (snapshot.data!["permissions"]["get_a_ride"])
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => GetARide(),
                                          settings: RouteSettings(
                                              name: "/HomePage/GetARide")));
                                else
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(HomePageComingSoon());
                              }),
                        ),
                        homeButton(
                          title1: 'student'.toUpperCase(),
                          title2: 'clubs'.toUpperCase(),
                          icon: Icons.people_sharp,
                          onPressed: () {
                            if (snapshot.data!["permissions"]["student_clubs"])
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<HomePageBloc>(
                                              context),
                                          child: StudentClub()),
                                      settings: RouteSettings(
                                          name: "/HomePage/StudentClubs")));
                            else
                              BlocProvider.of<HomePageBloc>(context)
                                  .add(HomePageComingSoon());
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
                              if (snapshot.data!["permissions"]
                                  ["places_to_visit"])
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PlacesToVisit(),
                                        settings: RouteSettings(
                                            name: "/HomePage/PlacesToVisit")));
                              else
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(HomePageComingSoon());
                            }),
                        Expanded(
                          child: homeButton(
                              title1: 'feed'.toUpperCase(),
                              title2: '',
                              icon: Icons.article,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Feed(),
                                        settings: RouteSettings(
                                            name: "/HomePage/Feed")));
                              }),
                        ),
                        homeButton(
                            title2: '',
                            title1: 'FAQs',
                            icon: Icons.question_answer,
                            onPressed: () {
                              if (snapshot.data!["permissions"]["faq"])
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                            value:
                                                BlocProvider.of<HomePageBloc>(
                                                    context),
                                            child: Faq()),
                                        settings: RouteSettings(
                                            name: "/HomePage/Faq")));
                              else
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(HomePageComingSoon());
                            }),
                      ],
                    ),
                  ),
                ],
              ));
            })
      ],
    );
  }
}
