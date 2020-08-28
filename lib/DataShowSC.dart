import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DataShowSC extends StatelessWidget {
  String name;
  List data;
  DataShowSC({this.name, this.data});
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
        body: DataShowSCStf(name: name, data: data),
      ),
    );
  }
}

class DataShowSCStf extends StatefulWidget {
  String name;
  List data;

  DataShowSCStf({this.name, this.data});
  @override
  _DataShowSCStfState createState() => _DataShowSCStfState();
}

class _DataShowSCStfState extends State<DataShowSCStf> {
  String article;
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                  FirebaseImage("gs://manipallocals-2f95e.appspot.com/"+widget.name.replaceAll(new RegExp(r"\s+"), "")+".png"),
                ),
              ),
            /*  Container(//height: MediaQuery.of(context).size.height * 0.3,
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
              ),*/
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
              style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }
}
