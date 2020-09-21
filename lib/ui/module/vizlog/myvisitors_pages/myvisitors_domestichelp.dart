import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_view.dart';
import 'package:sso_futurescape/ui/module/vizlog/mydomestic_help/mydomestic_list.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class MyVisitorsDomesticHelp extends StatefulWidget {
  @override
  _MyVisitorsDomesticHelpState createState() =>
      new _MyVisitorsDomesticHelpState();
}

class _MyVisitorsDomesticHelpState extends State<MyVisitorsDomesticHelp>
    implements VizLoginView {
  VizlogLoginPresentor _vizLogPresenter;

  List visitors;

  _MyVisitorsDomesticHelpState() {
    _vizLogPresenter = VizlogLoginPresentor(this);
    getUnitDetails();
  }

  void getUnitDetails() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
      if (unit == null) {
        setState(() {});
      } else {
        setState(() {
          _vizLogPresenter.getStaff(
              unit["soc_id"].toString(), unit["unit_id"].toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: new Container(
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
                              "Domestic Help".toLowerCase(),
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
//                            RaisedButton(
//                              elevation: 1.0,
//                              shape: new RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(4.0),
//                              ),
//                              onPressed: () => {},
//                              color: FsColor.primaryvisitor,
//                              padding: EdgeInsets.symmetric(
//                                  vertical: 10.0, horizontal: 10.0),
//                              child: Text(
//                                "View",
//                                style: TextStyle(
//                                    fontSize: FSTextStyle.h6size,
//                                    fontFamily: 'Gilroy-Bold',
//                                    color: FsColor.white),
//                              ),
//                            ),
                            Container(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      visitors == null
                                          ? "no domestic help"
                                          : visitors[0]["visitors"]["first_name"] +
                                          getLastName(),
//                                  "Darrel Woodward",
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                ),
                                visitors == null
                                    ? Container()
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
//                                    Text(
//                                      "Maid",
//                                      style: TextStyle(
//                                          fontSize: FSTextStyle.h6size,
//                                          fontFamily: 'Gilroy-SemiBold',
//                                          color: FsColor.lightgrey),
//                                    ),
                                    Container(),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                visitors == null
                                    ? Container()
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'images/in.png',
                                            fit: BoxFit.contain,
                                            width: 20.0,
                                            height: 20.0,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            AppUtils.getTime(getInTIme()),
//                                        "12:15",
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                        child: Row(
                                          children: <Widget>[
                                            getOutTime() == null
                                                ? Container()
                                                : Image.asset(
                                              'images/out.png',
                                              fit: BoxFit.contain,
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              AppUtils.getTime(getOutTime()),
//                                      "14:22",
                                              style: TextStyle(
                                                  fontSize: FSTextStyle.h6size,
                                                  fontFamily: 'Gilroy-SemiBold',
                                                  color: FsColor.darkgrey),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
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
                            // Container(
                            //   child: FlatButton(
                            //     shape: new RoundedRectangleBorder(
                            //       borderRadius: new BorderRadius.circular(4.0),
                            //     ),
                            //     onPressed: () => {
                            //       _showGiveSomethingDialog(),
                            //     },
                            //     padding: EdgeInsets.symmetric(
                            //         vertical: 10.0, horizontal: 10.0),
                            //     child: Row(
                            //       children: <Widget>[
                            //         Text(
                            //           "Give Something",
                            //           style: TextStyle(
                            //               fontSize: FSTextStyle.h6size,
                            //               fontFamily: 'Gilroy-Bold',
                            //               color: FsColor.darkgrey),
                            //         ),
                            //         SizedBox(width: 5),
                            //         Icon(FlutterIcon.right_big,
                            //             color: FsColor.darkgrey,
                            //             size: FSTextStyle.h6size),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            visitors == null
                                ? Container()
                                : Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Duration : ".toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.lightgrey),
                                  ),
                                  Text(
                                    AppUtils.getTimeDiff(
                                        getInTIme(), getOutTime()),
//                                "2hrs 7min",
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
                                  onPressed: () {
                                    FsNavigator.push(
                                        context, MyDomesticHelpList());
                                  },
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
            /*  Container(
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
                              "Domestic Help".toLowerCase(),
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
                            RaisedButton(
                              elevation: 1.0,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              onPressed: () => {},
                              color: FsColor.primaryvisitor,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-Bold',
                                    color: FsColor.white),
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
                                      "no domestic help",
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
                                  width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
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
            ),*/
          ],
        )), onTap: () {
      FsNavigator.push(
          context, MyDomesticHelpList());
    },);
  }

  void _showGiveSomethingDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: Container(
              height: 450.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 72,
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 10.0, bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        'images/default.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: new Text(
                      "Name Comes Here".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h4size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new Text(
                      "i have given a item to <Darrel Woodward>, my <maid> allow him/her to exit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h5size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.darkgrey),
                          // hintStyle: ,
                          labelText: 'Enter Items'.toLowerCase(),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: FsColor.basicprimary))),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: FsColor.darkgrey,
                            width: 2.0,
                          ),
                          image: DecorationImage(
                            image: AssetImage("images/no-image.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 15.0, top: 10.0, bottom: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          // child: Image.asset('images/default.png',fit: BoxFit.cover,),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Upload a Photos of Items',
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h7size,
                              color: FsColor.lightgrey),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  @override
  error(error) {
    Toasly.error(context, error.toString());
  }

  @override
  failure(failed) {
    Toasly.error(context, failed.toString());
  }

  @override
  loginSuccess(success) {}

  @override
  visitorSuccess(success) {
    setState(() {
      visitors = success["data"]["results"];
      if (visitors == null || visitors.length <= 0) {
        visitors = null;
      }
    });
  }

  getInTIme() =>
      visitors == null || visitors.length <= 0 ? null : visitors[0]["in_time"];

  getOutTime() =>
      visitors == null || visitors.length <= 0 ? null : visitors[0]["out_time"];

  getLastName() =>
      visitors == null || visitors.length <= 0
          ? null
          : visitors[0]["visitors"]["last_name"] == null
          ? ""
          : " " + visitors[0]["visitors"]["last_name"];
}
