import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manipal_locals/utils/widget.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _showMyDialog(BuildContext context, String? url) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            Image(
                image: NetworkImage(Convert.convertString(url!)),
                fit: BoxFit.fill),
          ],
        )),
      );
    },
  );
}

Widget getWidget(String? article, DocumentSnapshot? ds, BuildContext context) {
  if (article == "club_image1") {
    return GestureDetector(
      onTap: () {
        _showMyDialog(
          context,
          ds!["club_image1"],
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        child: CircleAvatar(
          backgroundImage:
              NetworkImage(Convert.convertString(ds!["club_image1"])),
          radius: 70.0,
        ),
      ),
    );
  }
  if (article == "club_image2") {
    return GestureDetector(
      onTap: () {
        _showMyDialog(
          context,
          ds!["club_image2"],
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.centerRight,
        child: CircleAvatar(
          backgroundImage:
              NetworkImage(Convert.convertString(ds!["club_image2"])),
          radius: 70.0,
        ),
      ),
    );
  }
  if (article == "club_image3") {
    return GestureDetector(
      onTap: () async {
        var url = ds!["video_url"];
        if (await canLaunch(url)) {
          await launch(url,
              universalLinksOnly: true,
              forceSafariVC: false,
              forceWebView: false);
        }
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(Convert.convertString(ds!["club_image3"])),
              radius: 70.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.center,
              height: 140,
              width: 140,
              child: Icon(
                Icons.play_arrow,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(left: 33.0, right: 33.0),
      child: Text(
        article!,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
