import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_view.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitor_settings.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_pages/myvisitors_domestichelp.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_pages/myvisitors_guest.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_pages/myvisitors_visitor.dart';
import 'package:sso_futurescape/ui/module/vizlog/society_help.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

import 'myvisitor_help.dart';

class MyVisitorsDashboard extends StatefulWidget {
  var currentUnit;

  @override
  _MyVisitorsDashboardState createState() =>
      new _MyVisitorsDashboardState(currentUnit: currentUnit);

  MyVisitorsDashboard({var currentUnit}) {
    this.currentUnit = currentUnit;
  }
}

class _MyVisitorsDashboardState extends State<MyVisitorsDashboard>
    implements VizLoginView, IntercomView {
  var selectedUnit;

  var _userProfiew;

  VizlogLoginPresentor vizLoginPresentor;

  _MyVisitorsDashboardState({var currentUnit}) {
    selectedUnit = currentUnit;
    print("constructorr-rrrrrrrrrrrrrrrrrrrrrrrrrrr");
    vizLoginPresentor = new VizlogLoginPresentor(this);

//    print(selectedUnit);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUnitDetails();
    callLogin();
  }

  void doLogin() {
    print(
        "-------------------------------------_openVizlog---------------------");
    String socId = selectedUnit["soc_id"].toString();
    String unitId = selectedUnit["unit_id"].toString();
    vizLoginPresentor.doLogin(
        _userProfiew["username"].toString(),
        _userProfiew["session_token"].toString(),
        socId,
        unitId,
        _userProfiew["user_id"].toString(),
        getVisitor: false);
  }

  void getUnitDetails() {
    if (selectedUnit == null) {
      UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
        print("current unit-------------------------------------");
        print(unit);
        if (unit == null) {
          setState(() {});
        } else {
          setState(() {
            selectedUnit = unit;
            callLogin();
          });
        }
      });
    } else {
      callLogin();
    }
  }

  void popupMenuSelected(String valueSelected) {
    print(valueSelected);
    if (valueSelected == "settings") {
      openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("-----------------------selectedUnit");
    print(selectedUnit);
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.primaryvisitor,
        title: new Text(
          'My Visitors Dashboard'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(
          backEvent: (context) {
            _backbtnClick(context);
          },
        ),
        actions: <Widget>[
          hasIntercomFeature ? IconButton(
            icon: Icon(
              Icons.help_outline,
              color: FsColor.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyVisitorHelp(comingFrom: "help"),
                ),
              );
            },
          ) : Container(),
          PopupMenuButton(
            onSelected: popupMenuSelected,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[

              PopupMenuItem(
                child: Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: FSTextStyle.h6size,
                      fontFamily: 'Gilroy-SemiBold',
                      color: FsColor.basicprimary),
                ),
                value: "settings",
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                          selectedUnit != null && selectedUnit["name"] != null
                              ? selectedUnit["name"]
                              : "",
//                          'Lorem Ipsum Complex co op Ltd',
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
                        color: FsColor.primaryvisitor,
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
//                          '4002',
                          selectedUnit != null && selectedUnit["unit"] != null
                              ? selectedUnit["unit"]
                              : "",
                          style: TextStyle(
                              fontSize: FSTextStyle.h3size,
                              fontFamily: 'Gilroy-Bold',
                              color: FsColor.basicprimary),
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
                            color: FsColor.primaryvisitor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SwitchComplexPage(AppConstant.VIZLOG)),
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

            // MyVisitorsTrustCitizenPass(),

//            MyVisitorsApproval(),

            MyVisitorsVisitor(),

            MyVisitorsGuest(),
//
            MyVisitorsDomesticHelp(),
            selectedUnit['soc_id'].toString() == "412"
                ? GestureDetector(
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
                                  width: 1.0,
                                  color: FsColor.darkgrey.withOpacity(0.5)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Society Contact".toLowerCase(),
                                        style: TextStyle(
                                            fontSize:
                                            FSTextStyle.dashtitlesize,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.primaryvisitor),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
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
                                      Container(),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 1.0,
                                            color: FsColor.basicprimary
                                                .withOpacity(0.2)),
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        child: GestureDetector(
                                          child: FlatButton(
                                            onPressed:
                                            /*() {
                                          FsNavigator.push(
                                              context, MyDomesticHelpList());
                                        }*/
                                            null,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "Contact Now",
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
                FsNavigator.push(context, SocietyHelpSupport());
              },
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _backbtnClick(context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainDashboard()),
            (Route<dynamic> route) => false);
//    Navigator.popUntil(
//        context, ModalRoute.withName('/dashboard'));
  }

  Future<void> openSetting() async {
    bool internetConnection = await AppUtils.checkInternetConnection();

    Navigator.of(context).pop();
    if (internetConnection) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyVisitorSettingsPage(selectedUnit)),
      );
    } else {
      Toasly.error(context, "please check the internet connection");
    }
  }

  @override
  error(error) {
    // TODO: implement error
    Toasly.error(context, error.toString());
  }

  @override
  failure(failed) {
    // TODO: implement failure
    Toasly.error(context, failed.toString());
  }

  @override
  loginSuccess(success) {
    print("loginSuccess-------ddddddddddddddd");
    print(success);
//    vizLoginPresentor.getBuilding(this);
  }

  @override
  visitorSuccess(success) {
    // TODO: implement visitorSuccess
    return null;
  }

  void callLogin() {
    SsoStorage.getUserProfile().then((profile) {
      print("profile-----------------------------$profile");
      _userProfiew = profile;
      setState(() {});
      doLogin();
    });
  }

  @override
  void intercomError(error) {
    hasIntercom(false);
  }

  @override
  void intercomFailure(failure) {
    hasIntercom(false);
  }

  @override
  void intercomSuccess(success) {
    hasIntercom(true);
  }

  bool hasIntercomFeature = false;

  void hasIntercom(bool hasIntercom) {
    this.hasIntercomFeature = hasIntercom;
    setState(() {});
  }
}
