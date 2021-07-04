import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manipal_locals/utils/widget.dart';

class NotificationShow extends StatelessWidget {
  final String? name;
  final String? data;
  final List? url;
  NotificationShow({this.name, this.data, this.url});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          background(MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: NotificationShowStf(name: name, data: data, url: url),
          ),
        ],
      ),
    );
  }
}

class NotificationShowStf extends StatelessWidget {
  final String? name;
  final String? data;
  final List? url;
  NotificationShowStf({this.name, this.data, this.url});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 8.0),
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
          padding: const EdgeInsets.only(left: 33.0, right: 33.0),
          child: Text(
            data!,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        if (url != null)
          ListView.builder(
              shrinkWrap: true,
              itemCount: url!.length,
              itemBuilder: (context, int index) {
                if (url![index] != "null") {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                        imageUrl: Convert.convertString(url![index])),
                  );
                } else {
                  return SizedBox.shrink();
                }
              })
      ],
    );
  }
}
