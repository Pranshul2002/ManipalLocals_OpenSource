import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final double? height, width;
  final String? url;
  final String? credit;
  ImageContainer({this.height, this.width, this.url, this.credit});

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              CachedNetworkImage(
                imageUrl: url!,
              ),
              if (credit != "null")
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Image Credit: " + credit!,
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: GestureDetector(
        onTap: () {
          _showMyDialog(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
