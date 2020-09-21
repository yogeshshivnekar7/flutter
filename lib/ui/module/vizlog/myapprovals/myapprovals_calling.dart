import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyAprovalsCalling extends StatefulWidget {
  @override
  _MyAprovalsCallingState createState() => _MyAprovalsCallingState();
}

class _MyAprovalsCallingState extends State<MyAprovalsCalling>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: -50.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(5, 30, 5, 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/logo.png',
                            fit: BoxFit.contain,
                            height: 100.0,
                            width: 100.0,
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Long Lorem Ipsum Housing Complex',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h4size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.basicprimary),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'A-Wing',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              ),
                              Text(
                                '/',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              ),
                              Text(
                                '4002',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FsColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: FsColor.darkgrey.withOpacity(0.2),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "images/default.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Benjamin Keith',
                          style: TextStyle(
                              fontSize: FSTextStyle.h5size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.basicprimary),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Painter',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.lightgrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(0, animation.value),
                      child: Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: ButtonTheme(
                            minWidth: 64,
                            height: 64,
                            child: RaisedButton(
                              padding: EdgeInsets.all(10),
                              shape: CircleBorder(),
                              onPressed: () => {},
                              color: FsColor.green,
                              child: Icon(FlutterIcon.ok,
                                  color: FsColor.white,
                                  size: FSTextStyle.h2size),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, animation.value),
                      child: Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: ButtonTheme(
                            minWidth: 64,
                            height: 64,
                            child: RaisedButton(
                              padding: EdgeInsets.all(10),
                              shape: CircleBorder(),
                              onPressed: () => {},
                              color: FsColor.red,
                              child: Icon(FlutterIcon.cancel_1,
                                  color: FsColor.white,
                                  size: FSTextStyle.h2size),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

//  @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

}
