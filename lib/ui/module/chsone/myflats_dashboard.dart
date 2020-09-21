import 'dart:collection';
import 'dart:convert';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/chsone/chsone_login/chsone_login_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/chsone_login/chsone_login_view.dart';
import 'package:sso_futurescape/presentor/module/chsone/chsone_member_dashboard/chsone_member_dashboard_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/chsone_member_dashboard/chsone_member_dashboard_view.dart';
import 'package:sso_futurescape/ui/module/chsone/incidentaldues/my_flats_indental_card.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_pages/myflats_complaints.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_pages/myflats_gallery.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_pages/myflats_maintenance.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_pages/myflats_notices.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_pages/myflats_receipt.dart';
import 'package:sso_futurescape/ui/module/chsone/notices/notices_list.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/sso/my_property/myproperty.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'myflats_meeting.dart';

class MyFlatsDashboard extends StatefulWidget {
  var currentUnit;

  MyFlatsDashboard(this.currentUnit);

  @override
  _MyFlatsDashboardState createState() =>
      new _MyFlatsDashboardState(this.currentUnit);
}

class _MyFlatsDashboardState extends State<MyFlatsDashboard>
    implements DashboardView, ChsOneLoginView {
  var currentUnit = null;
  DashboardPresenter presenter;
  bool isLoading = true;
  var flatsMaintenance;
  var flatsIncidental;
  var flatsReceipt;
  var flatsComplaints;
  var flatsAnnouncement;
  var flatsNotices;
  var flatsGallery;

  IPage maintance;

  bool isPublic = false;

  _MyFlatsDashboardState(this.currentUnit);

  @override
  void initState() {
    if (currentUnit != null) {
      print(currentUnit);
      presenter = new DashboardPresenter(this);
      /*ChsoneStorage.getChsoneAccessInfo().then((onValue) {
        if (onValue != null) {
          print("access_info **********: " + onValue.toString());
        } else {
          print("access_info ############# ");
        }
      });

      ChsoneStorage.getChsoneUserData().then((onValue) {
        if (onValue != null) {
          print("UserDAta  ******** : " + onValue.toString());
        }
      });*/
      autoLoginChsOne();
//      getDashboardDetails();
      /*setState(() {
        var dashboardData = MyFlatData.map();

        flatsMaintenance = dashboardData["data"]["maintenance"];
        flatsReceipt = dashboardData["data"]["last_receipt"];
        flatsComplaints = dashboardData["data"]["last_compalints"];
        flatsAnnouncement = dashboardData["data"]["last_announcement"];
        flatsNotices = dashboardData["data"]["last_notices"];
        flatsGallery = dashboardData["data"]["gallery"];
      });*/
    }
    super.initState();
  }

  void autoLoginChsOne() {
    SsoStorage.getUserProfile().then((_userProfiew) {
      HashMap<String, String> hashMap = new HashMap();
      hashMap["username"] = _userProfiew["username"];
      hashMap["user_id"] = _userProfiew["user_id"].toString();
      hashMap["grant_type"] = "password";
      hashMap["session_token"] = _userProfiew["session_token"];
      hashMap["soc_id"] = currentUnit["soc_id"];

      ChsOneLoginPresenter loginPresenter = new ChsOneLoginPresenter(this);
      loginPresenter.login_chsone(hashMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: FsColor.primaryflat,
          title: new Text(
            'My Flats Dashboard'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
          leading: FsBackButtonlight(
            backEvent: (context) {
              _backbtnClick(context);
            },
          ),
          /* actions: <Widget>[],*/
          actions: <Widget>[
            PopupMenuButton(
              onSelected: popupMenuSelected,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem(
                  child: Text(
                    "My Property",
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        fontFamily: 'Gilroy-SemiBold',
                        color: FsColor.basicprimary),
                  ),
                  value: "myproperty",
                ),
              ],
            ),
          ]),
      body: isLoading
          ? PageLoader()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FsColor.lightgreybg,
                      image: DecorationImage(
                        image: AssetImage("images/building-bg.png"),
                        fit: BoxFit.none,
                        repeat: ImageRepeat.repeatX,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/building.png',
                              fit: BoxFit.contain,
                              width: 30.0,
                              height: 30.0,
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                currentUnit == null
                                    ? ""
                                    : currentUnit["name"] != null
                                        ? currentUnit["name"]
                                        : "",
                                style: TextStyle(
                                  color: FsColor.basicprimary,
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
                              color: FsColor.primaryflat,
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
                                currentUnit == null
                                    ? ""
                                    : currentUnit["unit"] != null
                                        ? currentUnit["unit"]
                                        : "",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h4size,
                                    fontFamily: 'Gilroy-Bold',
                                    color: FsColor.primaryflat),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                  color: FsColor.primaryflat,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SwitchComplexPage(
                                                  AppConstant.CHSONE)),
                                    );
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(FlutterIcon.plus,
                                          color: FsColor.white,
                                          size: FSTextStyle.h5size),
                                      SizedBox(width: 5.0),
                                      Text(
                                        FsString.SWITCH,
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Bold',
                                            letterSpacing: 1,
                                            color: FsColor.white),
                                      ),
                                      SizedBox(width: 5.0),
                                      Icon(FlutterIcon.exchange,
                                          color: FsColor.white,
                                          size: FSTextStyle.h5size),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),

                  /*MyFlatsMaintenance(flatsMaintenance ,onInit:(iPage){
              this.maintance=iPage ;
            }),*/
                  !isPublic
                      ? Container()
                      : MyFlatsMaintenance(flatsMaintenance, currentUnit),

                  !isPublic
                      ? Container()
                      : MyFlatsIncidental(flatsIncidental, currentUnit),

                  !isPublic ? Container() : MyFlatsReceipt(flatsReceipt),

                  !isPublic
                      ? Container()
                      : MyFlatsComplaints(flatsComplaints, currentUnit),
/*

            !isPublic
                ? Container()
            // : MyFlatsAnnouncement(flatsAnnouncement),
                : MyFlatsAnnouncement(
                flatsAnnouncement, currentUnit, NOTICE_TYPE.ANNOUNCEMENT),
*/

                  !isPublic
                      ? Container()
                      : MyFlatsNotices(
                          flatsNotices, currentUnit, NOTICE_TYPE.ALL),

                  !isPublic
                      ? Container()
                      : MyFlatsGallery(flatsGallery, currentUnit),

                  /*!isPublic
                      ? Container()
                      : MyFlatsMeeting(societyId: _getSocietyId()),*/

                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                  //   child: Text(
                  //     "Gallery".toLowerCase(),
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(dyn
                  //         fontSize: FSTextStyle.dashtitlesize,
                  //         fontFamily: 'Gilroy-SemiBold',
                  //         color: FsColor.primaryflat),
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  //   height: 150,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     primary: false,
                  //     // itemCount: places == null ? 0 : places.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.only(right: 10),
                  //         child: InkWell(
                  //           child: Container(
                  //             height: 100,
                  //             width: 100,

                  //               child: Column(
                  //               children: <Widget>[
                  //                 Card(
                  //                 shape: BeveledRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(10.0),
                  //                 ),

                  //                 child: ClipRRect(
                  //                   child: Image.asset(
                  //                     "images/home.jpg",
                  //                     height: 90,
                  //                     width: 90,
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),

                  //               ),
                  //                 Container(
                  //                   padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  //                   alignment: Alignment.center,
                  //                   child: Text(
                  //                     "Gallery Title Here",
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                       fontSize: FSTextStyle.h6size,
                  //                       fontFamily: 'Gilroy-SemiBold',
                  //                       height: 1
                  //                     ),
                  //                     maxLines: 2,
                  //                   ),
                  //                 ),

                  //               ],
                  //             ),

                  //           ),
                  //           onTap: () {},
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }

  int _getSocietyId() {
    int societyId = 0;
    if (currentUnit != null) {
      String societyIdStr = currentUnit["soc_id"]?.toString()?.trim() ?? "";
      societyId = int.parse(societyIdStr.isNotEmpty ? societyIdStr : "0");
    }
    return societyId;
  }

  @override
  onError(error) {
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((error))));
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  onFailure(failed) {
    print(failed);
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((failed))));
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  onSuccess(String response) {
    print("success_response 111111" + response);
    var dashboardData = json.decode(response);
    //var dashboardData = MyFlatData.map();
    if (dashboardData != null) {
      print("dashboardData 2222222" + dashboardData.toString());
      var data = dashboardData["data"];
      print("Data$data");
      flatsMaintenance = data["maintenance"];
      flatsIncidental = data["incidental"];
      flatsReceipt = data["last_receipt"];
      flatsReceipt['unit_id'] = data["unit"]['unit_id'];
      flatsComplaints = data["last_compalints"];
      flatsAnnouncement = data["last_announcement"];
      flatsNotices = data["last_notices"];
      flatsGallery = data["gallery"];
      isPublic = true;
      isLoading = false;
      if (mounted) {
        setState(() {});
        //maintance.onUbdate();
      }
    }
  }

  void _backbtnClick(context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainDashboard()),
        (Route<dynamic> route) => false);
  }

  getDashboardDetails() {
    if (currentUnit != null && currentUnit["unit_id"] != null) {
      HashMap<String, String> hashMap = new HashMap();
      hashMap["unit_id"] = currentUnit["unit_id"];
      presenter.getMyFlatDashboardDetails(hashMap);
    } else {
      //todo validation display;
    }
  }

  @override
  onChsLoginError(error) {
    setState(() {
      isLoading = false;
    });
    print(error);
  }

  @override
  onChsLoginFailure(failed) {
    setState(() {
      isLoading = false;
    });
    print(failed);
  }

  @override
  onChsLoginSuccess(String response) {
    var profilJson = json.decode(response);
    ChsoneStorage.saveChsoneAccessInfo(profilJson["data"]["access_info"]);
    ChsoneStorage.saveChsoneUserData(profilJson["data"]["user_data"]);
    getDashboardDetails();
  }

  void popupMenuSelected(String value) {
    if (!isLoading) {
      if (value == "myproperty") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyProperty(currentUnit)),
        );
      }
    } else {
      Toasly.warning(context, "Laoding!....");
    }
  }
}

abstract class IPage {
  onUbdate();
}
