//import 'package:flutter/material.dart';
//import 'package:sso_futurescape/config/colors/color.dart';
//import 'package:sso_futurescape/ui/module/chsone/complaints/complaints_closed.dart';
//import 'package:sso_futurescape/ui/module/chsone/complaints/complaints_open.dart';
//import 'package:sso_futurescape/ui/module/chsone/complaints/complaints_resolved.dart';
//import 'package:sso_futurescape/ui/module/chsone/complaints/myflats_complaintadd.dart';
//import 'package:sso_futurescape/ui/widgets/back_button.dart';
//import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
//import 'package:sso_futurescape/utils/storage/complex.dart';
//
//class MyDomesticHelpDetails extends StatefulWidget {
//  @override
//  _MyDomesticHelpDetailsState createState() =>
//      new _MyDomesticHelpDetailsState();
//}
//
//class _MyDomesticHelpDetailsState extends State<MyDomesticHelpDetails> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//          resizeToAvoidBottomPadding: false,
//          appBar: AppBar(
//            title: Text(
//              'My Domestic Help Details'.toLowerCase(),
//              style: FSTextStyle.appbartextlight,
//            ),
//            elevation: 0.0,
//            backgroundColor: FsColor.primaryvisitor,
//            leading: FsBackButtonlight(),
//          ),
//          body: SingleChildScrollView(
//        child: Stack(
//        children: <Widget>[
//          Container(
//            height: 80,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.only(
//                bottomLeft: Radius.circular(50.0),
//                bottomRight: Radius.circular(50.0)),
//              gradient: LinearGradient(
//                colors: [ FsColor.primaryvisitor, FsColor.primaryvisitor.withOpacity(0.85),],
//                begin: Alignment.topCenter, end: Alignment.bottomCenter),
//            ),
//          ),
//          Container(
//            // padding: EdgeInsets.all(15),
//            child: Column(
//
//              children: <Widget>[
//                Container(
//                  alignment: Alignment.center,
//                  child: Stack(
//                    children: <Widget>[
//                      Container(
//                          height: 100,
//                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(50.0),
//                            child: Image.asset( "images/default.png", fit: BoxFit.cover,),
//                          )),
//                    ],
//                  ),
//                ),
//                SizedBox(height: 10),
//                Container(
//                  alignment: Alignment.center,
//                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//                  child: Text(
//                    "Hoorain Lucas",
//                    style: TextStyle(fontSize: FSTextStyle.h4size, fontFamily: 'Gilroy-bold', color: FsColor.basicprimary,),
//                  ),
//                ),
//                Container(
//                  alignment: Alignment.center,
//                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                  child: Text(
//                    "Maid",
//                    style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.lightgrey,),
//                  ),
//                ),
//                SizedBox(height: 10),
//                Container(
//                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5) ,
//                  decoration: BoxDecoration(
//                    border: Border(
//                      top: BorderSide(width: 1.0, color: FsColor.darkgrey.withOpacity(0.2)),
//                      bottom: BorderSide(width: 1.0, color: FsColor.darkgrey.withOpacity(0.2)),
//                    ),
//                  ),
//                  child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Container(
//                      child: Column(
//
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Icon(Icons.star, size: FSTextStyle.h5size, color: FsColor.yellow,),
//                              SizedBox(width: 5),
//                              Text('5.0',
//                              style: TextStyle( fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h5size, color: FsColor.basicprimary,),
//                              ),
//                            ],
//                          ),
//                          SizedBox(height: 5),
//                          Text('Ratings',
//                          style: TextStyle( fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h7size, color: FsColor.lightgrey),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      child: GestureDetector(
//                      child: FlatButton(
//                      child: Column(
//
//                        children: <Widget>[
//                          Icon(FlutterIcon.phone_1, size: FSTextStyle.h4size, color: FsColor.primaryvisitor,),
//                          SizedBox(height: 5),
//                          Text('Call',
//                          style: TextStyle( fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h7size, color: FsColor.lightgrey),
//                          ),
//                        ],
//                      ),
//                      onPressed: (){},
//                      ),
//                    ),
//                    ),
//
//                    Container(
//                      child: Column(
//                        children: <Widget>[
//                          Text('2/31',
//                            style: TextStyle( fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h5size, color: FsColor.basicprimary,),
//                          ),
//                          SizedBox(height: 5),
//                          Text('Attendence',
//                          style: TextStyle( fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h7size, color: FsColor.lightgrey),
//                          ),
//                        ],
//                      ),
//                    ),
//
//                  ],
//                ),
//
//                ),
//
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
//                  alignment: Alignment.topLeft,
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                        child: Text(
//                        "Today's Logs".toLowerCase(),
//                        style: TextStyle(fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold', color: FsColor.basicprimary, height: 1.2,),
//                        textAlign: TextAlign.left
//                      ),
//                      ),
//
//                      ListTile(
//                        dense: true,
//                        contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                        title: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                          Text('Not Yet Entered',
//                          style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey, height: 1.2,),
//                          ),
//                          Container(
//                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                            decoration: BoxDecoration(
//                              color: FsColor.darkgrey,
//                              borderRadius: BorderRadius.circular(4),
//                            ),
//                            child: Text('Inside'.toUpperCase(),
//                            style: TextStyle(fontSize: FSTextStyle.h7size, fontFamily: 'Gilroy-SemiBold', color: FsColor.white,),
//                            ),
//                          ),
//                          ],
//                        ),
//                        trailing: Icon(FlutterIcon.angle_right, size: FSTextStyle.h4size, color: FsColor.darkgrey,),
//                        onTap: (){},
//                      ),
//                      ListTile(
//                        dense: true,
//                        contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                        title: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                        Text('Given Items',
//                        style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey, height: 1.2,),
//                        ),
//
//                        Text('View All',
//                        style: TextStyle( fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold',)
//                        ),
//
//
//                          ],
//                        ),
//                        trailing: Icon(FlutterIcon.angle_right, size: FSTextStyle.h4size, color: FsColor.darkgrey,),
//                        onTap: (){},
//                      ),
//
//                    ],
//                  ),
//                ),
//
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                  alignment: Alignment.topLeft,
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                        child: Text(
//                        "Rating & Review".toLowerCase(),
//                        style: TextStyle(fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold', color: FsColor.basicprimary, height: 1.2,),
//                        textAlign: TextAlign.left
//                      ),
//                      ),
//
//
//                      Container(
//                        child: Row(
//                          children: <Widget>[
//
//
//                          ],
//                        ),
//                      ),
//
//
//
//
//                    ],
//                  ),
//                ),
//
//
//
//              ],
//            ),
//          ),
//
//
//
//
//              ],
//            ),
//          ),
//          // Column(
//          //   children: <Widget>[
//
//
//              // Container(
//              //   height: 100,
//              //   decoration: BoxDecoration(
//              //     borderRadius: BorderRadius.only(
//              //         bottomLeft: Radius.circular(50.0),
//              //         bottomRight: Radius.circular(50.0)),
//              //     gradient: LinearGradient(
//              //         colors: [
//              //           FsColor.primaryvisitor,
//              //           FsColor.primaryvisitor.withOpacity(0.85),
//              //         ],
//              //         begin: Alignment.topCenter,
//              //         end: Alignment.bottomCenter)),
//              // ),
//
//              // Container(
//              //   transform: Matrix4.translationValues(0.0, -60.0, 0.0),
//              //   height: 120,
//              //   child: ClipRRect(
//              //     borderRadius: BorderRadius.circular(60.0),
//              //     child: Image.asset("images/default.png",fit: BoxFit.cover,),
//              //   ),
//              // ),
//
//              // SizedBox(height: 5.0),
//              //   Container(
//              //     padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
//              //     child: Column(children: <Widget>[
//              //       Text(
//              //         "Hoorain Lucas",
//              //         style: TextStyle(
//              //           fontSize: FSTextStyle.h4size,
//              //           fontFamily: 'Gilroy-bold',
//              //         ),
//              //       ),
//              //     ]),
//              //   ),
//
//
//
//          //   ],
//          // ),
//
//
//
//
//
//
//    );
//  }
//}
