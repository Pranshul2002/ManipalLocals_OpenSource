import 'dart:async';

import 'package:flutter/material.dart';

import 'Notification.dart';

class MessageBean {
  String head;
  String body;
  String pdf_included;
  MessageBean input_data(Map<String,dynamic> message){
    this.head = message["data"]["head"];
    this.body = message["data"]["body"];
    this.pdf_included = message["data"]["pdf_included"];
  }
}
