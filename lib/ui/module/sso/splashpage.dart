//import 'dart:async';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:sso_futurescape/config/colors/color.dart';
//import 'package:sso_futurescape/utils/firebase_util/firebase_notification.dart';
//import 'package:sso_futurescape/utils/storage/sso_storage.dart';
//
//class SplashScreenPage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return SplashScreenState();
//  }
//}
//
//class SplashScreenState extends State<SplashScreenPage> {
//  Timer time;
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      resizeToAvoidBottomPadding: false,
//      body: Container(
//        alignment: Alignment.center,
//        child: Stack(
//          children: <Widget>[
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Image.asset('images/dummy_logo.png',
//                  fit: BoxFit.contain,
//                  height: 75.0,
//                  width: 250.0,
//                ),
//                Text('Long Long Tagline here'.toLowerCase(),
//                  style: TextStyle(fontFamily: 'Gilroy-Regular',
//                      letterSpacing: 1.0,
//                      fontSize: FSTextStyle.h6size,
//                      color: FsColor.darkgrey),
//                )
//              ],
//            ),
//
//
//            Positioned(
//              left: 0, right: 0, bottom: 10.0,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text('from', textAlign: TextAlign.center,
//                    style: TextStyle(fontFamily: 'Gilroy-SemiBold',
//                        letterSpacing: 1.0,
//                        fontSize: FSTextStyle.h7size,
//                        color: FsColor.darkgrey),
//                  ),
//                  Text('Futurescape', textAlign: TextAlign.center,
//                    style: TextStyle(fontFamily: 'Gilroy-Bold',
//                        letterSpacing: 1.0,
//                        fontSize: FSTextStyle.h5size,
//                        color: FsColor.primary),
//                  )
//                ],
//              ),
//            )
//
//          ],
//        ),
//
//
//      ),
//    );
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    new FirebaseNotifications().setUpFirebase();
//    var duration = const Duration(microseconds: 100);
//    time = new Timer(duration, handleTimeout);
//    /*   var ssk=null;
//    ssk["iiiiii"].toString();*/
//  }
//
//  void handleTimeout() {
//    SsoStorage.isLogin().then((isLOgin) {
//      print(isLOgin);
//      if (isLOgin == "true") {
//        Navigator.of(context).pushNamed('/dashboard');
//      } else {
//        Navigator.of(context).pushNamed('/useronbording');
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    time.cancel();
//  }
//}
