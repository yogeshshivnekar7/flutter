import 'dart:async';
import 'dart:collection';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/model/app/app_model.dart';
import 'package:sso_futurescape/presentor/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/expected_guest_view.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_view.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/myvisitors_intercomlist.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitor_help.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/qr_demo.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class VizlogCard extends StatefulWidget {
  Function onInitialUpdate;

  /*VizlogCard({Function onInitialUpdate}) {
    this.onInitialUpdate = onInitialUpdate;
  }*/
  static final GlobalKey<_VizlogCardState> staticGlobalKey =
      new GlobalKey<_VizlogCardState>();

  VizlogCard({this.onInitialUpdate}) : super(key: VizlogCard.staticGlobalKey);

  @override
  _VizlogCardState createState() =>
      new _VizlogCardState(onInitialUpdate: onInitialUpdate);

/*void clickOnDashboard() {
    aa.openDashboard();
  }*/
}

class VFunction {
  void giveListner(_VizlogCardState _vizlogCardState) {}
}

class _VizlogCardState extends State<VizlogCard>
    implements
        DashbaordCard,
        VizLoginView,
        IUnitsDetails,
        IntercomView,
        ExpectedGuestView {
  Function onInitialUpdate;

  VizlogLoginPresentor vizLoginPresentor;

  String todayVisitor = "0";

  bool isLoadingVisitor = false;

  String profileUrl;

  SwitchComplexPresentor switchComplexPresentor;

  bool hasIntercom = false;

  String todayGuest = "0";

  bool isInviteGuestLoading = true;

  _VizlogCardState({Function onInitialUpdate}) {
    this.onInitialUpdate = onInitialUpdate;
    onInitialUpdate(this);
    vizLoginPresentor = new VizlogLoginPresentor(this);
  }

  var _userProfiew;

  var currentUnit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SsoStorage.getUserProfile().then((profile) {
      _userProfiew = profile;
      setUnitDetails();
    });
    checkForHelp();
  }

  bool isFound = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: new Container(
          child: Column(
        children: <Widget>[
          new Container(
            child: new Card(
              key: null,
              child: Container(
                /*decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/dash-bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),*/
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        noUnitAccess()
                                            ? "my visitors"
                                            : currentUnit["building"]
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: noUnitAccess()
                                                ? FSTextStyle.dashtitlesize
                                                : FSTextStyle.h5size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.primaryvisitor),
                                      ),
                                      noUnitAccess()
                                          ? Container()
                                          : Text(
                                              currentUnit["unit"].toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      FSTextStyle.dashtitlesize,
                                                  fontFamily: 'Gilroy-SemiBold',
                                                  color:
                                                      FsColor.primaryvisitor),
                                            ),
                                    ],
                                  ),

                                  // Text(
                                  //   currentUnit == null ||
                                  //       !currentUnit["active"]
                                  //       ? "my visitors"
                                  //       : currentUnit["building"].toString() +
                                  //       "/" +
                                  //       currentUnit["unit"].toString(),
                                  //   style: TextStyle(
                                  //       fontSize: FSTextStyle.dashtitlesize,
                                  //       fontFamily: 'Gilroy-SemiBold',
                                  //       color: FsColor.primaryvisitor),
                                  // ),
                                ),
                                SizedBox(height: 5),
//                              Container(
//                                child: QrDemo(),
//                              ),
                                Row(
                                  children: [
                                    Icon(Icons.verified_user,
                                        size: FSTextStyle.h6size,
                                        color: FsColor.primaryvisitor),
                                    Text(
                                      'Secured User'.toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-Bold',
                                          color: FsColor.primaryvisitor),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: RaisedButton(
                                          elevation: 1.0,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(4.0),
                                          ),
                                          onPressed: () => {
                                            _checkForProfile(),
                                          },
                                          color: FsColor.primaryvisitor,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: Text(
                                            "Open Pass",
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-Bold',
                                                color: FsColor.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      !hasIntercom
                                          ? Container()
                                          : Container(
                                              child: OutlineButton(
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(4.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: FsColor
                                                          .primaryvisitor,
                                                      width: 3),
                                                  onPressed: () {
                                                    navigateIntercom(context);
                                                  },
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone_in_talk,
                                                        size: 24,
                                                        color: FsColor
                                                            .primaryvisitor,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "Intercom",
                                                        style: TextStyle(
                                                            fontSize:
                                                                FSTextStyle
                                                                    .h6size,
                                                            fontFamily:
                                                                'Gilroy-Bold',
                                                            color: FsColor
                                                                .primaryvisitor),
                                                      ),
                                                    ],
                                                  )),
                                            ),

                                      /*Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 5, 5, 0),
                                            width: 35,
                                            height: 35,
                                            child: OutlineButton(
                                                shape:
                                                new RoundedRectangleBorder(
                                                  borderRadius:
                                                  new BorderRadius
                                                      .circular(4.0),
                                                ),
                                                borderSide: BorderSide(
                                                    color: FsColor
                                                        .primaryvisitor,
                                                    width: 2),
                                                onPressed: () =>
                                                {

                                                },
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 5.0),
                                                child: Icon(
                                                  Icons.phone_in_talk,
                                                  size: 24,
                                                  color:
                                                  FsColor.primaryvisitor,
                                                )),
                                          ),*/
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Image.asset("images/dash2.png",
                                height: 100, width: 100, fit: BoxFit.fitHeight),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                      child: Divider(
                          color: FsColor.darkgrey.withOpacity(0.2),
                          height: 2.0),
                    ),

                    !isFound && !openSwitchPage
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  "Secure your home | control visitors | connect with society gate | know who has arrived | track helps"
                                      .toLowerCase(),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: FSTextStyle.dashsubtitlesize,
                                      fontFamily: FSTextStyle.dashsubtitlefont,
                                      color: FsColor.dashsubtitlecolor),
                                ))
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                openSwitchPage
                                    ? Flexible(
                                        child: Text(
                                        // "Allow visitor, pre-approved visitors, access your visitors logs, take control of your family safety & security."
                                        "Secure your home | control visitors | connect with society gate | know who has arrived | track helps"
                                            .toLowerCase(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize:
                                                FSTextStyle.dashsubtitlesize,
                                            fontFamily:
                                                FSTextStyle.dashsubtitlefont,
                                            color: FsColor.dashsubtitlecolor),
                                      ))
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                isLoadingVisitor
                                                    ? "loading...."
                                                    : todayVisitor,
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h4size,
                                                    fontFamily: 'Gilroy-Bold',
                                                    color: FsColor.darkgrey),
                                              ),
                                              Container(
                                                height: 3,
                                              ),
                                              Text(
                                                "Visitors Today",
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h6size,
                                                    fontFamily:
                                                        'Gilroy-SemiBold',
                                                    color: FsColor.darkgrey),
                                              ),
                                              SizedBox(height: 4.0),
                                            ],
                                          ),
                                          SizedBox(width: 40.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                isInviteGuestLoading
                                                    ? "loading..."
                                                    : todayGuest,
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h4size,
                                                    fontFamily: 'Gilroy-Bold',
                                                    color: FsColor.darkgrey),
                                              ),
                                              Container(
                                                height: 3,
                                              ),
                                              Text(
                                                "Invite Sent",
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h6size,
                                                    fontFamily:
                                                        'Gilroy-SemiBold',
                                                    color: FsColor.darkgrey),
                                              ),
                                              SizedBox(height: 4.0),
                                            ],
                                          ),
                                        ],
                                      ),
                                !isFound && !openSwitchPage
                                    ? Container()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            child: FlatButton(
                                              onPressed: () {
                                                openDashboard();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "View",
                                                    style: TextStyle(
                                                        fontSize:
                                                            FSTextStyle.h6size,
                                                        fontFamily:
                                                            'Gilroy-SemiBold',
                                                        color:
                                                            FsColor.darkgrey),
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Icon(FlutterIcon.right_big,
                                                      color: FsColor.darkgrey,
                                                      size: FSTextStyle.h6size),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Text(
                    //             "52",
                    //             style: TextStyle(fontSize: FSTextStyle.h4size, fontFamily: 'Gilroy-Bold', color:  FsColor.darkgrey),
                    //           ),
                    //           Container(
                    //             height: 3,
                    //           ),
                    //           Text("Todays Visitors",
                    //             style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color:  FsColor.darkgrey),
                    //          ),
                    //           SizedBox(height: 4.0),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           GestureDetector(
                    //             child: FlatButton(
                    //               onPressed: () {},
                    //               child: Row(
                    //                 children: <Widget>[
                    //                   Text("View",
                    //                     style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color:  FsColor.darkgrey),
                    //                   ),
                    //                   SizedBox(width: 10.0),
                    //                   Icon(FlutterIcon.right_big, color: FsColor.darkgrey, size: FSTextStyle.h6size),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 5.0),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            alignment: Alignment.center,
          ),
        ],
      )),
      onTap: () {
        if (!(!isFound && !openSwitchPage)) {
          openDashboard();
        }
        // _openDashboard();
      },
    );
  }

  void _checkForProfile() {
    bool isUnNotSet = false;
    int counter = 0;
    SsoStorage.getUserProfile().then((profile) {
      _userProfiew = profile;
      profileUrl = profile["avatar_small"];
      if (profileUrl != null) profileUrl += "?dummy=${counter++}";
      if (_userProfiew["first_name"] == null ||
          _userProfiew["first_name"].toString().length <= 0) {
        isUnNotSet = true;
      }
      bool isAdrsNotSet = false;
      if ((_userProfiew["city"] == null ||
          _userProfiew["city"].toString().length <= 0)) {
        isAdrsNotSet = true;
      }
      /*if ((_userProfiew["address_line_1"] == null ||
          _userProfiew["address_line_1"]
              .toString()
              .length <= 0) && (_userProfiew["address_line_2"] == null ||
          _userProfiew["address_line_2"]
              .toString()
              .length <= 0)) {
        isAdrsNotSet = true;
      }*/
      if (isUnNotSet || isAdrsNotSet) {
        updateProfileDialog(context, onProfileUpdate,
            name: isUnNotSet, address: isAdrsNotSet);
      } else {
        FsFacebookUtils.callCartClick(
            "onegate pass", _userProfiew['first_name']);
        _showPassDialog();
      }
    });
  }

  bool noUnitAccess() {
    return currentUnit == null || !currentUnit["active"];
  }

  onProfileUpdate() {
    setState(() {
      SsoStorage.getUserProfile().then((profile) {
        _userProfiew = profile;
        FsFacebookUtils.callCartClick(
            "onegate pass", _userProfiew['first_name']);
        _showPassDialog();
      });
    });
  }

  void _showPassDialog() {
    // flutter defined function
    FsPlatform.printPlatFormInfo();
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
                  /*Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 1, color: FsColor.lightgrey.withOpacity(0.8)),
                    )),
                    child: Text(
                      'Trust Citizen Pass',
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h3size,
                          color: FsColor.basicprimary),
                    ),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 2, 5, 0),
                        child: Icon(Icons.verified_user,
                            size: FSTextStyle.h3size, color: FsColor.green),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 1, color: FsColor.green.withOpacity(0.8)),
                        )),
                        child: Text(
                          'Trust Citizen Pass',
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h3size,
                              color: FsColor.green),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 72,
                    width: 72,
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 10.0, bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36.0),
                      child: profileUrl != null
                          ? Image.network(
                              profileUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'images/default.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: new Text(
                      getName(),
//                      "Name Comes Here".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h4size,
                          color: FsColor.darkgrey),
                    ),
                  ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
//                     child: new Text(
//                       _userProfiew["email"] == null
//                           ? "email not mentioned"
//                           : _userProfiew["email"].toString(),
// //                        "email@domain.com".toLowerCase(),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontFamily: 'Gilroy-Regular',
//                           fontSize: FSTextStyle.h6size,
//                           color: FsColor.darkgrey),
//                     ),
//                   ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: new Text(
                      _userProfiew["mobile"].toString(),
//                      "+91 9876543210".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  QrDemo(_userProfiew),
//                  Container(
//                    height: 200.0,
////                    child: Center(
////                      child: Column(
////                          mainAxisAlignment: MainAxisAlignment.center,
////                          crossAxisAlignment: CrossAxisAlignment.center,
////                          children: [
////                            QrImage(
////                              data: "amit",
////                              version: QrVersions.auto,
////                              size: 100.0,
////                            )
////                          ]),
////                    ),
//                  child: QrImage(
//                    data: "amit",
//                    version: QrVersions.auto,
//                    size: 100.0,
//                  ),
////                    child: new Image.network(
////                      'https://image.flaticon.com/icons/svg/241/241528.svg',
////                      fit:BoxFit.fill,
////                    ),
//                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Express entry in',
                              style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  fontSize: FSTextStyle.h7size,
                                  color: FsColor.darkgrey)),
                          TextSpan(
                              text: ' ONEAPP ',
                              style: TextStyle(
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontSize: FSTextStyle.h7size,
                                  color: FsColor.primary)),
                          TextSpan(
                              text: 'Powered Facilities',
                              style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  fontSize: FSTextStyle.h7size,
                                  color: FsColor.darkgrey)),
                        ],
                      ),
                    ),
                    // child: new Text(
                    //   "Express entry in ONEAPP Powered Facilities".toLowerCase(),
                    //   textAlign: TextAlign.center,
                    // style: TextStyle(
                    //     fontFamily: 'Gilroy-Regular',
                    //     fontSize: FSTextStyle.h7size,
                    //     color: FsColor.darkgrey),
                    // ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  String getName() {
//    print(_userProfiew["first_name"].toString());
    String lastName = "";
    if (_userProfiew["last_name"] != null) {
      lastName = " " + _userProfiew["last_name"].toString();
    }
    String s = _userProfiew["first_name"].toString() + lastName;
    print("name $s");
    return s.toLowerCase();
  }

  /* _openVizlog(BuildContext context) async {
    print("jjjjjjjjjjjjjjjj");
    // var s = Navigator.pushNamed(context, '/complexadd');
    var s = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
          builder: (context) => SwitchComplexPage(AppConstant.VIZLOG)),
    );
    setUnitDetails();
  }
*/
  void _openVizlog() {
    deviceRegister();
    print(
        "-------------------------------------_openVizlog---------------------");
    String socId = currentUnit["soc_id"].toString();
    String unitId = currentUnit["unit_id"].toString();
    vizLoginPresentor.doLogin(
        _userProfiew["username"].toString(),
        _userProfiew["session_token"].toString(),
        socId,
        unitId,
        _userProfiew["user_id"].toString(),
        getVisitor: true);
    /*SsoStorage.getUserProfile().then((profile) {
      print(profile);
      print(
          "----------------------------------------------------------------------------------");
      print(profile["username"]);
      print(profile["session_token"]);

    });*/
  }

  void deviceRegister() {
    AppModel appModel = new AppModel();
    appModel.deviceRegister(() {
      print("Device Registre");
    }, () {
      print("Device Fauiled");
    }, app: AppConstant.VIZLOG);
  }

  void openDashboard() {
    if (!(!isFound && !openSwitchPage)) {
      AppUtils.checkInternetConnection().then((onValue) {
        if (onValue) {
          FsFacebookUtils.callCartClick(FsString.ONEGATE_CARD, 'card');
          if (!openSwitchPage) {
            FsNavigator.push(context, MyVisitorsDashboard());
//          Navigator.of(context).pushNamed('/visitordashboard');
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SwitchComplexPage(AppConstant.VIZLOG)),
            );
          }
        } else {
          print("No Internet Avavilble");
          Toasly.warning(context, "No Internet Connection");
        }
      });
    }
  }

//  _openVizlog() {
//    Navigator.push(
//      context,
//      new MaterialPageRoute(
//          builder: (context) => SwitchComplexPage(AppConstant.VIZLOG)),
//    );
//
//    /* SsoStorage.getUserProfile().then((profile) {
//      SsoStorage.getToken().then((accessToken) {
//        responseFromNativeCode(accessToken, profile);
//      });
//    });*/
//  }

  void setUnitDetails() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
      if (unit == null) {
        setState(() {
          isFound = false;
          switchComplexPresentor = SwitchComplexPresentor();
          switchComplexPresentor.getAllVizlogUnits(this);
        });
      } else {
        setState(() {
          currentUnit = unit;
          if (currentUnit["active"]) {
            isFound = true;
            isLoadingVisitor = true;
            _openVizlog();
            /*vizLoginPresentor.getVisitors(currentUnit["soc_id"].toString(),
                currentUnit["unit_id"].toString(), true);*/

          } else {
            //print("sadsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
            isFound = false;
            switchComplexPresentor = SwitchComplexPresentor();
            switchComplexPresentor.getAllVizlogUnits(this);
          }
        });
      }
    });
  }

  var platform = const MethodChannel('flutter.native/helper');

  Future<void> responseFromNativeCode(accessToken, profile) async {
    String response = "";
    try {
      final String result = await platform.invokeMethod(
          'vizlogapp', {"profile": profile, "access_token": accessToken});
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      /* _responseFromNativeCode = response;*/
    });
  }

  @override
  onUpdate() {
    print("CSONE call VIZLOGGGGGGGGGGGGGGGGGGGGGGGGGg");
    setUnitDetails();
  }

  @override
  error(error) {
    setState(() {
      isLoadingVisitor = false;
    });

    Toasly.error(context, error.toString());
  }

  @override
  failure(failed) {
    setState(() {
      isLoadingVisitor = false;
    });
    Toasly.error(context, failed.toString());
  }

  @override
  loginSuccess(success) async {
    print("succes-------------------$success");
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyVisitorsDashboard()),
    );*/
//    var s = await Navigator.push<bool>(
//      context,
//      MaterialPageRoute(
////          builder: (context) => SwitchComplexPage(AppConstant.VIZLOG)),
//          builder: (context) => MyVisitorsDashboard()),
//    );

    Navigator.of(context).pushNamed('/visitordashboard').then((value) {
      print(
          "retrieveData--------------------------------------------------------retrieveData-");
      print(value);
    });
  }

  @override
  visitorSuccess(success) {
    setState(() {
      isLoadingVisitor = false;
      todayVisitor = success["data"]["metadata"]["total"].toString();
      vizLoginPresentor.getBuilding(this);
      getInviteGuestCount();
    });
  }

  void updateProfileDialog(context, Function listener, {name, email, address}) {
    AppUtils.checkInternetConnection().then((onValue) {
      if (onValue) {
        UpdateProfileDialog(context, onProfileUpdate,
            name: name, address: address);
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }

  @override
  void unitFailed(data) {}
  bool openSwitchPage = false;

  @override
  void unitSuccess(data, {String from}) {
    print("vadifniandifdai -----------------------$data");
    setState(() {
      if (data != null) {
        openSwitchPage = true;
        for (var u in data) {
          if (u["active"]) {
            openSwitchPage = false;
            SsoStorage.setDefaultVizlogUnit(u);
            isFound = true;
            break;
          }
//        complex.add(com);
        }
        print("vizlog---------------------------------$openSwitchPage");
      }
    });
  }

  @override
  void unitError(data) {
    // TODO: implement unitError
  }

  @override
  void intercomError(error) {
    hasIntercom = false;
    setState(() {});
  }

  @override
  void intercomFailure(failure) {
    hasIntercom = false;
    setState(() {});
  }

  @override
  void intercomSuccess(success) {
    hasIntercom = true;
    setState(() {});
  }

  bool isHelpSeen = false;

  void checkForHelp() {
    SsoStorage.getIntercomHelp().then((value) {
      isHelpSeen = value == null ? false : true;
    });
  }

  void navigateIntercom(BuildContext context) {
    if (!isHelpSeen) {
      FsNavigator.push(
          context,
          MyVisitorHelp(
            comingFrom: "intro",
            currenUnit: currentUnit,
          ));
    } else {
      FsNavigator.push(context, MyVisitorsIntercomList(currentUnit));
    }
  }

  void getInviteGuestCount() {
    HashMap<String, String> hashMap = new HashMap();
    String socId = currentUnit["soc_id"].toString();
    String unitId = currentUnit["unit_id"].toString();
    hashMap["page"] = "1";
    GuestPresenter.getExpectedGuestCount(hashMap, socId, unitId, this);
  }

  @override
  void onGuestError(error) {
    isInviteGuestLoading = false;
    todayGuest = "0";
    setState(() {});
  }

  @override
  void onGuestFailure(failure) {
    isInviteGuestLoading = false;
    todayGuest = "0";
    setState(() {});
  }

  @override
  void onTodaysExpectedGuest(success) {
    isInviteGuestLoading = false;
    todayGuest = success["data"]["metadata"]["total"].toString();
    setState(() {});
  }
}

FutureOr Function() retrieveData() {}

abstract class DashbaordCard {
  onUpdate();
}
