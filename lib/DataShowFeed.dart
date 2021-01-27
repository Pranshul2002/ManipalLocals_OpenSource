import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manipal_locals/MityMeal/Utils.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DataShowFeed extends StatelessWidget {
  String name;
  List data;

  DataShowFeed({this.name, this.data});
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
                title: Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    name.toUpperCase(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            body: DataShowFeedStf(
              name: name,
              data: data,
            ),
          ),
        ],
      ),
    );
  }
}

class DataShowFeedStf extends StatefulWidget {
  String name;
  List data;

  DataShowFeedStf({this.name, this.data});
  @override
  _DataShowFeedStfState createState() => _DataShowFeedStfState();
}

class _DataShowFeedStfState extends State<DataShowFeedStf> {
  String article;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: NetworkImage(Convert.convertString(
                  "gs://manipallocals-2f95e.appspot.com/" +
                      widget.name.replaceAll(new RegExp(r"\s+"), "") +
                      ".png")),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        for (article in widget.data)
          Padding(
            padding: const EdgeInsets.only(left: 33.0, right: 33.0),
            child: Text(
              article,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
