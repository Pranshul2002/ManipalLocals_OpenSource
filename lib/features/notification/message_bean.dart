import 'package:flutter/material.dart';

class MessageBean with ChangeNotifier {
  String? head;
  String? body;

  MessageBean();

  String? pdfIncluded;

  MessageBean.fromJson(Map<String, dynamic> message)
      : this.head = message["data"]["head"],
        this.body = message["data"]["body"],
        this.pdfIncluded = message["data"]["pdf_included"];
}
