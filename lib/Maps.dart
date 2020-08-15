

import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';



class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
PDFDocument doc;
bool loading = true;
  @override
  void initState() {
    getpdf();
    super.initState();
  }

  getpdf()async{
    doc = await PDFDocument.fromAsset("assets/map.pdf");
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black,
              height: 3.0,
            ),
            preferredSize: Size.fromHeight(3.0)),
        backgroundColor: Color(0xffFF9609),
        title: Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "MAPS",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: loading
      ? Center(child: CircularProgressIndicator(
        valueColor:
        new AlwaysStoppedAnimation<Color>(Colors.white),
      ),)
      : PDFViewer(document: doc,
      showPicker: false,
      showIndicator: false,),

    );
  }
}
