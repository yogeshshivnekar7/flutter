import 'dart:convert';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/properties/property.dart';
import 'package:sso_futurescape/ui/module/sso/my_property/parking_widgets.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/no_data_nonsearch.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/ui/widgets/responsive_widget.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class MyProperty extends StatefulWidget {
  var currentUnit;

  MyProperty(this.currentUnit);

  @override
  _MyPropertyState createState() => new _MyPropertyState(this.currentUnit);
}

enum TABTYPE { MEMBER, VEHICLE, PARKING }

class _MyPropertyState extends State<MyProperty> implements MyPropertyView {
  String tabView = "member";

  MyPropertyPresenter myPropertyPresenter;

  List memberDetails;

  List vehiclesDetails;

  List parkingDetails;

  var numberOfPendingRequests = 0;

  var unitDetails;

  var currentUnit;

  var isUserPrimary = false;

  var isLoading = true;
  var societyName = 'Lorem Ipsum Complex co op Ltd';

  var ownerName = "";
  var ownerMobileNumber = "";

  _MyPropertyState(this.currentUnit);

  @override
  void initState() {
    super.initState();
    myPropertyPresenter = new MyPropertyPresenter(this);
    ChsoneStorage.getSocietyDetails().then((data) {
      /// print(data);
      societyName = data["soc_name"].toString();
      //print("getmySocietyProperty");
      myPropertyPresenter.getmySocietyProperty();
    });
    ChsoneStorage.getMemberIdForUnit(currentUnit["unit_id"].toString())
        .then((userData) {
      if (userData['member_type_name'].toLowerCase() == "primary") {
        isUserPrimary = true;
      }
    });
    SsoStorage.getUserProfile().then((profile) {});
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      primaryColor: FsColor.primaryflat,
      appBar: AppBar(
        title: Text(
          'My Property'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 0.0,
        backgroundColor: FsColor.primaryflat,
        leading: FsBackButtonlight(),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: PageLoader(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FsColor.primaryflat,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/building_white.png',
                              color: FsColor.white,
                              fit: BoxFit.contain,
                              width: 30.0,
                              height: 30.0,
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                societyName,
                                style: TextStyle(
                                  color: FsColor.white,
                                  fontSize: FSTextStyle.h4size,
                                  fontFamily: 'Gilroy-SemiBold',
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: 75.0,
                          width: 120.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: FsColor.white,
                            border: Border.all(
                              width: 2.0,
                              color: FsColor.primarytiffin,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'UNIT NO',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h7size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              ),
                              Text(
                                unitDetails["unit_flat_number"].toString(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h3size,
                                    fontFamily: 'Gilroy-Bold',
                                    color: FsColor.primarytiffin),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Owner Name : ',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.white),
                              ),
                              Text(
                                ownerName,
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Mobile : ',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.white),
                              ),
                              Text(
                                ownerMobileNumber,
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: FsColor.primaryflat,
                    height: 42,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color: tabView == 'member'
                                      ? FsColor.white
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      tabView = 'member';
                                    });
                                  },
                                  child: Text(
                                    "Member".toLowerCase(),
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h5size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: tabView == 'member'
                                          ? FsColor.white
                                          : FsColor.white.withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                (numberOfPendingRequests == 0 || !isUserPrimary)
                                    ? new Container()
                                    : Positioned(
                                        top: 3,
                                        right: 8,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Colors.redAccent,
                                    ),
                                    child: Text(
                                      numberOfPendingRequests.toString(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h7size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2.0,
                                color: tabView == 'vehicle'
                                    ? FsColor.white
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                tabView = 'vehicle';
                              });
                            },
                            child: Text(
                              "Vehicle".toLowerCase(),
                              style: TextStyle(
                                fontSize: FSTextStyle.h5size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: tabView == 'vehicle'
                                    ? FsColor.white
                                    : FsColor.white.withOpacity(0.6),
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color: (tabView == 'parking')
                                      ? FsColor.white
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  tabView = 'parking';
                                });
                              },
                              child: Text(
                                "Parking".toLowerCase(),
                                style: TextStyle(
                                  fontSize: FSTextStyle.h5size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: tabView == 'parking'
                                      ? FsColor.white
                                      : FsColor.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
                        (tabView == 'member')
                            ? getWidgetOfTab('member')
                            : Container(),
                        tabView == 'vehicle'
                            ? getWidgetOfTab('vehicle')
                            : Container(),
                        tabView == 'parking'
                            ? getWidgetOfTab('parking')
                            : Container(), //
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void acceptMemberRequest(int memberId) {
    setState(() {
      isLoading = true;
    });
    myPropertyPresenter.acceptMemberRequest(currentUnit, memberId);
  }

  void rejectMemberRequest(int memberId) {
    setState(() {
      isLoading = true;
    });
    myPropertyPresenter.rejectMemberRequest(currentUnit, memberId);
  }

  void deleteMemberDialog(member_name, member_id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: FsColor.red,
                size: 64,
              ),
              SizedBox(height: 10),
              Text(
                  ("Remove " + member_name + " from this unit ?").toLowerCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.darkgrey)),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "No",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.darkgrey),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        },
                      ),
                      RaisedButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.white),
                        ),
                        color: FsColor.basicprimary,
                        onPressed: () {
                          deactivateMember(member_id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void deactivateMember(memberId) {
    setState(() {
      isLoading = true;
    });
    myPropertyPresenter.deactivateMember(currentUnit, memberId);
  }

  getMemberView(memberDetail) {
    return MemberWidget(memberDetail, this);
  }

  getVehicleView(vehiclesDetail) {
    return VehicleWidget(vehiclesDetail);
  }

  getParkingView(parkingDetail) {
    return ParkingWidget(parkingDetail);
  }

  Widget getWidgetOfTab(String tabView) {
    Widget bb;
    var data = []; //=memberDetails;
    if (tabView == "member") {
      //data = memberDetails;
      if (memberDetails != null && memberDetails.length != 0) {
        for (int i = 0; i < memberDetails.length; i++) {
          if (!(memberDetails[i]['status'] != 1 &&
              memberDetails[i]['approved'] == 1)) {
            data.add(memberDetails[i]);
          }
        }
        bb = getMemberView(data);
        /*print(data[i]["member_type_name"].toLowerCase()+"          "+"Primary".toLowerCase());
          if(data[i]["member_type_name"].toLowerCase()=="Primary".toLowerCase()){
            ownerName=UserUtils.getFullName(data[i]["member_first_name"],data[i]["member_last_name"]).toLowerCase();
            ownerMobileNumber=data[i]["member_mobile_number"].toString();
          }*/
        //}
      } else {
        bb = FsNoData();
      }
    } else if (tabView == "vehicle") {
      data = vehiclesDetails;
      if (data != null && data.length != 0) {
        // for (int i = 0; i < data.length; i++) {
        bb = getVehicleView(data);
        // }
      } else {
        bb = FsNoData();
      }
    } else if (tabView == "parking") {
      data = parkingDetails;
      if (data != null && data.length != 0) {
        // for (int i = 0; i < data.length; i++) {
        bb = getParkingView(data);
        // }
      } else {
        bb = FsNoData();
      }
    }

    return bb;
  }

  @override
  void onFailedProperties(success) {
    //print(success);
    /*var responseSucess = json.decode(success);
    this.memberDetails = responseSucess["member_details"];
    print(memberDetails);*/
    isLoading = false;
    setState(() {});
  }

  @override
  void onSuccessProperies(success) {
    //print(success);
    var responseSucess = json.decode(success);
    List unitDetailss = responseSucess["data"];
    for (var a = 0; a < unitDetailss.length; a++) {
      if (currentUnit["unit_id"].toString() ==
          unitDetailss[a]["unit_id"].toString()) {
        unitDetails = responseSucess["data"][a];
        this.memberDetails = unitDetails["member_details"];
        this.vehiclesDetails = unitDetails["vehicles_details"];
        this.parkingDetails = unitDetails["parking_details"];
        // print(memberDetails);
        var data = memberDetails;
        var unapproved = [];
        var approved = [];
        this.numberOfPendingRequests = 0;
        for (int i = 0; i < data.length; i++) {
          print(data[i]["member_type_name"].toLowerCase() +
              "          " +
              "Primary".toLowerCase());
          if (data[i]["member_type_name"].toLowerCase() ==
                  "Primary".toLowerCase() &&
              data[i]['approved'] == 1) {
            ownerName = UserUtils.getFullName(
                    data[i]["member_first_name"], data[i]["member_last_name"])
                .toLowerCase();
            ownerMobileNumber = data[i]["member_mobile_number"].toString();
            approved.add(data[i]);
          } else {
            if (data[i]['approved'] != 1) {
              this.numberOfPendingRequests = this.numberOfPendingRequests + 1;
              unapproved.add(data[i]);
            } else {
              approved.add(data[i]);
            }
          }
        }
        this.memberDetails = [];
        this.memberDetails = unapproved + approved;
        isLoading = false;
        setState(() {});

        break;
      }
    }
  }

  @override
  void onActionSuccessProperies(success) {
    //print(success);
    var responseSucess = json.decode(success);
    var str = responseSucess['message'];
    if (str.contains('deleted')) {
      str = "Member has been removed";
    }
    Toasly.success(context, str, gravity: Gravity.BOTTOM);
    myPropertyPresenter = new MyPropertyPresenter(this);
    ChsoneStorage.getSocietyDetails().then((data) {
      /// print(data);
      societyName = data["soc_name"].toString();
      //print("getmySocietyProperty");
      myPropertyPresenter.getmySocietyProperty();
    });
  }

  @override
  void onActionFailedProperties(success) {
    //print(success);
    var responseSucess = json.decode(success);
    Toasly.error(context, responseSucess['message'], gravity: Gravity.BOTTOM);
    myPropertyPresenter = new MyPropertyPresenter(this);
    ChsoneStorage.getSocietyDetails().then((data) {
      /// print(data);
      societyName = data["soc_name"].toString();
      //print("getmySocietyProperty");
      myPropertyPresenter.getmySocietyProperty();
    });
  }
}
