import 'package:flutter/material.dart';

import 'message_bean.dart';
import 'notification_widgets.dart';

class NotificationPage extends StatelessWidget {
  final MessageBean? item;
  NotificationPage({this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        newNotification(item, context),
        SizedBox(
          height: 25,
        ),
        bottomPart()
      ],
    );
  }
}
