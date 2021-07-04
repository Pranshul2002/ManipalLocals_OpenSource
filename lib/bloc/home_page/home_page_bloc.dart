import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/bloc/home_page/home_page_functions.dart';
import 'package:manipal_locals/features/gallery/gallery_screen.dart';
import 'package:manipal_locals/features/homepage/home_page.dart';
import 'package:manipal_locals/features/notification/notification_page.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  int studentClubTabIndex = 0;
  int faqPageTabController = 0;
  HomePageBloc() : super(HomePageLoading());
  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is HomePageInit) {
      if (FirebaseAuth.instance.currentUser == null) {
        await FirebaseAuth.instance.signInAnonymously();
      }
      initNotifications(event);
      yield HomePageLoaded.name(MediaQuery.of(event.context).size.height,
          MediaQuery.of(event.context).size.width, 1);
    }
    if (event is HomePageFeedback) {
      homeFeedback(event);
    }
    if (event is HomePageInstagram) {
      var url = 'https://www.instagram.com/manipallocals/';
      if (await canLaunch(url)) {
        await launch(url,
            universalLinksOnly: true,
            forceSafariVC: false,
            forceWebView: false);
      }
    }

    if (event is HomePageMail) {
      final Uri params = Uri(
        scheme: 'mailto',
        path: 'manipallocals@gmail.com',
        query: '',
      );
      var url = params.toString();
      if (await canLaunch(url)) {
        await launch(url,
            universalLinksOnly: true,
            forceSafariVC: false,
            forceWebView: false);
      }
    }

    if (event is HomePageTwitter) {
      var url = 'https://twitter.com/LocalsManipal';
      if (await canLaunch(url)) {
        await launch(url,
            universalLinksOnly: true,
            forceSafariVC: false,
            forceWebView: false);
      }
    }

    if (event is HomePageWhatsApp) {
      await FirebaseFirestore.instance
          .collection("SideBar")
          .doc("24gilAUR9c7Mp96RtBAg")
          .get()
          .then((DocumentSnapshot ds) async {
        if (ds["whatsapp"] != "null") {
          var url = ds["whatsapp"];
          if (await canLaunch(url)) {
            await launch(url,
                universalLinksOnly: true,
                forceSafariVC: false,
                forceWebView: false);
          }
        }
      });
    }

    if (event is HomePageComingSoon) {
      Fluttertoast.showToast(
          msg: "Coming Soon!",
          backgroundColor: Colors.grey,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white);
    }
    if (event is HomePageMap) {
      var url = "https://goo.gl/maps/xBGTvCw7SwaUvvya8";
      if (await canLaunch(url)) {
        await launch(url,
            universalLinksOnly: true,
            forceSafariVC: false,
            forceWebView: false);
      }
    }

    if (event is HomePageChangeBottom) {
      yield HomePageLoaded.name(
          event.homePageLoaded.height, event.homePageLoaded.width, event.val);
    }

    if (event is HomePageChangeStudentClubTab) {
      studentClubTabIndex = event.tab;
    }

    if (event is HomePageChangeFAQTab) {
      faqPageTabController = event.tab;
    }
  }
}
