import 'dart:ui';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class ErrorNoInternetPage extends StatefulWidget {
  String error;

  ErrorNoInternetPage({this.error});

  @override
  _ErrorNoInternetPageState createState() =>
      new _ErrorNoInternetPageState(error);
}

class _ErrorNoInternetPageState extends State<ErrorNoInternetPage> {
  TextEditingController userNameController = new TextEditingController();
  String error;

  _ErrorNoInternetPageState(this.error);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: new Text(
          'No Internet Connection',
          style: FSTextStyle.appbartext,
        ),
        automaticallyImplyLeading: false,
//        leading: GestureDetector(
//          child: Icon(
//            Icons.arrow_back,
//            color: FsColor.darkgrey,
//            size: 18.0,
//          ),
//        ),
//        actions: <Widget>[],
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
                                'images/no-connection.png',
                                height: 220.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'There is No Internet Connection'.toLowerCase(),
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
                                'Slow or No Internet Connection \n Please Check your Internet COnnection & Try Again '
                                    .toLowerCase() +
                                    "\n\n${getError()}".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                    letterSpacing: 1.0,
                                    fontSize: FSTextStyle.h6size,
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
                        child: Text('Try Again',
                            style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                            )),
                        onPressed: () {
                          /*Navigator.push(
                             context,
                             MaterialPageRoute(
                             builder: (context) =>  SplashScreenPage()),
                           );*/
                          checkInternetConnectivity();
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

  void checkInternetConnectivity() {
    AppUtils.checkInternetConnection().then((onValue) {
      if (onValue) {
        /*  Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SplashScreenPage()),
                (Route<dynamic> route) => false);*/
        Navigator.of(context).pop({'connection': true});
      } else {
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }

  getError() {
    if (error != null) {
      return error;
    } else {
      return "";
    }
  }
}