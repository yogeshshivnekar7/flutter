import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/my_business/hrms/attendance_page.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class MyBusinessCard extends StatefulWidget {
  @override
  _MyBusinessCardState createState() => new _MyBusinessCardState();
}

class _MyBusinessCardState extends State<MyBusinessCard> {
  bool isContain = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
      children: <Widget>[
        new Container(
          child: new Card(
            key: null,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/dash-bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "my attendance",
                                  style: TextStyle(
                                      fontSize: FSTextStyle.dashtitlesize,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.primarymybusiness),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                child: RaisedButton(
                                  elevation: 1.0,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(4.0),
                                      ),
                                      onPressed: () =>
                                      {
                                        openMyBusiness(),
                                      },
                                      color: FsColor.primarymybusiness,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      child: Text(
                                        "Open",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Bold',
                                            color: FsColor.white),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          /*Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset("images/dash2.png",
                                  height: 100, width: 100, fit: BoxFit.fitHeight),
                            ),
                          ),*/
                        ],
                      ),

                      isContain
                          ? SizedBox(
                        height: 10.0,
                        child: Divider(
                            color: FsColor.darkgrey.withOpacity(0.2),
                            height: 2.0),
                      )
                          : Container(),

                      isContain
                          ? Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Text(
                                  "Sudden guests? Late-night hunger pangs? Or just in the mood to eat-out? Order food from your favorite neighbourhood restaurant."
                                      .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.dashsubtitlesize,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                ))
                          ],
                        ),
                      )
                          : Container(),

                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: <Widget>[
                      //           Text(
                      //             "3",
                      //             style: TextStyle(fontSize: FSTextStyle.h4size, fontFamily: 'Gilroy-Bold', color:  FsColor.darkgrey),
                      //           ),
                      //           Container(
                      //             height: 3,
                      //           ),
                      //           Text("Past Orders",
                      //             style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color:  FsColor.darkgrey),
                      //          ),
                      //           SizedBox(height: 4.0),
                      //         ],
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: <Widget>[
                      //           GestureDetector(
                      //             child: FlatButton(
                      //               onPressed: () {},
                      //               child: Row(
                      //                 children: <Widget>[
                      //                   Text("View & Re-Order",
                      //                     style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color:  FsColor.darkgrey),
                      //                   ),
                      //                   SizedBox(width: 10.0),
                      //                   Icon(FlutterIcon.right_big, color: FsColor.darkgrey, size: FSTextStyle.h6size),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              alignment: Alignment.center,
            ),
          ],
        ));
  }

  openMyBusiness() {
    AppUtils.checkInternetConnection().then((onValue) {
      if (onValue) {
        FsFacebookUtils.callCartClick(FsString.MY_BUSINESS, "card");
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => Attendance()),
        );
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }
}
