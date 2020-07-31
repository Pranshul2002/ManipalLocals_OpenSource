import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HostelMess extends StatelessWidget {
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
          backgroundColor: Color(0xffFF9609),
          title: Text(
            "HOSTEL/MESS",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: HostelMess(),
      ),
    );
  }
}
class HostelMessBody extends StatefulWidget {
  @override
  _HostelMessBodyState createState() => _HostelMessBodyState();
}

class _HostelMessBodyState extends State<HostelMessBody> {
  String url = "null";



  @override
  Widget build(BuildContext context) {
return ListView();
  }
}
