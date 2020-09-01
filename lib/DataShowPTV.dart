import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DataShowPTV extends StatelessWidget {
  String name;
  List data;
  DataShowPTV({this.name, this.data});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black,
                height: 3.0,
              ),
              preferredSize: Size.fromHeight(3.0)),
          backgroundColor: Color(0xff00FFFFFF),
          title: Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Text(
    name.toUpperCase(),
    style: TextStyle(fontSize: 20, color: Colors.white),
    ),)
        ),
        body: DataShowPTVStf(name: name, data: data),
      ),
    );
  }
}

class DataShowPTVStf extends StatefulWidget {
  String name;
  List data;

  DataShowPTVStf({this.name, this.data});
  @override
  _DataShowPTVStfState createState() => _DataShowPTVStfState();
}

class _DataShowPTVStfState extends State<DataShowPTVStf> {
  String article;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
               // height: MediaQuery.of(context).size.height * 0.3,
                child: Image(
                  image:
                  FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+widget.name.replaceAll(new RegExp(r"\s+"), "")+"1.png"),
                ),
              ),
              Container(//height: MediaQuery.of(context).size.height * 0.3,
                child: Image(
                  image:
                  FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+widget.name.replaceAll(new RegExp(r"\s+"), "")+"2.png"),
                ),
              ),
              Container(//height: MediaQuery.of(context).size.height * 0.3,
                child: Image(
                  image:
                  FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+widget.name.replaceAll(new RegExp(r"\s+"), "")+"3.png"),
                ),
              ),
              Container(//height: MediaQuery.of(context).size.height * 0.3,
                child: Image(
                  image:
                  FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+widget.name.replaceAll(new RegExp(r"\s+"), "")+"4.png"),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 8.0,
        ),
        for (article in widget.data)
          Padding(
            padding: const EdgeInsets.only(left: 33.0, right: 33.0),
            child: Text(
              article,
              style: TextStyle(fontSize: 14,),
            ),
          ),
      ],
    );
  }
}
