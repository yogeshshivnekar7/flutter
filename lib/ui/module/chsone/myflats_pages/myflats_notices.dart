import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/notices/notices_details.dart';
import 'package:sso_futurescape/ui/module/chsone/notices/notices_list.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyFlatsNotices extends StatefulWidget {
  var flatsNotices;
  var currentUnit;
  var noticeType;

  MyFlatsNotices(this.flatsNotices, this.currentUnit, this.noticeType);

  @override
  _MyFlatsNoticesState createState() =>
      new _MyFlatsNoticesState(
          this.flatsNotices, this.currentUnit, this.noticeType);
}

class _MyFlatsNoticesState extends State<MyFlatsNotices> {
  var flatsNotices;
  bool isFlatsNotices = false;
  var currentUnit;
  var noticeType;

  _MyFlatsNoticesState(this.flatsNotices, this.currentUnit, this.noticeType);

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child:
    new Container(
        child: Column(
      children: <Widget>[
        !isFlatsNotices
            ? Container()
            : Container(
          child: Card(
            elevation: 3.0,
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
                          "Notices/announcement".toLowerCase(),
                          style: TextStyle(
                              fontSize: FSTextStyle.dashtitlesize,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.primaryflat),
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
                          onPressed: () =>
                          {
                            // AppUtils.showComminigSoonToast(context)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoticesDetails(flatsNotices['id'])
                              ),
                            ),
                          },
                          color: FsColor.primaryflat,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "View",
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-Bold',
                                color: FsColor.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(

                                  flatsNotices == null
                                      ? "No Notice"
                                      : flatsNotices["subject"] == null
                                      ? "No Notice"
                                      : flatsNotices["subject"],
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                ),
                              ],
                            )),
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
                                "Date : ".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.lightgrey),
                              ),
                              Text(
                                flatsNotices == null
                                    ? ""
                                    : flatsNotices["published_on"] == null
                                    ? ""
                                    : flatsNotices["published_on"],
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              ),
                            ],
                          ),
                        ),
                        Container(
//                          child: GestureDetector(
                            child: FlatButton(
                              onPressed: () {
                                // AppUtils.showComminigSoonToast(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      NoticesList(
                                          currentUnit,
                                          NOTICE_TYPE.ALL,"Notices/announcement")),
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
//                            ),
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
        isFlatsNotices
            ? Container()
            : Container(
          child: Card(
            elevation: 3.0,
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
                          "Notices/announcement".toLowerCase(),
                          style: TextStyle(
                              fontSize: FSTextStyle.dashtitlesize,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.primaryflat),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
//                        RaisedButton(
//                          elevation: 1.0,
//                          shape: new RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(4.0),
//                          ),
//                          onPressed: null,
//                          color: FsColor.primaryflat,
//                          padding: EdgeInsets.symmetric(
//                              vertical: 10.0, horizontal: 10.0),
//                          child: Text(
//                            "View",
//                            style: TextStyle(
//                                fontSize: FSTextStyle.h6size,
//                                fontFamily: 'Gilroy-Bold',
//                                color: FsColor.white),
//                          ),
//                        ),
                        SizedBox(width: 10),
                        Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "no notices".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                ),
                              ],
                            )),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: GestureDetector(
                            child: FlatButton(
                              onPressed: () {
                                // AppUtils.showComminigSoonToast(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      NoticesList(
                                          currentUnit,
                                          NOTICE_TYPE.ALL,
                                          "Notices/announcement")),
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
      ],
        )), onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            NoticesList(
                currentUnit,
                NOTICE_TYPE.ALL,
                "Notices/announcement")),
      );
    },);
  }

  void initializeData() {
    if (flatsNotices != null && flatsNotices["subject"] != null) {
      isFlatsNotices = true;
    }
  }
}
