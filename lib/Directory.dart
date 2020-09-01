import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Directory extends StatelessWidget {
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
        backgroundColor: Color(0xffFF8C00),
        title: Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "DIRECTORY",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: DirectoryStateful(),
    );
  }
}

class DirectoryStateful extends StatefulWidget {
  @override
  _DirectoryStatefulState createState() => _DirectoryStatefulState();
}

class _DirectoryStatefulState extends State<DirectoryStateful> {
  final global = GlobalKey();
  Widget custom(List contacts){
print(contacts);
   return ListView.builder(
     shrinkWrap: true,
     itemBuilder: (context, index){
      return ListTile(
        onTap: (){
         UrlLauncher.launch("tel://" + contacts[index]);
        },
        title: Row(children: [
          Icon(Icons.phone),
          SizedBox(width: 25.0,),
          Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: Text("${contacts[index]}" ,style: TextStyle(fontSize: 16.0),),
          )]),
      );
    },itemCount: contacts.length,);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: FirebaseImage(
              "gs://manipallocals-2f95e.appspot.com/DIRECTORY.png"
          ),
        ),
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection("directory")
                  .document("8ptjVmVbwBJXZCNqt6JP")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  Fluttertoast.showToast(
                      msg: "Error: ${snapshot.error}",
                      toastLength: Toast.LENGTH_SHORT);
                  return Container();
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                        child: new CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ));
                  default:

                    return ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 16.0,
                        ),
                        for (String name in snapshot.data["phone_number"])
                          Padding(
                            child: ExpansionTile(
                              title: Text(
                                name,
                                style: TextStyle(fontSize: 16),
                              ),
                              children: [
                                custom(snapshot.data[name]),
                              ],
                            ),
                            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          ),
                      ],
                    );
                }
              }),
        ),
      ],
    );
    ;
  }
}
