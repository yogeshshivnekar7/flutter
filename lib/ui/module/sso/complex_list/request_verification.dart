import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/utils/logger.dart';

class RequestVerificationPage extends StatefulWidget {
  String _brandName;
  String pageTitle;

  RequestVerificationPage(this.pageTitle, this._brandName);

  @override
  _RequestVerificationPageState createState() =>
      new _RequestVerificationPageState(pageTitle, _brandName);
}

class _RequestVerificationPageState extends State<RequestVerificationPage> {
  TextEditingController userNameController = new TextEditingController();

  // String _brandName;
  String pageTitle;

/*  String pageTitle;*/
  String pageTitleName = 'request business listing';

  //_RequestVerificationPageState(this._brandName);

  _RequestVerificationPageState(this.pageTitle, this.pageTitleName) {
    // Logger.log(pageTitle);
    Logger.log(6767);

    /* if (pageTitle == 'Resto') {
      pageTitleName = "brand".toLowerCase();
    } else if (pageTitle == 'Tiffin') {
      pageTitleName = "brand".toLowerCase();
    }*/
    // print(pageTitle);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color backgroundColor() {
    if (pageTitle == 'Resto') {
      return FsColor.primaryrestaurant;
    } else if (pageTitle == 'Grocery') {
      return FsColor.primarygrocery;
    } else
      return FsColor.primarytiffin;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /*String modalName = (pageTitle == 'Resto') ? '/webview' : '/tiffin_list';
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder:
                (context) =>
            (pageTitle == 'Resto')
                ? RestaurantsList()
                : TiffinList()));*/
        //Navigator.pushNamedAndRemoveUntil(context, modalName, ModalRoute.withName(modalName));
        /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    (pageTitle == 'Resto') ? RestaurantsList() : TiffinList()),
            ModalRoute.withName(modalName));*/
        //Navigator.popUntil(context, ModalRoute.withName(modalName));
        return Future.value(true);
      },
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: backgroundColor(),
          elevation: 0.0,
          title: new Text(
            pageTitleName,
            style: FSTextStyle.appbartextlight,
          ),
          //leading: FsBackButtonlight(),
          automaticallyImplyLeading: false,
        ),

        // backgroundColor: FsColor.basicprimary.withOpacity(0.1),
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
                                  'our executive will contact with the owner & we’ll be in touch within 24 hours ',
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
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainDashboard()),
                                );*/

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainDashboard()),
                                        (Route<dynamic> route) => false);
                              },
                              color: backgroundColor(),
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
    // backgroundColor: FsColor.basicprimary.withOpacity(0.1),
    /*body: Container(
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
                                'our executive will contact with the owner & we’ll be in touch within 24 hours ',
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainDashboard()),
                              );
                            },
                            color: FsColor.primaryrestaurant,
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
    );*/
  }
}
