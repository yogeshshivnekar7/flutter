import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class Error404Page extends StatefulWidget {
  @override
  _Error404PageState createState() => new _Error404PageState();
}

class _Error404PageState extends State<Error404Page> {
  TextEditingController userNameController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.5,
        title: new Text(
          '404',
          style: FSTextStyle.appbartext,
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: FsColor.darkgrey,
            size: 18.0,
          ),
        ),
        actions: <Widget>[],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              child: new Image.asset(
                                'images/404-icon.png',
                                height: 220.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'oops!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                    letterSpacing: 1.0,
                                    fontSize: FSTextStyle.h3size,
                                    height: 1.5,
                                    color: FsColor.darkgrey),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              child: Text(
                                "sorry, we can't find that page you're looking for",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                    letterSpacing: 1.0,
                                    fontSize: FSTextStyle.h6size,
                                    height: 1.5,
                                    color: FsColor.darkgrey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0, left: 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Text('Go Back',
                            style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                            )),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //   builder: (context) =>  RequestAccessPage()),
                          // );
                        },
                        color: FsColor.basicprimary,
                        textColor: FsColor.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
