import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/complaints/myflats_complaintadd.dart';
import 'package:sso_futurescape/ui/module/chsone/complaints/myflats_complaintslist.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyFlatsComplaints extends StatefulWidget {
  var flatsComplaints;

  var currentUnit;

  MyFlatsComplaints(this.flatsComplaints, this.currentUnit);

  @override
  _MyFlatsComplaintsState createState() =>
      new _MyFlatsComplaintsState(this.flatsComplaints, this.currentUnit);
}

class _MyFlatsComplaintsState extends State<MyFlatsComplaints> {
  var flatsComplaints;
  bool isFlatsComplaints = false;

  var currentUnit;

  _MyFlatsComplaintsState(this.flatsComplaints, this.currentUnit);

  @override
  void initState() {
    print("cureeeeeent unit =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..");
    print(currentUnit['unit_id']);
    print(flatsComplaints);
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: new Container(
        child: Column(
      children: <Widget>[
        !isFlatsComplaints
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
                          "Complaints".toLowerCase(),
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
                                      MyFlatsComplaintsAdd(
                                          this.currentUnit)),
                            ),
                          },
                          color: FsColor.primaryflat,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "Post",
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
                                  flatsComplaints == null
                                      ? ""
                                      : flatsComplaints[
                                  "ticket_number"] ==
                                      null
                                      ? ""
                                      : "#" +
                                      flatsComplaints[
                                      "ticket_number"],
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h4size,
                                      fontFamily: 'Gilroy-Bold',
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
                                  "Date : ".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                ),
                                Text(
                                  flatsComplaints == null
                                      ? ""
                                      : flatsComplaints["created_date"] ==
                                      null
                                      ? ""
                                      : flatsComplaints[
                                  "created_date"],
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
                                "Status : ".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.lightgrey),
                              ),
                              Text(
                                flatsComplaints == null
                                    ? ""
                                    : flatsComplaints["status"] == null
                                    ? ""
                                    : flatsComplaints["status"],
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
                                          MyFlatsComplaintsList(
                                              currentUnit)),
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
        isFlatsComplaints
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
                          "Complaints".toLowerCase(),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyFlatsComplaintsAdd(
                                          this.currentUnit)),
                            );
                          },
                          color: FsColor.primaryflat,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "Post",
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
                                  "no recent complaints",
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
                  /*  Container(
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
                                AppUtils.showComminigSoonToast(context);
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
                  ),*/
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
      if (isFlatsComplaints) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyFlatsComplaintsList(
                      currentUnit)),
        );
      }
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                MyFlatsComplaintsAdd(
//                    this.currentUnit)),
//      );
    },);
  }

  void initializeData() {
    if (flatsComplaints != null && flatsComplaints["ticket_number"] != null) {
      isFlatsComplaints = true;
    }
  }
}
