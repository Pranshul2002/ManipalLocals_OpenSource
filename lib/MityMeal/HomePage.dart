import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manipal_locals/MityMeal/LoginCode.dart';

import 'package:manipal_locals/MityMeal/TeddyController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils.dart';
import 'food_menu_screen.dart';
import 'LoginCode.dart';

class HomePageMM extends StatefulWidget {
  @override
  _HomePageMMState createState() => _HomePageMMState();
}

class _HomePageMMState extends State<HomePageMM> {
  TeddyController _teddyController;
  final _controller = ScrollController();
  final _controller1 = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController regcontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  Login login;
  int a = 0;
  Timer timer;
  bool verify = false;
  bool signup = false;
  bool loading = true;
  SharedPreferences prefs;
  List<dynamic> users;
  int hostelBlock = 1;
  UserInfoP userInfo;
  @override
  void initState() {
    getShared();

    super.initState();
    _teddyController = TeddyController();
  }

  getUsers() async {
    await Firestore.instance
        .collection("users")
        .document("7JOEExxZ3goV9mKPwcUO")
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        users = ds.data["user_number"];
      });
    });
  }

  getShared() async {
    await getUsers();
    prefs = await SharedPreferenceClass.getInstance();
    prefs.getBool("signup") != null
        ? setState(() {
            signup = prefs.getBool("signup");
            loading = false;
          })
        : setState(() {
            signup = true;
            loading = false;
          });

    var user = await FirebaseAuth.instance.currentUser();
    if (users != null && user != null) {
      if (users.contains(user.phoneNumber)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => FoodMenuScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    timeDilation = 1;
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.black,
          brightness: Brightness.dark,
          fontFamily: "banglamn"),
      home: Scaffold(
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          padding: EdgeInsets.all(0),
          children: [
            Stack(
              children: [
                //First Page with Mity Meal Logo
                Container(
                  height: height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/LANDINGSCREEN.png"),
                          fit: BoxFit.fitHeight)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 64),
                          child: RawMaterialButton(
                            onPressed: () {
                              if (mounted && !loading)
                                setState(() {
                                  _controller.animateTo(
                                      _controller.position.maxScrollExtent,
                                      curve: Curves.easeIn,
                                      duration: Duration(milliseconds: 300));
                                });
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 35.0,
                              color: Colors.black,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ))
                    ],
                  ),
                ),
                SafeArea(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height + 50),
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
                if (!signup)
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(top: height + 50),
                      child: Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(16),
                        height: 200,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                signup = true;
                              });
                            },
                            child: Text("Sign Up")),
                      ),
                    ),
                  ),
                if (signup)
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(top: height + 50),
                      child: Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(16),
                        height: 200,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                signup = false;
                              });
                            },
                            child: Text("Log In")),
                      ),
                    ),
                  ),
                SafeArea(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: height + 35, left: 8),
                    child: IconButton(
                      onPressed: () {
                        if (mounted)
                          setState(() {
                            verify
                                ? _controller1.animateTo(
                                    _controller.position.minScrollExtent,
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 300))
                                : _controller.animateTo(
                                    _controller.position.minScrollExtent,
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 300));
                            if (verify) {
                              _teddyController.coverEyes(false);
                              _teddyController.lookAt(null);
                              verify = false;
                            }
                          });
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height + 250,
                  ),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: Color(0xff36454f),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    height: height - 200,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: bottom,
                      ),
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        controller: _controller1,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          //LoginPage
                          if (!signup)
                            Container(
                              color: Colors.transparent,
                              width: width,
                              child: ListView(
                                children: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(top: 16, left: 32),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(fontSize: 64),
                                      )),
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Container(
                                          //   color: Colors.pink,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 32, horizontal: 16),
                                          child: new ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: new Container(
                                              decoration: new BoxDecoration(
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.2)),
                                              child: new TextFormField(
                                                onTap: () {
                                                  _teddyController.lookAt(
                                                      Offset(
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
                                                controller: mobilecontroller,
                                                style: TextStyle(fontSize: 20),
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 10,
                                                textAlignVertical:
                                                    TextAlignVertical.top,
                                                decoration: InputDecoration(
                                                  prefix: Text("+91 "),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 32,
                                                          vertical: 0),
                                                  errorStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white54),
                                                  labelText:
                                                      "Enter Phone Number",
                                                  alignLabelWithHint: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 14,
                                            bottom: 16,
                                            left: 32,
                                            right: 32),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              side: BorderSide(
                                                width: 2,
                                                color: Colors.white,
                                              )),
                                          onPressed: () async {
                                            if (!users.contains("+91" +
                                                mobilecontroller.text.trim())) {
                                              Fluttertoast.showToast(
                                                  msg: "User not registered",
                                                  backgroundColor: Colors.grey,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  textColor: Colors.white);
                                              setState(() {
                                                signup = true;
                                              });
                                            } else {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _controller1.animateTo(
                                                    _controller1.position
                                                        .maxScrollExtent,
                                                    curve: Curves.easeIn,
                                                    duration: Duration(
                                                        milliseconds: 300));
                                                _teddyController.lookAt(null);
                                                login = Login(
                                                    mobilecontroller.text,
                                                    _teddyController,
                                                    context);
                                                verify = true;
                                                await login.start(
                                                    signup, users, userInfo);
                                                a = 60;
                                                timer = Timer.periodic(
                                                    Duration(seconds: 1),
                                                    (timer) {
                                                  if (a == 1) {
                                                    timer.cancel();
                                                  }
                                                  if (mounted)
                                                    setState(() {
                                                      a--;
                                                    });
                                                });
                                              }
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
                                  )
                                ],
                              ),
                            ),
                          if (signup)
                            Container(
                              color: Colors.transparent,
                              width: width,
                              child: ListView(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        top: 16,
                                        bottom: 32,
                                        left: 32,
                                        right: 32),
                                    child: Text(
                                      "Sign Up",
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: new Container(
                                              decoration: new BoxDecoration(
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.2)),
                                              child: new TextFormField(
                                                onTap: () {
                                                  _teddyController.lookAt(
                                                      Offset(
                                                          0,
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .height *
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
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 28,
                                                          vertical: 20),
                                                  errorStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white54),
                                                  labelText: "Enter Name",
                                                  alignLabelWithHint: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  hintStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white54),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: new Container(
                                              decoration: new BoxDecoration(
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.2)),
                                              child: new TextFormField(
                                                onTap: () {
                                                  _teddyController.lookAt(
                                                      Offset(
                                                          0,
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .height *
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
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 9,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  isCollapsed: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 28,
                                                          vertical: 20),
                                                  errorStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white54),
                                                  labelText:
                                                      "Registration Number",
                                                  alignLabelWithHint: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  hintStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white54),
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
                                                    vertical: 20,
                                                    horizontal: 16),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  child: Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                            color: Colors
                                                                .grey.shade200
                                                                .withOpacity(
                                                                    0.2)),
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 25),
                                                    child: DropdownButton(
                                                        isExpanded: true,
                                                        value: hostelBlock,
                                                        items: [
                                                          for (int i = 1;
                                                              i < 23;
                                                              i++)
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  "Hostel Block $i"),
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
                                                    vertical: 20,
                                                    horizontal: 16),
                                                child: new ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  child: new Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                            color: Colors
                                                                .grey.shade200
                                                                .withOpacity(
                                                                    0.2)),
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
                                                      controller:
                                                          roomcontroller,
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                      maxLength: 9,
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: '',
                                                        isCollapsed: true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        28,
                                                                    vertical:
                                                                        20),
                                                        errorStyle: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white54),
                                                        labelText: "Room No.",
                                                        alignLabelWithHint:
                                                            true,
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .never,
                                                        hintStyle: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white54),
                                                        border:
                                                            InputBorder.none,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: new Container(
                                              decoration: new BoxDecoration(
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.2)),
                                              child: new TextFormField(
                                                onTap: () {
                                                  _teddyController.lookAt(
                                                      Offset(
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
                                                controller: mobilecontroller,
                                                style: TextStyle(fontSize: 20),
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 10,
                                                textAlignVertical:
                                                    TextAlignVertical.top,
                                                decoration: InputDecoration(
                                                  prefix: Text("+91 "),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 28,
                                                          vertical: 0),
                                                  errorStyle: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white54),
                                                  labelText:
                                                      "Enter Phone Number",
                                                  alignLabelWithHint: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
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
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 16,
                                        left: 32,
                                        right: 32,
                                        bottom: 16),
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                            width: 2,
                                            color: Colors.white,
                                          )),
                                      onPressed: () async {
                                        _teddyController.lookAt(null);
                                        if (users.contains("+91" +
                                            mobilecontroller.text.trim())) {
                                          Fluttertoast.showToast(
                                              msg: "User already registered",
                                              backgroundColor: Colors.grey,
                                              toastLength: Toast.LENGTH_SHORT,
                                              textColor: Colors.white);
                                          setState(() {
                                            signup = false;
                                          });
                                        } else {
                                          setState(() {
                                            userInfo = UserInfoP(
                                                namecontroller.text.trim(),
                                                int.parse(regcontroller.text),
                                                hostelBlock,
                                                roomcontroller.text.trim(),
                                                int.parse(mobilecontroller.text
                                                    .trim()));
                                          });
                                          if (_formKey.currentState
                                              .validate()) {
                                            _controller1.animateTo(
                                                _controller1
                                                    .position.maxScrollExtent,
                                                curve: Curves.easeIn,
                                                duration: Duration(
                                                    milliseconds: 300));

                                            login = Login(mobilecontroller.text,
                                                _teddyController, context);
                                            verify = true;

                                            await login.start(
                                                signup, users, userInfo);
                                            a = 60;
                                            timer = Timer.periodic(
                                                Duration(seconds: 1), (timer) {
                                              if (a == 1) {
                                                timer.cancel();
                                              }
                                              if (mounted)
                                                setState(() {
                                                  a--;
                                                });
                                            });
                                          }
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

                          //OTP Verification Page
                          Container(
                            width: width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(top: 16, left: 32),
                                    child: Text(
                                      "Verify",
                                      style: TextStyle(fontSize: 64),
                                    )),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Form(
                                        key: _formKey1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: new ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            child: new BackdropFilter(
                                              filter: new ImageFilter.blur(
                                                  sigmaX: 10.0, sigmaY: 10.0),
                                              child: new Container(
                                                decoration: new BoxDecoration(
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.2)),
                                                child: new TextFormField(
                                                  controller: otpcontroller,
                                                  onTap: () {
                                                    _teddyController
                                                        .coverEyes(true);
                                                  },
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLength: 6,
                                                  textAlignVertical:
                                                      TextAlignVertical.top,
                                                  decoration: InputDecoration(
                                                    suffix: GestureDetector(
                                                      onTap: () {
                                                        if (a == 0) {
                                                          login.start(signup,
                                                              users, userInfo);
                                                          if (mounted)
                                                            setState(() {
                                                              a = 60;
                                                              timer = Timer
                                                                  .periodic(
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                      (timer) {
                                                                if (a == 1) {
                                                                  timer
                                                                      .cancel();
                                                                }
                                                                if (mounted)
                                                                  setState(() {
                                                                    a--;
                                                                  });
                                                              });
                                                            });
                                                        }
                                                      },
                                                      child: Text(
                                                        a == 0
                                                            ? "Resend"
                                                            : "Resend in ${a.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 32,
                                                            vertical: 0),
                                                    labelText: "Enter OTP",
                                                    alignLabelWithHint: true,
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .never,
                                                    hintText: "123456",
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
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 32),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              side: BorderSide(
                                                width: 2,
                                                color: Colors.white,
                                              )),
                                          onPressed: () async {
                                            _teddyController.coverEyes(false);
                                            _teddyController.lookAt(null);

                                            if (otpcontroller.text.length ==
                                                6) {
                                              await login.verify(
                                                  otpcontroller.text,
                                                  signup,
                                                  users,
                                                  userInfo);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Verify",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
