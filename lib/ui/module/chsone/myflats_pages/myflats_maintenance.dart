import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/myflats_maintenencelist.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/allreadypaid/PayAlreadyStapper.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/onlinepaid/pay_online_stepper.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyFlatsMaintenance extends StatefulWidget {
  var flatsMaintenance;

  Function onInit;

  var currentUnit;

  MyFlatsMaintenance(this.flatsMaintenance, this.currentUnit, {this.onInit});

  @override
  _MyFlatsMaintenanceState createState() =>
      new _MyFlatsMaintenanceState(
          this.flatsMaintenance, this.currentUnit, onInit);
}

class _MyFlatsMaintenanceState extends State<MyFlatsMaintenance> {
  var flatsMaintenance;
  bool isMaintenanceDue = false;

  Function onInit;

  var currentUnit;

  _MyFlatsMaintenanceState(this.flatsMaintenance, this.currentUnit,
      this.onInit);

  @override
  void initState() {
    print("Inside Maintenance......111111 " + flatsMaintenance.toString());
    setState(() {
      initializeData();
    });
    // onInit(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeData();
    return GestureDetector(child:
    new Container(
        child: Column(
          children: <Widget>[
            !isMaintenanceDue
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
                              "Maintenance Due".toLowerCase(),
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
                              onPressed: ()
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PayOnlineStepper(
                                              currentUnit,
                                              dueAmount: flatsMaintenance))
                                );
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
                            ),
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
                                      flatsMaintenance == null
                                          ? ""
                                          : flatsMaintenance[
                                      "total_due_amount"] ==
                                          null
                                          ? ""
                                          : flatsMaintenance[
                                      "total_due_amount"]
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
                                      flatsMaintenance == null
                                          ? ""
                                          : flatsMaintenance["due_date"] ==
                                          null
                                          ? ""
                                          : flatsMaintenance["due_date"],
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
                                      flatsMaintenance == null
                                          ? ""
                                          : flatsMaintenance["advances"] ==
                                          null
                                          ? ""
                                          : flatsMaintenance["advances"]
                                          .toString(),
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
                              child: FlatButton(
                                color: FsColor.green,
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
                                                flatsMaintenance)),
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
                                          color: FsColor.white),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(FlutterIcon.right_big,
                                        color: FsColor.white,
                                        size: FSTextStyle.h6size),
                                  ],
                                ),
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
                                              MyFlatsMaintenenceList(
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
            isMaintenanceDue
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
                              "Maintenance Due".toLowerCase(),
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
                            ),
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
                                Row(
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
                                      flatsMaintenance == null
                                          ? ""
                                          : flatsMaintenance["advances"] ==
                                          null
                                          ? ""
                                          : flatsMaintenance["advances"]
                                          .toString(),
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
                              child: FlatButton(
                                color: FsColor.green,
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
                                                flatsMaintenance)),
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
                                          color: FsColor.white),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(FlutterIcon.right_big,
                                        color: FsColor.white,
                                        size: FSTextStyle.h6size),
                                  ],
                                ),
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
                                              MyFlatsMaintenenceList(
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
          ],
        )), onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyFlatsMaintenenceList(
                    currentUnit)),
      );
    },);
  }

  void initializeData() {
    if (flatsMaintenance != null) {
      if (flatsMaintenance["total_due_amount"] != null &&
          flatsMaintenance["total_due_amount"] > 0) {
        isMaintenanceDue = true;
      }
    }
  }

  @override
  onUbdate() {
    setState(() {
      try {
        if (flatsMaintenance != null) {
          //double amount = flatsMaintenance["total_due_amount"] as double;
          if (flatsMaintenance["total_due_amount"] != null &&
              flatsMaintenance["total_due_amount"] > 0) {
            isMaintenanceDue = true;
          }
        }
      } catch (e) {
        e.toString();
      }
    });
  }
}
