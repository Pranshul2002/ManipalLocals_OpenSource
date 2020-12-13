import 'dart:async';
import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:manipal_locals/MityMeal/LoginCode.dart';
import 'package:manipal_locals/MityMeal/SignUpPage.dart';
import 'package:manipal_locals/MityMeal/TeddyController.dart';

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
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  Login login;
  int a = 0;
  Timer timer;
  bool verify = false;
  bool signup = false;
  bool loading = true;
  @override
  void initState() {
    // TODO: Check in firebase if user exists. If it doesnot exists then change signup bool to true.
    //TODO: After checking make loading false.
    super.initState();
    _teddyController = TeddyController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    timeDilation = 1;
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
                              if (mounted)
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
                  padding: EdgeInsets.only(top: height + 250),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: Color(0xff36454f),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    height: height - 200,
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      controller: _controller1,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //LoginPage
                        // Container(
                        //   color: Colors.transparent,
                        //   width: width,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     mainAxisSize: MainAxisSize.max,
                        //     children: [
                        //       Expanded(
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           mainAxisSize: MainAxisSize.max,
                        //           children: [
                        //             Container(
                        //                 alignment: Alignment.topLeft,
                        //                 padding:
                        //                     EdgeInsets.only(top: 16, left: 32),
                        //                 child: Text(
                        //                   "Login",
                        //                   style: TextStyle(fontSize: 64),
                        //                 )),
                        //             Expanded(
                        //               child: Column(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 mainAxisSize: MainAxisSize.max,
                        //                 children: [
                        //                   Form(
                        //                     key: _formKey,
                        //                     child: Stack(
                        //                       children: [
                        //                         Container(
                        //                           color: Colors.transparent,
                        //                           alignment: Alignment.center,
                        //                           padding: EdgeInsets.symmetric(
                        //                               vertical: 32,
                        //                               horizontal: 16),
                        //                           child: new ClipRRect(
                        //                             borderRadius:
                        //                                 BorderRadius.all(
                        //                                     Radius.circular(
                        //                                         100)),
                        //                             child: new BackdropFilter(
                        //                               filter:
                        //                                   new ImageFilter.blur(
                        //                                       sigmaX: 10.0,
                        //                                       sigmaY: 10.0),
                        //                               child: new Container(
                        //                                 decoration:
                        //                                     new BoxDecoration(
                        //                                         color: Colors
                        //                                             .grey
                        //                                             .shade200
                        //                                             .withOpacity(
                        //                                                 0.2)),
                        //                                 child:
                        //                                     new TextFormField(
                        //                                   onTap: () {
                        //                                     _teddyController.lookAt(Offset(
                        //                                         0,
                        //                                         MediaQuery.of(context)
                        //                                                     .size
                        //                                                     .height *
                        //                                                 1.5 -
                        //                                             100));
                        //                                   },
                        //                                   validator: (val) {
                        //                                     if (val.length !=
                        //                                         10)
                        //                                       return "Please Enter correct number";
                        //                                     else
                        //                                       return null;
                        //                                   },
                        //                                   controller:
                        //                                       controller,
                        //                                   style: TextStyle(
                        //                                       fontSize: 20),
                        //                                   keyboardType:
                        //                                       TextInputType
                        //                                           .number,
                        //                                   maxLength: 10,
                        //                                   textAlignVertical:
                        //                                       TextAlignVertical
                        //                                           .top,
                        //                                   decoration:
                        //                                       InputDecoration(
                        //                                     prefix:
                        //                                         Text("+91 "),
                        //                                     contentPadding:
                        //                                         EdgeInsets
                        //                                             .symmetric(
                        //                                                 horizontal:
                        //                                                     32,
                        //                                                 vertical:
                        //                                                     0),
                        //                                     errorStyle: TextStyle(
                        //                                         fontSize: 14,
                        //                                         color: Colors
                        //                                             .white54),
                        //                                     labelText:
                        //                                         "Enter Phone Number",
                        //                                     alignLabelWithHint:
                        //                                         true,
                        //                                     floatingLabelBehavior:
                        //                                         FloatingLabelBehavior
                        //                                             .never,
                        //                                     hintText:
                        //                                         "1234567890",
                        //                                     hintStyle: TextStyle(
                        //                                         fontSize: 20,
                        //                                         color: Colors
                        //                                             .white54),
                        //                                     border: InputBorder
                        //                                         .none,
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                   Padding(
                        //                     padding: EdgeInsets.only(top: 32),
                        //                     child: MaterialButton(
                        //                       shape: RoundedRectangleBorder(
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   20.0),
                        //                           side: BorderSide(
                        //                             width: 2,
                        //                             color: Colors.white,
                        //                           )),
                        //                       onPressed: () async {
                        //                         if (_formKey.currentState
                        //                             .validate()) {
                        //                           _controller1.animateTo(
                        //                               _controller1.position
                        //                                   .maxScrollExtent,
                        //                               curve: Curves.easeIn,
                        //                               duration: Duration(
                        //                                   milliseconds: 300));
                        //                           _teddyController.lookAt(null);
                        //                           login = Login(
                        //                               controller.text,
                        //                               _teddyController,
                        //                               context);
                        //                           verify = true;
                        //                           await login.start();
                        //                           a = 60;
                        //                           timer = Timer.periodic(
                        //                               Duration(seconds: 1),
                        //                               (timer) {
                        //                             if (a == 1) {
                        //                               timer.cancel();
                        //                             }
                        //                             if (mounted)
                        //                               setState(() {
                        //                                 a--;
                        //                               });
                        //                           });
                        //                         }
                        //                       },
                        //                       child: Padding(
                        //                         padding:
                        //                             const EdgeInsets.all(8.0),
                        //                         child: Text(
                        //                           "Proceed",
                        //                           style:
                        //                               TextStyle(fontSize: 18),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SignUpPage(),
                        //TODO: Copy the login page design to make signup page
                        //Signup page code start

                        //Signup page code end

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
                                                controller: controller1,
                                                onTap: () {
                                                  _teddyController
                                                      .coverEyes(true);
                                                },
                                                style: TextStyle(fontSize: 20),
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 6,
                                                textAlignVertical:
                                                    TextAlignVertical.top,
                                                decoration: InputDecoration(
                                                  suffix: GestureDetector(
                                                    onTap: () {
                                                      if (a == 0) {
                                                        login.start();
                                                        if (mounted)
                                                          setState(() {
                                                            a = 60;
                                                            timer =
                                                                Timer.periodic(
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                    (timer) {
                                                              if (a == 1) {
                                                                timer.cancel();
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
                                          if (controller1.text.length == 6) {
                                            await login
                                                .verify(controller1.text);
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
