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
  }
}
