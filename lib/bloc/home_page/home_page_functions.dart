import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/features/notification/message_bean.dart';
import 'package:manipal_locals/features/notification/notification_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page_bloc.dart';

Future<void> initNotifications(HomePageInit event) async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    try {
      MessageBean messageBean = MessageBean.fromJson(initialMessage.data);
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (_) => NotificationPage(
                    item: messageBean,
                  ),
              settings: RouteSettings(name: "/NotificationPage")));
    } catch (e) {
      print(e);
    }
  }

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage initialMessage) {
    if (initialMessage != null) {
      try {
        MessageBean messageBean = MessageBean.fromJson(initialMessage.data);
        Navigator.push(
            event.context,
            MaterialPageRoute(
                builder: (_) => NotificationPage(
                      item: messageBean,
                    ),
                settings: RouteSettings(name: "/NotificationPage")));
      } catch (e) {
        print(e);
      }
    }
  });
}

Future<void> homeFeedback(HomePageFeedback event) async {
  await FirebaseFirestore.instance
      .collection("SideBar")
      .doc("24gilAUR9c7Mp96RtBAg")
      .get()
      .then((DocumentSnapshot ds) async {
    if (ds["feedback"] != "null") {
      var url = ds["feedback"];

      if (await canLaunch(url)) {
        await launch(url,
            universalLinksOnly: true,
            forceSafariVC: false,
            forceWebView: false);
      } else {
        Fluttertoast.showToast(
            msg: "Cannot launch feedback",
            backgroundColor: Colors.grey,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white);
      }
    }
  });
}
