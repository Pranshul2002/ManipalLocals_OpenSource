import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manipal_locals/MityMeal/TeddyController.dart';

import 'LoginCode.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Login login;
  int hostelBlock = 1;
  int a = 0;
  Timer timer;
  bool verify = false;
  bool signup = false;
  bool loading = true;
  final _controller = ScrollController();
  final _controller1 = ScrollController();
  TeddyController _teddyController;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 0, left: 32),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 64),
                    )),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: new ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  child: new BackdropFilter(
                                    filter: new ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
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
                                          if (val.trim().length == 00)
                                            return "Please Enter a Name";
                                          else
                                            return null;
                                        },
                                        controller: controller,
                                        style: TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 10),
                                          errorStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white54),
                                          labelText: "Enter Name",
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: new ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  child: new BackdropFilter(
                                    filter: new ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
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
                                          if (val.length != 9)
                                            return "Please Enter a correct registration Number";
                                          else
                                            return null;
                                        },
                                        controller: controller,
                                        style: TextStyle(fontSize: 20),
                                        keyboardType: TextInputType.number,
                                        maxLength: 9,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 10),
                                          errorStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white54),
                                          labelText: "Registration Number",
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
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      child: BackdropFilter(
                                        filter: new ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.grey.shade200
                                                  .withOpacity(0.2)),
                                          alignment: Alignment.topLeft,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 28),
                                          child: DropdownButton(
                                              value: hostelBlock,
                                              items: [
                                                for (int i = 1; i < 23; i++)
                                                  DropdownMenuItem(
                                                    child:
                                                        Text("Hostel Block $i"),
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
                                  child: new BackdropFilter(
                                    filter: new ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
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
                                          if (val.length != 10)
                                            return "Please Enter correct number";
                                          else
                                            return null;
                                        },
                                        controller: controller,
                                        style: TextStyle(fontSize: 20),
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        decoration: InputDecoration(
                                          prefix: Text("+91 "),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 28, vertical: 0),
                                          errorStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white54),
                                          labelText: "Enter Phone Number",
                                          alignLabelWithHint: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          hintText: "1234567890",
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                width: 2,
                                color: Colors.white,
                              )),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _controller1.animateTo(
                                  _controller1.position.maxScrollExtent,
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 300));
                              _teddyController.lookAt(null);
                              login = Login(
                                  controller.text, _teddyController, context);
                              verify = true;
                              await login.start();
                              a = 60;
                              timer =
                                  Timer.periodic(Duration(seconds: 1), (timer) {
                                if (a == 1) {
                                  timer.cancel();
                                }
                                if (mounted)
                                  setState(() {
                                    a--;
                                  });
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Proceed",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
