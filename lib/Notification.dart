import 'package:flutter/material.dart';

import 'MessageBean.dart';
class NotificationPage extends StatefulWidget {
  @override
  NotificationPageState createState() => NotificationPageState();
  static MessageBean item ;

}

class NotificationPageState extends State<NotificationPage> {
  static MessageBean items = new MessageBean();

  @override
  void initState() {
    super.initState();
  }

  Widget NewNotification() {
    try {
      NotificationPage.item.addListener(() {
        if (mounted) {
          setState(() {
            items = NotificationPage.item;
            print(items);
          });
        }
      });
    } catch (e) {
      print(e);
    }
    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        color: Colors.transparent,
        shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: items.head != null
                    ? Text(items.head)
                    : Text("No new notifications"),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: items.body != null ? Text(items.body) : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [NewNotification()],
    );
  }
}



