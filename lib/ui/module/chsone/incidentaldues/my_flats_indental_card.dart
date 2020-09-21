import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/incident/incidentallist.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyFlatsIncidental extends StatefulWidget {
  var flatsIncidental;

  Function onInit;

  var currentUnit;

  MyFlatsIncidental(this.flatsIncidental, this.currentUnit, {this.onInit});

  @override
  _MyFlatsIncidentalState createState() => new _MyFlatsIncidentalState(
      this.flatsIncidental, this.currentUnit, onInit);
}

class _MyFlatsIncidentalState extends State<MyFlatsIncidental> {
  var flatsIncidental;
  bool isFlatsIncidental = false;

  Function onInit;

  var currentUnit;

  _MyFlatsIncidentalState(this.flatsIncidental, this.currentUnit, this.onInit);

  @override
  void initState() {
    print("Inside Maintenance......111111 " + flatsIncidental.toString());
    setState(() {
      initializeData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeData();
    return GestureDetector(child:
    new Container(
        child: Column(
      children: <Widget>[
        !isFlatsIncidental
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
                                "Incidental Dues".toLowerCase(),
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
                              /* RaisedButton(
                                elevation: 1.0,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(4.0),
                                ),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PayOnlineStepper(
                                            currentUnit,
                                            dueAmount: flatsIncidental)),
                                  ),
                                },
                                color: FsColor.primaryflat,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Text(
                                  "Pay Now",
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-Bold',
                                      color: FsColor.white),
                                ),
                              ),*/
                              Container(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(FlutterIcon.rupee,
                                          size: FSTextStyle.h4size,
                                          color: FsColor.darkgrey),
                                      Text(
                                        flatsIncidental == null
                                            ? ""
                                            : flatsIncidental[
                                        "total_due"] ==
                                                    null
                                                ? ""
                                                : flatsIncidental[
                                        "total_due"]
                                                    .toString(),
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
                                        "Due on : ".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(
                                        flatsIncidental == null
                                            ? ""
                                            : flatsIncidental["due_date"] ==
                                                    null
                                                ? ""
                                                : flatsIncidental["due_date"],
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
                                  /* Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Advances : ".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                    ),
                                    Icon(FlutterIcon.rupee,
                                        size: FSTextStyle.h6size,
                                        color: FsColor.darkgrey),
                                    Text(
                                      flatsIncidental == null
                                          ? ""
                                          : flatsIncidental["advances"] ==
                                          null
                                          ? ""
                                          : flatsIncidental["advances"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                ),*/
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
                              Container(),
                              /*  Container(
                                child: FlatButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(4.0),
                                  ),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PayAlreadyStapper(currentUnit,
                                                  flatsIncidental)),
                                    ),
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Already Paid?",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Bold',
                                            color: FsColor.darkgrey),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(FlutterIcon.right_big,
                                          color: FsColor.darkgrey,
                                          size: FSTextStyle.h6size),
                                    ],
                                  ),
                                ),
                              ),*/
                              Container(
                                child: GestureDetector(
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IncidentalList(currentUnit)),
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
        isFlatsIncidental
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
                                "Incidental Dues".toLowerCase(),
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
                              /*RaisedButton(
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
                                          PayOnlineStepper(currentUnit)),
                                ),
                              },
                              color: FsColor.primaryflat,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                "Pay Advance",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-Bold',
                                    color: FsColor.white),
                              ),
                            ),*/
                              Container(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "no due pending",
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
                                  /*  Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Advances : ".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                    ),
                                    Icon(FlutterIcon.rupee,
                                        size: FSTextStyle.h6size,
                                        color: FsColor.darkgrey),
                                    Text(
                                      flatsIncidental == null
                                          ? ""
                                          : flatsIncidental["advances"] ==
                                          null
                                          ? ""
                                          : flatsIncidental["advances"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                ),*/
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
                                  /*child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(4.0),
                                ),
                                onPressed: () =>
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PayAlreadyStapper(currentUnit,
                                                flatsIncidental)),
                                  ),
                                },
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Already Paid?",
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-Bold',
                                          color: FsColor.darkgrey),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(FlutterIcon.right_big,
                                        color: FsColor.darkgrey,
                                        size: FSTextStyle.h6size),
                                  ],
                                ),
                              ),*/
                                  ),
                              Container(
                                child: GestureDetector(
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IncidentalList(currentUnit)),
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
        )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  IncidentalList(currentUnit)),
        );
      },);
  }

  void initializeData() {
    if (flatsIncidental != null) {
      if (flatsIncidental["total_due"] != null &&
          flatsIncidental["total_due"] > 0) {
        isFlatsIncidental = true;
      }
    }
  }

  @override
  onUbdate() {
    setState(() {
      try {
        if (flatsIncidental != null) {
          //double amount = flatsMaintenance["total_due_amount"] as double;
          if (flatsIncidental["total_due"] != null &&
              flatsIncidental["total_due"] > 0) {
            isFlatsIncidental = true;
          }
        }
      } catch (e) {
        e.toString();
      }
    });
  }
}
