import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_view.dart';
import 'package:sso_futurescape/ui/module/vizlog/visitors/visitors_list.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class MyVisitorsVisitor extends StatefulWidget {
  @override
  _MyVisitorsVisitorState createState() => new _MyVisitorsVisitorState();
}

class _MyVisitorsVisitorState extends State<MyVisitorsVisitor>
    implements VizLoginView {
  List visitors;

  VizlogLoginPresentor vizLoginPresentor;

  _MyVisitorsVisitorState() {
    vizLoginPresentor = new VizlogLoginPresentor(this);
    getUnitDetails();
  }

  void getUnitDetails() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
      if (unit == null) {
        setState(() {});
      } else {
        vizLoginPresentor.getVisitors(
            unit["soc_id"].toString(), unit["unit_id"].toString(),
            isForToday: true, memberId: unit["member_id"]);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyVisitorsList()),
          );
        },
        child: new Container(
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
                                "My Visitors".toLowerCase(),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      visitors == null
                                          ? "no visitors for today"
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
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    getInTIme() == null
                                        ? Container()
                                        : Container(
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
                                          visitors == null
                                          /*||
                                              visitors.length <= 0*/
                                              ? Container()
                                              : Text(
                                            AppUtils.getTime(
                                                getInTIme().toString()),
//                                        "12:15",
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h6size,
                                                fontFamily:
                                                'Gilroy-SemiBold',
                                                color:
                                                FsColor.darkgrey),
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
                                            visitors == null
                                            /*||
                                                visitors.length <= 0*/
                                                ? Container()
                                                : Text(
                                              getOutTime() == null
                                                  ? ""
                                                  : AppUtils.getTime(
                                                  getOutTime().toString()),
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
                            ) /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    visitors == null
                                        ? "no visitors for today"
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
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  getInTIme() == null
                                      ? Container()
                                      : Container(
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
                                        visitors == null
                                        */ /*||
                                              visitors.length <= 0*/ /*
                                            ? Container()
                                            : Text(
                                          AppUtils.getTime(
                                              getInTIme().toString()),
//                                        "12:15",
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle.h6size,
                                              fontFamily:
                                              'Gilroy-SemiBold',
                                              color:
                                              FsColor.darkgrey),
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
                                          visitors == null
                                          */ /*||
                                                visitors.length <= 0*/ /*
                                              ? Container()
                                              : Text(
                                            getOutTime() == null
                                                ? ""
                                                : AppUtils.getTime(
                                                getOutTime().toString()),
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
                      ),*/
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                          decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0,
                                    color: FsColor.basicprimary.withOpacity(
                                        0.2)),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              visitors == null /*|| visitors.length<=0*/
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyVisitorsList()),
                                      );
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
            /* Container(
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
                          "My Visitors".toLowerCase(),
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
                                  "no visitor yet",
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
        )));
  }

  getInTIme() =>
      visitors == null /*|| visitors.length <= 0 */
          ? null
          : visitors[0]["in_time"];

  getOutTime() =>
      visitors == null /*|| visitors.length <= 0 */
          ? null
          : visitors[0]["out_time"];

  getLastName() =>
      visitors == null /* || visitors.length <= 0*/
          ? null
          : visitors[0]["visitors"]["last_name"] == null
          ? ""
          : " " + visitors[0]["visitors"]["last_name"];

  @override
  error(error) {
    Toasly.error(context, error.toString());
  }

  @override
  failure(failed) {
    Toasly.error(context, failed.toString());
  }

  @override
  loginSuccess(success) {
    // TODO: implement loginSuccess
    return null;
  }

  @override
  visitorSuccess(success) {
    setState(() {
      visitors = success["data"]["results"];
      if (visitors == null || visitors.length <= 0) {
        print("------------visitorSuccess  ---------------");
        visitors = null;
      }
    });
  }
}
