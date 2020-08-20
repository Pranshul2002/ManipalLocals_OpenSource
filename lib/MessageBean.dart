import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBean with ChangeNotifier {
  String _head;
  String _body;
  String _pdf_included;

  String get head => _head;

  set head(String val) {
    _head = val;
    notifyListeners();
  }

  String get body => _body;

  set body(String val) {
    _body = val;
    notifyListeners();
  }

  String get pdf_included => _pdf_included;

  set pdf_included(String val) {
    _pdf_included = val;
    notifyListeners();
  }

  MessageBean input_data(Map<String, dynamic> message) {
    this.head = message["data"]["head"];
    this.body = message["data"]["body"];
    this.pdf_included = message["data"]["pdf_included"];
    update_data();
  }

  update_data() async {
    final fire = Firestore.instance;
    await fire
        .collection("notification")
        .document("MbVRBNqnOSwu0n5aAZQl")
        .get()
        .then((DocumentSnapshot ds) async {
      List head = new List();
      List head1 = ds.data["head"];
      head.add(this.head);
      head = head + head1;
      List body = new List();
      List body1 = ds.data["body"];
      body.add(this.body);
      body = body + body1;
      List pdf_included = new List();
      List pdf_included1 = ds.data["pdf_included"];
      pdf_included.add(this.pdf_included);
      pdf_included = pdf_included + pdf_included1;
      await fire
          .collection("notification")
          .document("MbVRBNqnOSwu0n5aAZQl")
          .setData({"head": head, "body": body, "pdf_included": pdf_included});
    });
  }
}
