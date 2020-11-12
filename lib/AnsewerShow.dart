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
            body: AnswerShowStf(
              name: name,
              data: data,
              index: index,
            ),
          ),
        ],
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
                fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
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
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
