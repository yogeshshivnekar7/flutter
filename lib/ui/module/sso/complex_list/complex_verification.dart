import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';

class ComplexVerificationPage extends StatefulWidget {

  String _complexName;


  ComplexVerificationPage(this._complexName);

  @override
  _ComplexVerificationPageState createState() =>
      new _ComplexVerificationPageState(_complexName);
}

class _ComplexVerificationPageState extends State<ComplexVerificationPage> {
  TextEditingController userNameController = new TextEditingController();
  String _complexName;


  _ComplexVerificationPageState(this._complexName);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /*Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ComplexList()));*/
        return Future.value(true);
      },
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: FsColor.primaryflat,
          elevation: 0.0,
          title: new Text(_complexName,
            style: FSTextStyle.appbartextlight,
          ),
          //leading: FsBackButtonlight(),
          automaticallyImplyLeading: false,
        ),
        // backgroundColor: FsColor.primary.withOpacity(0.1),
        body: Container(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              // Container(
                              //   child: new Image.asset('images/pending-approval.png',
                              //     width: 220.0,
                              //     height: 220.0,
                              //     fit:BoxFit.contain,
                              //   ),
                              // ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'thanks for your request',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      letterSpacing: 1.0,
                                      fontSize: FSTextStyle.h3size,
                                      height: 1.5,
                                      color: FsColor.green),
                                ),
                              ),

                              SizedBox(height: 15),
                              Container(
                                child: Text(
                                  'what is next?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-bold',
                                      letterSpacing: 1.0,
                                      fontSize: FSTextStyle.h5size,
                                      height: 1.5,
                                      color: FsColor.darkgrey),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'our executive will contact with the secretary/chairman & we will keep you posted ',
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
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                          child: GestureDetector(
                            child: RaisedButton(
                              padding:
                              EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
