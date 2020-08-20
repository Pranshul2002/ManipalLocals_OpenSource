import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'MessageBean.dart';
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
  static MessageBean item ;

}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
          NotificationPage.item != null ?
              Text(NotificationPage.item.head)
              : Text("No new notifications"),
        Text("hello")
      ],
    );
  }
}



