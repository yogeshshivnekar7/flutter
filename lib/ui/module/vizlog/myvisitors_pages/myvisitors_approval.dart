import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyVisitorsApproval extends StatefulWidget {
  @override
  _MyVisitorsApprovalState createState() => new _MyVisitorsApprovalState();
}

class _MyVisitorsApprovalState extends State<MyVisitorsApproval> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                elevation: 1.0,
                key: null,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/dash-bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        width: 1.0, color: FsColor.darkgrey.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "My Approvals".toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.dashtitlesize,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.primaryvisitor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    child: GestureDetector(
                                      child: RaisedButton(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        shape: new CircleBorder(),
                                        onPressed: () => {},
                                        color: FsColor.primaryvisitor,
                                        child: Icon(FlutterIcon.ok,
                                            color: FsColor.white,
                                            size: FSTextStyle.h5size),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    child: GestureDetector(
                                      child: RaisedButton(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        shape: new CircleBorder(),
                                        onPressed: () => {},
                                        color: FsColor.primaryvisitor,
                                        child: Icon(FlutterIcon.cancel_1,
                                            color: FsColor.white,
                                            size: FSTextStyle.h5size),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Rehaan Stokes",
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Painter",
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: FsColor.basicprimary.withOpacity(0.2)),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Approval Pending : ".toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.lightgrey),
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "View All",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                      SizedBox(width: 10.0),
                                      Icon(FlutterIcon.right_big,
                                          color: FsColor.darkgrey,
                                          size: FSTextStyle.h6size),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              alignment: Alignment.center,
            ),
            Container(
              child: Card(
                elevation: 1.0,
                key: null,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/dash-bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        width: 1.0, color: FsColor.darkgrey.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "My Approvals".toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.dashtitlesize,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.primaryvisitor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    child: GestureDetector(
                                      child: RaisedButton(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        shape: new CircleBorder(),
                                        onPressed: null,
                                        color: FsColor.primaryvisitor,
                                        child: Icon(FlutterIcon.ok,
                                            color: FsColor.white,
                                            size: FSTextStyle.h5size),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    child: GestureDetector(
                                      child: RaisedButton(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        shape: new CircleBorder(),
                                        onPressed: null,
                                        color: FsColor.primaryvisitor,
                                        child: Icon(FlutterIcon.cancel_1,
                                            color: FsColor.white,
                                            size: FSTextStyle.h5size),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "No approvals pending".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: FsColor.basicprimary.withOpacity(0.2)),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Approval Pending : ".toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.lightgrey),
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "View All",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                      SizedBox(width: 10.0),
                                      Icon(FlutterIcon.right_big,
                                          color: FsColor.darkgrey,
                                          size: FSTextStyle.h6size),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              alignment: Alignment.center,
            ),
          ],
        ));
  }
}
