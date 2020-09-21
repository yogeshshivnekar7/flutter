import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/notices/notices_details.dart';
import 'package:sso_futurescape/ui/module/chsone/notices/notices_list.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyFlatsAnnouncement extends StatefulWidget {
  var flatsAnnouncement;
  var currentUnit;
  var noticeType;

  MyFlatsAnnouncement(this.flatsAnnouncement, this.currentUnit,
      this.noticeType);

  @override
  _MyFlatsAnnouncementState createState() =>
      new _MyFlatsAnnouncementState(
          this.flatsAnnouncement, this.currentUnit, this.noticeType);
}

class _MyFlatsAnnouncementState extends State<MyFlatsAnnouncement> {
  var flatsAnnouncement;
  bool isFlatsAnnouncements = false;
  var currentUnit;
  var noticeType;

  _MyFlatsAnnouncementState(this.flatsAnnouncement, this.currentUnit,
      this.noticeType);

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
      children: <Widget>[
        !isFlatsAnnouncements
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
                          "announcements".toLowerCase(),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoticesDetails(flatsAnnouncement['id'])
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
                                  flatsAnnouncement == null
                                      ? ""
                                      : flatsAnnouncement["subject"] == null
                                      ? ""
                                      : flatsAnnouncement["subject"],
                                  textAlign: TextAlign.end,
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
                                flatsAnnouncement == null
                                    ? ""
                                    : flatsAnnouncement["published_on"] ==
                                    null
                                    ? ""
                                    : flatsAnnouncement[
                                "published_on"],
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
                                  MaterialPageRoute(builder: (context) =>
                                      NoticesList(currentUnit, noticeType,
                                          NOTICE_TYPE.ANNOUNCEMENT)),
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
        isFlatsAnnouncements
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
                          "announcements".toLowerCase(),
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
                          onPressed: null,
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
                                  "no announcement".toLowerCase(),
                                  textAlign: TextAlign.end,
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
                              onPressed: null,
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

  void initializeData() {
    if (flatsAnnouncement != null && flatsAnnouncement["subject"] != null) {
      isFlatsAnnouncements = true;
    }
  }
}
