import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manipal_locals/HomePage.dart';

class AnswerShow extends StatelessWidget {
  String name;
  String data;
  int index;
  AnswerShow({this.name, this.data, this.index});
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
        ),
        body: AnswerShowStf(
          name: name,
          data: data,
          index: index,
        ),
      ),
    );
  }
}

class AnswerShowStf extends StatefulWidget {
  String name;
  String data;
  int index;
  AnswerShowStf({this.name, this.data, this.index});
  @override
  _AnswerShowStfState createState() => _AnswerShowStfState();
}

class _AnswerShowStfState extends State<AnswerShowStf> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      HomePageState.faqtab = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 8.0, left: 33.0, right: 33.0),
          child: Text(
            widget.name,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 33.0, right: 33.0, top: 16.0),
          child: Text(
            widget.data,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
