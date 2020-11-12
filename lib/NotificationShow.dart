import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NotificationShow extends StatelessWidget {
  String name;
  String data;
  List url;
  NotificationShow({this.name, this.data, this.url});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: NotificationShowStf(name: name, data: data, url: url),
          ),
        ],
      ),
    );
  }
}

class NotificationShowStf extends StatefulWidget {
  String name;
  String data;
  List url;
  NotificationShowStf({this.name, this.data, this.url});
  @override
  _NotificationShowStfState createState() => _NotificationShowStfState();
}

class _NotificationShowStfState extends State<NotificationShowStf> {
  String article;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            widget.name,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 33.0, right: 33.0),
          child: Text(
            widget.data,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        if (widget.url != ["null"])
          for (String url in widget.url)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: FirebaseImage(url),
              ),
            )
      ],
    );
  }
}
