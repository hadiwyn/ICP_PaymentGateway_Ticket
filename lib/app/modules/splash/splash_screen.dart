import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ticket_wisata_donorojo/app/routes/app_pages.dart';

import '../admin/home_admin.dart';
import '../animations/fade_animations.dart';
import '../user/dashboard/home.dart';
import '../login/views/login_view.dart';
import '';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _scaleController;
  AnimationController? _scale2Controller;
  AnimationController? _widthController;
  AnimationController? _positionController;

  Animation<double>? _scaleAnimation;
  Animation<double>? _scale2Animation;
  Animation<double>? _widthAnimation;
  Animation<double>? _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController?.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController?.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller?.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              User? user = FirebaseAuth.instance.currentUser;
              Future.delayed(const Duration(seconds: 2)).then((value) async {
                print(user);
                if (user != null) {
                  print(user);
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .get()
                      .then((DocumentSnapshot snapshot) {
                    if (snapshot.get('role') == 'admin') {
                      Get.off(HomeAdmin());
                    } else if (snapshot.get('role') == 'user') {
                      Get.off(Home());
                    }
                  });
                } else {
                  Get.offNamed(Routes.LOGIN);
                }
                //   Get.off(() => user != null ? Home() : LoginView());
                //   await FirebaseFirestore.instance
                //       .collection('users')
                //       .doc(user!.uid)
                //       .get()
                //       .then((DocumentSnapshot snap) {
                //     if (snap.get('role') == 'admin' && user != null) {
                //       Get.off(HomeAdmin());
                //     } else if (snap.get('role') == 'user' && user != null) {
                //       Get.off(Home());
                //     } else if (user == null) {
                //       Get.off(LoginView());
                //     }
                //   });
              });
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -50,
              left: 0,
              child: FadeAnimation(
                  1,
                  Container(
                    width: width,
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/one.png'),
                            fit: BoxFit.cover)),
                  )),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(
                  1.3,
                  Container(
                    width: width,
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/one.png'),
                            fit: BoxFit.cover)),
                  )),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: FadeAnimation(
                  1.6,
                  Container(
                    width: width,
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/one.png'),
                            fit: BoxFit.cover)),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Welcome",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "We promis that you'll have the most \nfuss-free time with us ever.",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            height: 1.4,
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 180,
                  ),
                  FadeAnimation(
                      1.6,
                      AnimatedBuilder(
                        animation: _scaleController!,
                        builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation?.value,
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _widthController!,
                                builder: (context, child) => Container(
                                  width: _widthAnimation?.value,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue.withOpacity(.4)),
                                  child: InkWell(
                                    onTap: () {
                                      _scaleController?.forward();
                                    },
                                    child: Stack(children: <Widget>[
                                      AnimatedBuilder(
                                        animation: _positionController!,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation?.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller!,
                                            builder: (context, child) =>
                                                Transform.scale(
                                                    scale:
                                                        _scale2Animation?.value,
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                      child: hideIcon == false
                                                          ? Icon(
                                                              Icons
                                                                  .arrow_forward,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : Container(),
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            )),
                      )),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
