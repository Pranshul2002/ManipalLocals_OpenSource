import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DataShow extends StatelessWidget {
  String name;
  List data;
  DataShow({this.name, this.data});
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
            body: DataShowStf(name: name, data: data),
          ),
        ],
      ),
    );
  }
}

class DataShowStf extends StatefulWidget {
  String name;
  List data;

  DataShowStf({this.name, this.data});
  @override
  _DataShowStfState createState() => _DataShowStfState();
}

class _DataShowStfState extends State<DataShowStf> {
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
                fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic),
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
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
