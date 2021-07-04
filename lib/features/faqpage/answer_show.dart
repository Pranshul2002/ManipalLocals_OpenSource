import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnswerShow extends StatelessWidget {
  String? name;
  String? data;
  AnswerShow({this.name, this.data});
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
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerShowStf extends StatelessWidget {
  final String? name;
  final String? data;
  AnswerShowStf({this.name, this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 8.0, left: 33.0, right: 33.0),
          child: Text(
            name!,
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
            data!,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
