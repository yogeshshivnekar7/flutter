import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/my_business/hrms/attendance/attendance_presenter.dart';
import 'package:sso_futurescape/presentor/module/my_business/hrms/attendance/attendance_view.dart';
import 'package:sso_futurescape/presentor/module/my_business/hrms/hrms_login/hrms_login_presenter.dart';
import 'package:sso_futurescape/presentor/module/my_business/hrms/hrms_login/hrms_login_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => new _AttendanceState();
}

class _AttendanceState extends State<Attendance>
    implements HRMSLoginView, AttendanceView {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLoginHRMS();
  }

  Map punchedAttendance;
  bool isLoading = true;
  bool isAddress = false;
  PUNCH lastPunch;
  AttendancePresenter attendancePresenter;

  void autoLoginHRMS() {
    attendancePresenter = new AttendancePresenter(this);
    HRMSLoginPresenter loginPresenter = new HRMSLoginPresenter(this);
    loginPresenter.login_hrms();
    getLocationON();
  }

  Future getLocationON() async {
    var location = new Location();
    bool aa = (await location.hasPermission()) as bool;
    if (aa == true) {
      print('location1111111111111');
      LocationData currentLocation =
      await location.getLocation() as LocationData;
      print("Dipesh Jain");
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      if (currentLocation != null) {
        return true;
      } else {
        return false;
      }
      /*  location.getLocation().then((LocationData currentLocation) {
        
      });*/
    } else {
      location.requestPermission();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: FsColor.primarymybusiness,
        elevation: 0.0,
        title: Text(
          "attendance",
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
        /*actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            color: FsColor.white,
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],*/
      ),
      body: isLoading
          ? PageLoader()
          : punchedAttendance == null
          ? Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "${AppUtils.greeting()}!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontFamily: 'Gilroy-regular'),
              ),
              Text(
                "Let's begin with your today's activity",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontFamily: 'Gilroy-regular'),
              ),
            ],
          ))
          : SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 0.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: punchedAttendance == null
                    ? Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${AppUtils.greeting()}!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                              fontFamily: 'Gilroy-regular'),
                        ),
                      ],
                    ))
                    : Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Container(
                          padding:
                          EdgeInsets.fromLTRB(0, 13, 0, 13),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              ListTile(
                                title: Container(
                                  child: !isAddress
                                      ? Container()
                                      : Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "images/location-pin.png",
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Cyber One, Vashi",
                                        textAlign:
                                        TextAlign
                                            .right,
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize:
                                            15.0,
                                            fontFamily:
                                            'Gilroy-regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                leading: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(
                                        50.0),
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppUtils.getConvertDate(
                                          punchedAttendance[
                                          'punch_in'],
                                          date_to_formate:
                                          'hh:mm a'),
                                      textAlign:
                                      TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          fontFamily:
                                          'Gilroy-bold'),
                                    ),
                                  ),
                                ),
                                trailing: Container(
                                  width: 130.0,
                                  height: 25.0,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "total :",
                                        textAlign:
                                        TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        AppUtils.getTimeDiff(
                                            punchedAttendance[
                                            'punch_in'],
                                            punchedAttendance[
                                            'punch_out'] ==
                                                null
                                                ? AppUtils
                                                .getTimeStamp()
                                                : punchedAttendance[
                                            'punch_out']),
                                        textAlign:
                                        TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontFamily:
                                            'Gilroy-bold'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            transform:
                            Matrix4.translationValues(
                                0.0, -97.0, 90.0),
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(
                                10, 0, 10, 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  AppUtils.getCurrentDate(
                                      date_format: 'EEEE'),
                                  style: TextStyle(
                                      fontFamily:
                                      "Gilroy-regular",
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  AppUtils.getCurrentDate(
                                      date_format:
                                      'dd-MM-yyyy'),
                                  style: TextStyle(
                                      fontFamily: "Gilroy-bold",
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Container(
                      //       margin: EdgeInsets.only(top: 10),
                      //       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      //       child: Row(
                      //         children: <Widget>[
                      //           Image.asset("images/morning-sun.png", fit: BoxFit.cover,),
                      //           SizedBox(width: 6,),
                      //           Text("Good Morning !", style: TextStyle(fontFamily: "Gilroy-regular", fontSize: 17),),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Card(
                        child: punchedAttendance == null
                            ? Container()
                            : Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Text(
                                        "      today's punch history",
                                        textAlign:
                                        TextAlign.center,
                                        style: TextStyle(
                                            color:
                                            Colors.black,
                                            fontSize: 10.0,
                                            fontFamily:
                                            'Gilroy-regular'),
                                      ),
                                    ],
                                  )),
                              punchedAttendance == null ||
                                  punchedAttendance[
                                  'punch_out'] ==
                                      null
                                  ? Container()
                                  : ListTile(
                                title: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: <
                                        Widget>[
                                      Container(
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Image
                                                .asset(
                                              "images/afternoon.png",
                                              fit: BoxFit
                                                  .cover,
                                            ),
                                            SizedBox(
                                              width:
                                              5,
                                            ),
                                            Text(
                                              "punch out",
                                              textAlign:
                                              TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontFamily: 'Gilroy-bold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      !isAddress
                                          ? Container()
                                          : Container(
                                        width:
                                        160.0,
                                        height:
                                        25.0,
                                        child:
                                        Row(
                                          children: <Widget>[
                                            Image.asset(
                                              "images/location-pin.png",
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Cyber One, Vashi",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily: 'Gilroy-regular'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: !isAddress
                                    ? Container()
                                    : Container(
                                  margin: EdgeInsets
                                      .only(
                                      top:
                                      5),
                                  child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                    style: TextStyle(
                                        fontFamily:
                                        "Gilroy-regular",
                                        color:
                                        Colors.grey),
                                  ),
                                ),
                                leading: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration:
                                  BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        50.0),
                                    border: Border.all(
                                        color: FsColor
                                            .primary,
                                        width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppUtils.getConvertDate(
                                          punchedAttendance[
                                          'punch_out'],
                                          date_to_formate:
                                          'hh:mm a'),
                                      textAlign:
                                      TextAlign
                                          .center,
                                      style: TextStyle(
                                          color: Colors
                                              .black,
                                          fontSize:
                                          13.0,
                                          fontFamily:
                                          'Gilroy-bold'),
                                    ),
                                  ),
                                ),
                              ), //Punch Out
                              punchedAttendance == null ||
                                  punchedAttendance[
                                  'break_out'] ==
                                      null
                                  ? Container()
                                  : ListTile(
                                title: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: <
                                        Widget>[
                                      Container(
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Image
                                                .asset(
                                              "images/afternoon.png",
                                              fit: BoxFit
                                                  .cover,
                                            ),
                                            SizedBox(
                                              width:
                                              5,
                                            ),
                                            Text(
                                              "break out",
                                              textAlign:
                                              TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontFamily: 'Gilroy-bold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      !isAddress
                                          ? Container()
                                          : Container(
                                        width:
                                        160.0,
                                        height:
                                        25.0,
                                        child:
                                        Row(
                                          children: <Widget>[
                                            Image.asset(
                                              "images/location-pin.png",
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Cyber One, Vashi",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily: 'Gilroy-regular'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: !isAddress
                                    ? Container()
                                    : Container(
                                  margin: EdgeInsets
                                      .only(
                                      top:
                                      5),
                                  child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                    style: TextStyle(
                                        fontFamily:
                                        "Gilroy-regular",
                                        color:
                                        Colors.grey),
                                  ),
                                ),
                                leading: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration:
                                  BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        50.0),
                                    border: Border.all(
                                        color: FsColor
                                            .primary,
                                        width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppUtils.getConvertDate(
                                          punchedAttendance[
                                          'break_out'],
                                          date_to_formate:
                                          'hh:mm a'),
                                      textAlign:
                                      TextAlign
                                          .center,
                                      style: TextStyle(
                                          color: Colors
                                              .black,
                                          fontSize:
                                          13.0,
                                          fontFamily:
                                          'Gilroy-bold'),
                                    ),
                                  ),
                                ),
                              ), //Punch BreakOut
                              punchedAttendance == null ||
                                  punchedAttendance[
                                  'break_in'] ==
                                      null
                                  ? Container()
                                  : ListTile(
                                title: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: <
                                        Widget>[
                                      Container(
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Image
                                                .asset(
                                              "images/afternoon.png",
                                              fit: BoxFit
                                                  .cover,
                                            ),
                                            SizedBox(
                                              width:
                                              5,
                                            ),
                                            Text(
                                              "break in",
                                              textAlign:
                                              TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontFamily: 'Gilroy-bold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      !isAddress
                                          ? Container()
                                          : Container(
                                        width:
                                        160.0,
                                        height:
                                        25.0,
                                        child:
                                        Row(
                                          children: <Widget>[
                                            Image.asset(
                                              "images/location-pin.png",
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Cyber One, Vashi",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily: 'Gilroy-regular'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: !isAddress
                                    ? Container()
                                    : Container(
                                  margin: EdgeInsets
                                      .only(
                                      top:
                                      5),
                                  child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                    style: TextStyle(
                                        fontFamily:
                                        "Gilroy-regular",
                                        color:
                                        Colors.grey),
                                  ),
                                ),
                                leading: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration:
                                  BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        50.0),
                                    border: Border.all(
                                        color: FsColor
                                            .primary,
                                        width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppUtils.getConvertDate(
                                          punchedAttendance[
                                          'break_in'],
                                          date_to_formate:
                                          'hh:mm a'),
                                      textAlign:
                                      TextAlign
                                          .center,
                                      style: TextStyle(
                                          color: Colors
                                              .black,
                                          fontSize:
                                          13.0,
                                          fontFamily:
                                          'Gilroy-bold'),
                                    ),
                                  ),
                                ),
                              ), //Punch BreakIn
                              punchedAttendance == null ||
                                  punchedAttendance[
                                  'punch_in'] ==
                                      null
                                  ? Container()
                                  : ListTile(
                                title: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: <
                                        Widget>[
                                      Container(
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Image
                                                .asset(
                                              "images/afternoon.png",
                                              fit: BoxFit
                                                  .cover,
                                            ),
                                            SizedBox(
                                              width:
                                              5,
                                            ),
                                            Text(
                                              "punch in",
                                              textAlign:
                                              TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontFamily: 'Gilroy-bold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      !isAddress
                                          ? Container()
                                          : Container(
                                        width:
                                        160.0,
                                        height:
                                        25.0,
                                        child:
                                        Row(
                                          children: <Widget>[
                                            Image.asset(
                                              "images/location-pin.png",
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Cyber One, Vashi",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontFamily: 'Gilroy-regular'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: !isAddress
                                    ? Container()
                                    : Container(
                                  margin: EdgeInsets
                                      .only(
                                      top:
                                      5),
                                  child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                    style: TextStyle(
                                        fontFamily:
                                        "Gilroy-regular",
                                        color:
                                        Colors.grey),
                                  ),
                                ),
                                leading: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration:
                                  BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        50.0),
                                    border: Border.all(
                                        color: FsColor
                                            .primary,
                                        width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppUtils.getConvertDate(
                                          punchedAttendance[
                                          'punch_in'],
                                          date_to_formate:
                                          'hh:mm a'),
                                      textAlign:
                                      TextAlign
                                          .center,
                                      style: TextStyle(
                                          color: Colors
                                              .black,
                                          fontSize:
                                          13.0,
                                          fontFamily:
                                          'Gilroy-bold'),
                                    ),
                                  ),
                                ),
                              ), //Punch In
                            ],
                          ),
                        ),
                      ),

                      // Positioned(
                      //   bottom: 0,
                      //   child: TextField(style: TextStyle(fontFamily: 'Gilroy-Regular',),
                      //     decoration: InputDecoration(
                      //       hintText: 'Write your reason here ...'
                      //     ),
                      //   ),
                      // ),

                      /*Align(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          style: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                          ),
                          decoration: InputDecoration(
                              hintText: 'Write your reason here ...'),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isLoading
          ? new Container(height: 60.0)
          : new Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /* FlatButton(
              color: Colors.grey,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                onPressButton(PUNCH.BREAK_IN);
              },
              child: Text(
                "BREAK IN",
                style: TextStyle(fontFamily: "Gilroy-bold"),
              ),
            ),
            SizedBox(
              width: 10,
            ),*/
            punchedAttendance != null &&
                punchedAttendance['punch_out'] != null
                ? Container(
              child: Text(
                "Thank You!\nToday's Actviity Completed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: FSTextStyle.h4size,
                    fontFamily: "Gilroy-regular",
                    color: Colors.green),
              ),
            )
                : FlatButton(
              color: FsColor.basicprimary,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                buttonClick(context);
              },
              child: Text(
                getButtonTitle(),
                style: TextStyle(fontFamily: "Gilroy-bold"),
              ),
            ),
          ],
        ),
        height: 60.0,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> buttonClick(BuildContext context) async {
    if (await getLocationON() == true) {
      print('--------------Punch---------');
      PUNCH type;
      if (punchedAttendance == null) {
        type = PUNCH.PUNCH_IN;
      }
      /*else if (punchedAttendance['break_in'] == null &&
              punchedAttendance['break_out'] == null &&
              punchedAttendance['punch_out'] == null) {
            type = PUNCH.BREAK_IN;
          } else if (punchedAttendance['break_in'] != null &&
              punchedAttendance['break_out'] == null &&
              punchedAttendance['punch_out'] == null) {
            type = PUNCH.BREAK_OUT;
          } */
      else
        /*if (punchedAttendance['break_in'] != null &&
              punchedAttendance['break_out'] != null &&
              punchedAttendance['punch_out'] == null)*/ {
        type = PUNCH.PUNCH_OUT;
      }
      print('--------------Punch---------');
      print('--------------Punch$type---------');
      onPressButton(type);
    } else {
      // location.requestPermission();
      Toasly.error(context, "Please on your location!",
          gravity: Gravity.BOTTOM);
    }
  }

  String getButtonTitle() {
    String type;
    if (punchedAttendance == null) {
      type = 'Punch In';
    }
    /*else if (punchedAttendance['break_in'] == null &&
        punchedAttendance['break_out'] == null &&
        punchedAttendance['punch_out'] == null) {
      type = 'BREAK IN';
    } else if (punchedAttendance['break_in'] != null &&
        punchedAttendance['break_out'] == null &&
        punchedAttendance['punch_out'] == null) {
      type = 'BREAK OUT';
    }*/
    else
      /*if (punchedAttendance['break_in'] != null &&
        punchedAttendance['break_out'] != null &&
        punchedAttendance['punch_out'] == null) */ {
      type = 'Punch Out';
    }
    return type;
  }

  @override
  onHRMSLoginError(error) {
    print(error);
    setState(() {
      isLoading = false;
    });
    // TODO: implement onHRMSLoginError
    return null;
  }

  @override
  onHRMSLoginFailure(failed) {
    setState(() {
      isLoading = false;
    });
    print(failed);
    // TODO: implement onHRMSLoginFailure
    return null;
  }

  @override
  onHRMSLoginSuccess(String response) {
    print('login Success');
    print(response);
    attendancePresenter.getAttendance("");
    // TODO: implement onHRMSLoginSuccess
  }

  @override
  onAttendanceError(error) {
    setState(() {
      isLoading = false;
    });
    // TODO: implement onAttendanceError
    return null;
  }

  @override
  onAttendanceFailure(failed) {
    setState(() {
      isLoading = false;
    });
    // TODO: implement onAttendanceFailure
    return null;
  }

  @override
  onAttendanceSuccess(var response) {
    print('onAttendanceSuccess');
    print(response);
    Toasly.success(context, "Attentance Marked!");
    setState(() {
      isLoading = false;
    });

    /*print(response);
    if(mounted){

    }*/

    // TODO: implement onAttendanceSuccess
  }

  @override
  getAttendanceSuccess(var response) {
    print(response);
    if (mounted) {
      setState(() {
        punchedAttendance = response;
        isLoading = false;
      });
    }

    // TODO: implement onAttendanceSuccess
  }

  void onPressButton(PUNCH punch) {
    setState(() {
      isLoading = true;
    });
    lastPunch = punch;
    if (punchedAttendance == null) {
      punchedAttendance = new Map();
    }
    if (punch == PUNCH.PUNCH_IN) {
      punchedAttendance['punch_in'] = AppUtils.getTimeStamp();
      SsoStorage.setPunchAttendance(
          AppUtils.getCurrentDate(), punchedAttendance);
      attendancePresenter.punchAttendance('in');
    } else if (punch == PUNCH.PUNCH_OUT) {
      punchedAttendance['punch_out'] = AppUtils.getTimeStamp();
      SsoStorage.setPunchAttendance(
          AppUtils.getCurrentDate(), punchedAttendance);
      attendancePresenter.punchAttendance('out');
    } else if (punch == PUNCH.BREAK_IN) {
      punchedAttendance['break_in'] = AppUtils.getTimeStamp();
      SsoStorage.setPunchAttendance(
          AppUtils.getCurrentDate(), punchedAttendance);
      attendancePresenter.punchAttendance('break_in');
    } else if (punch == PUNCH.BREAK_OUT) {
      punchedAttendance['break_out'] = AppUtils.getTimeStamp();
      SsoStorage.setPunchAttendance(
          AppUtils.getCurrentDate(), punchedAttendance);
      attendancePresenter.punchAttendance('break_out');
    }
    sendLocation(punch);
  }

  void sendLocation(PUNCH punch) {
    String type;
    if (punch == PUNCH.PUNCH_IN) {
      type = "Punch in";
    } else if (punch == PUNCH.PUNCH_OUT) {
      type = "Punch out";
    } else if (punch == PUNCH.BREAK_IN) {
      type = "Break in";
    } else if (punch == PUNCH.BREAK_OUT) {
      type = "Break out";
    }
    var location = new Location();
    location.getLocation().then((currentLocation) {
      try {
        print(currentLocation.toString());
        print(currentLocation.latitude);
        print(currentLocation.longitude);
        attendancePresenter.trackLocation(
          /*"$type :- ${currentLocation.}"*/
            type,
            currentLocation.latitude.toString(),
            currentLocation.longitude.toString());
      } catch (e) {
        print(e);
      }
    });
    //  attendancePresenter.trackLocation("$type :- Vashi", '192.121.12', '192.121.12');
    print(type);
  }
}

enum PUNCH { PUNCH_IN, BREAK_IN, BREAK_OUT, PUNCH_OUT }
