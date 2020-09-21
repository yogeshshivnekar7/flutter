import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';

class PaymentSuccessPage extends StatefulWidget {
  @override
  _PaymentSuccessPageState createState() => new _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  TextEditingController userNameController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: FsColor.primaryflat,
        elevation: 0.0,
        title: new Text(
          'Payment Successfull',
          style: FSTextStyle.appbartextlight,
        ),
        leading: Container() /*FsBackButtonlight()*/,
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
                                'images/paymentsuccess_icon.png',
                                height: 220.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'We received your payment information.'
                                    .toLowerCase(),
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
                                'The amount would reflect in your due, subject to realisation.'
                                    .toLowerCase(),
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
                        child: Text('Explore More',
                            style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                            )),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainDashboard()),
                                  (Route<dynamic> route) => false);
                        },
                        color: FsColor.primaryflat,
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
