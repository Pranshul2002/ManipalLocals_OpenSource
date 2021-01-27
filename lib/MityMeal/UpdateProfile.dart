import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'TeddyController.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TeddyController _teddyController;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController regcontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  int hostelBlock = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _teddyController = TeddyController();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        mobilecontroller.text = value.phoneNumber.substring(3);
      });
    });
    Firestore.instance
        .collection("users")
        .document("7JOEExxZ3goV9mKPwcUO")
        .get()
        .then((value) {
      setState(() {
        regcontroller.text = value.data["+91" + mobilecontroller.text]
                ["Registration Number"]
            .toString();
        hostelBlock = value.data["+91" + mobilecontroller.text]["Hostel"];
        namecontroller.text = value.data["+91" + mobilecontroller.text]["Name"];
        roomcontroller.text =
            value.data["+91" + mobilecontroller.text]["Room Number"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          canvasColor: Colors.black,
          brightness: Brightness.dark,
          fontFamily: "banglamn"),
      home: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Container(
                padding: EdgeInsets.only(top: 16),
                height: 200,
                child: FlareActor(
                  "assets/Teddy.flr",
                  shouldClip: false,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                  controller: _teddyController,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 250),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff36454f),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                          top: 16, bottom: 32, left: 32, right: 32),
                      child: Text(
                        "Update Profile",
                        style: TextStyle(fontSize: 64),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: new ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: new Container(
                                decoration: new BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.2)),
                                child: new TextFormField(
                                  onTap: () {
                                    _teddyController.lookAt(Offset(
                                        0,
                                        MediaQuery.of(context).size.height *
                                                1.5 -
                                            100));
                                  },
                                  validator: (val) {
                                    if (val.trim().length == 0)
                                      return "Please Enter a Name";
                                    else
                                      return null;
                                  },
                                  controller: namecontroller,
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 20),
                                    errorStyle: TextStyle(
                                        fontSize: 14, color: Colors.white54),
                                    labelText: "Enter Name",
                                    alignLabelWithHint: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintStyle: TextStyle(
                                        fontSize: 20, color: Colors.white54),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: new ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: new Container(
                                decoration: new BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.2)),
                                child: new TextFormField(
                                  onTap: () {
                                    _teddyController.lookAt(Offset(
                                        0,
                                        MediaQuery.of(context).size.height *
                                                1.5 -
                                            100));
                                  },
                                  validator: (val) {
                                    if (val.length != 9)
                                      return "Please Enter correct registration number";
                                    else
                                      return null;
                                  },
                                  controller: regcontroller,
                                  style: TextStyle(fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  maxLength: 9,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 20),
                                    errorStyle: TextStyle(
                                        fontSize: 14, color: Colors.white54),
                                    labelText: "Registration Number",
                                    alignLabelWithHint: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintStyle: TextStyle(
                                        fontSize: 20, color: Colors.white54),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.grey.shade200
                                              .withOpacity(0.2)),
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 25),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          value: hostelBlock,
                                          items: [
                                            for (int i = 1; i < 23; i++)
                                              DropdownMenuItem(
                                                child: Text("Hostel Block $i"),
                                                value: i,
                                              ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              hostelBlock = value;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  child: new ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.grey.shade200
                                              .withOpacity(0.2)),
                                      child: new TextFormField(
                                        onTap: () {
                                          _teddyController.lookAt(Offset(
                                              0,
                                              MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      1.5 -
                                                  100));
                                        },
                                        validator: (val) {
                                          if (val.length <= 0)
                                            return "Please Enter Room No.";
                                          else
                                            return null;
                                        },
                                        controller: roomcontroller,
                                        style: TextStyle(fontSize: 20),
                                        maxLength: 9,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 20),
                                          errorStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white54),
                                          labelText: "Room No.",
                                          alignLabelWithHint: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          hintStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white54),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: new ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: new Container(
                                decoration: new BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.2)),
                                child: new TextFormField(
                                  enabled: false,
                                  onTap: () {
                                    _teddyController.lookAt(Offset(
                                        0,
                                        MediaQuery.of(context).size.height *
                                                1.5 -
                                            100));
                                  },
                                  validator: (val) {
                                    if (val.length != 10)
                                      return "Please Enter correct number";
                                    else
                                      return null;
                                  },
                                  controller: mobilecontroller,
                                  style: TextStyle(fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: InputDecoration(
                                    prefix: Text("+91 "),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 0),
                                    errorStyle: TextStyle(
                                        fontSize: 14, color: Colors.white54),
                                    labelText: "Enter Phone Number",
                                    alignLabelWithHint: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: "1234567890",
                                    hintStyle: TextStyle(
                                        fontSize: 20, color: Colors.white54),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 16, left: 32, right: 32, bottom: 16),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(
                              width: 2,
                              color: Colors.white,
                            )),
                        onPressed: () async {
                          await Firestore.instance
                              .collection("users")
                              .document("7JOEExxZ3goV9mKPwcUO")
                              .updateData({
                            "+91" + mobilecontroller.text: {
                              "Registration Number":
                                  int.parse(regcontroller.text),
                              "Name": namecontroller.text,
                              "Hostel": hostelBlock,
                              "Phone Number": int.parse(mobilecontroller.text),
                              "Room Number": roomcontroller.text
                            }
                          });
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Update",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
