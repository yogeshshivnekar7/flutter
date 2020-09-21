import 'dart:collection';
import 'dart:convert';

import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_dashboard.dart';
import 'package:sso_futurescape/ui/module/intro/intro_myflats.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/complex_list.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/ui/widgets/currency_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class SocietyCard extends StatefulWidget {
  Function() onSelect;
  static final GlobalKey<_SocietyCardState> staticGlobalKey =
      new GlobalKey<_SocietyCardState>();

  SocietyCard({this.onSelect}) : super(key: SocietyCard.staticGlobalKey);

  /*SocietyCard({Null Function() onSelect}) {
    super(key: Page2.currentStateKey);
    this.onSelect = onSelect;

  }*/

  /* void clickOnDashboard() {
    sss.societyIntroduction();
  }*/

  // _SocietyCardState sss;

  @override
  _SocietyCardState createState() => new _SocietyCardState(onSelect);
}

class _SocietyCardState extends State<SocietyCard>
    implements SocietyCardView /*, ChsOneLoginView */ {
  var btnName = "Connect";
  bool isSocietyAdded = true;

  String amountDue = "0";

  SocietyCardPresenter societyCardPresenter;

  var _userProfiew;

  Function() onSelect;

  _SocietyCardState(Function() onSelect) {
    this.onSelect = onSelect;
  } // =new SocietyCardPresnetor();
  @override
  void initState() {
    societyCardPresenter = new SocietyCardPresenter(this);
    super.initState();

    SsoStorage.getUserProfile().then((profile) {
      _userProfiew = profile;
      setUnitDetails(false);
    });
  }

  _openChsone(currentUnit, complexId, company) {
    SsoStorage.getUserProfile().then((profile) {
      //SsoStorage.getToken().then((accessToken) {
      print("TTTTTTTTTTTTTTTT");
      //   print(complexId);

      /*responseFromNativeCode(
            accessToken, profile, currentUnit, allUnits, company);*/
      // });
    });
  }

  var currentUnit = null;

  void setUnitDetails(bool param0) {
    UserUtils.getCurrentUnits().then((unit) {
      currentUnit = null;
      if (param0 && unit == null) {
        setState(() {
          btnName = "Connect";
          isSocietyAdded = false;
        });
      } else if (unit == null) {
        setState(() {
          isSocietyAdded = false;
          btnName = "Connect";
        });
        societyCardPresenter.getAllComplexUnit();
      } else {
        setState(() {
          currentUnit = unit;
          print(unit);
          btnName = "Enter";
          isSocietyAdded = true;
        });
        societyCardPresenter.getUnitDues(unit);
//        autoLoginChsOne();
      }
    });
  }

  /*void autoLoginChsOne() {
//    print("profile " + profile.toString());
//    print("currentUnit " + currentUnit.toString());
//    print("company " + company.toString());
//    this.currentUnit = currentUnit;

    HashMap<String, String> hashMap = new HashMap();
    hashMap["username"] = _userProfiew["username"];
    hashMap["user_id"] = _userProfiew["user_id"].toString();
    hashMap["grant_type"] = "password";
    hashMap["session_token"] = _userProfiew["session_token"];
    hashMap["soc_id"] = currentUnit["soc_id"];

    ChsOneLoginPresenter loginPresenter = new ChsOneLoginPresenter(this);
    loginPresenter.login_chsone(hashMap);
  }*/

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
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            noUnitAccess()
                                                ? "my flat"
                                                : currentUnit["building"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: noUnitAccess()
                                                    ? FSTextStyle.dashtitlesize
                                                    : FSTextStyle.h5size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.primaryflat),
                                          ),
                                          noUnitAccess()
                                              ? Container()
                                              : Text(
                                            currentUnit["unit"].toString(),
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.dashtitlesize,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.primaryflat),
                                          ),
                                        ],
                                      ),

                                      // child: Column(
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: <Widget>[
                                      //     Text(
                                      //       currentUnit == null
                                      //       ? "my flat"
                                      //       : currentUnit["building"].toString(),
                                      //       style: TextStyle(fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',color: FsColor.primaryflat),
                                      //     ),
                                      //     Text(
                                      //       currentUnit == null
                                      //       ? "" :
                                      //       currentUnit["unit"].toString(),
                                      //       style: TextStyle(fontSize: FSTextStyle.dashtitlesize, fontFamily: 'Gilroy-SemiBold',color: FsColor.primaryflat),
                                      //     ),

                                      //   ],
                                      // ),
                                      // child: Text(
                                      //   currentUnit == null
                                      //       ? "my flat"
                                      //       : currentUnit["building"].toString() +
                                      //       "/" +
                                      //       currentUnit["unit"].toString(),
                                      //   style: TextStyle(
                                      //       fontSize: FSTextStyle.dashtitlesize,
                                      //       fontFamily: 'Gilroy-SemiBold',
                                      //       color: FsColor.primaryflat),
                                      // ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      child: RaisedButton(
                                        elevation: 1.0,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(4.0),
                                        ),
                                        onPressed: () {
                                          societyIntroduction();
                                        },
                                        color: FsColor.primaryflat,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Text(
                                          btnName,
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-Bold',
                                              color: FsColor.white),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Image.asset("images/dash1.png",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fitHeight),
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
                        !isSocietyAdded && !openSwitchPage
                            ? Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                  child: Text(
                                    FsString.SOC_CART_TEXT.toLowerCase(),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.dashsubtitlesize,
                                        fontFamily: FSTextStyle
                                            .dashsubtitlefont,
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
                                    FsString.SOC_CART_TEXT,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize:
                                        FSTextStyle.dashsubtitlesize,
                                        fontFamily:
                                        FSTextStyle.dashsubtitlefont,
                                        color: FsColor.dashsubtitlecolor),
                                  ))
                                  : Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  AmountWithCurrencyWidget(
                                    AppUtils.getCurrentCurrency(),
                                    amountDue,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "Due",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                  SizedBox(height: 4.0),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    child: FlatButton(
                                      onPressed: () {
                                        openMyFlatDashboard();
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "View",
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                alignment: Alignment.center,
              )
            ],
          )),
      onTap: () {
        societyIntroduction();
      },
    );
  }

  _openListMenu(BuildContext context) async {
    print("jjjjjjjjjjjjjjjj");
    // var s = Navigator.pushNamed(context, '/complexadd');
//    var s = await Navigator.push<bool>(
//      context,
//      MaterialPageRoute(
////          builder: (context) => SwitchComplexPage(AppConstant.VIZLOG)),
//          builder: (context) => ComplexList()),
//    );
    FsNavigator.push(context, ComplexList());

    setUnitDetails(true);
    onSelect();
  }

  void _checkForProfile() {
    SsoStorage.getUserProfile().then((profile) async {
      _userProfiew = profile;
      print(profile);
      if (!isSocietyAdded) {
        bool isUnNotSet = false;
        if (_userProfiew["first_name"] == null ||
            _userProfiew["first_name"]
                .toString()
                .length <= 0) {
          isUnNotSet = true;
        }
        bool isEmailSet = false;
        if ((_userProfiew["email"] == null ||
            _userProfiew["email"]
                .toString()
                .length <= 0)) {
          isEmailSet = true;
        }

        bool status = await ChsoneStorage.getCsoneIntro();
        if (!status) {
          var s = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      IntroMyflats()) //MyflatsIntroduction()),
          );
          await ChsoneStorage.setCsoneIntro(true);
        }
        if (isUnNotSet || isEmailSet) {
          UpdateProfileDialog(context, onUpdateProfile,
              name: isUnNotSet, email: isEmailSet);
        } else {
          _openListMenu(context);
        }
      } else {
        openMyFlatDashboard();
      }
    });
  }

  bool noUnitAccess() {
    return currentUnit == null || !currentUnit["active"];
  }

  void openMyFlatDashboard() {
    AppUtils.checkInternetConnection().then((onValue) {
      if (onValue) {
        FsFacebookUtils.callCartClick(FsString.SOCIETY_CARD, 'card');
        if (openSwitchPage) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SwitchComplexPage(AppConstant.CHSONE)),
          );
        } else {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => MyFlatsDashboard(currentUnit)),
          );
        }
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }

  @override
  void unitError(data) {
    print(data);
  }

  @override
  void unitFailed(data) {
    print(data);
  }

  bool openSwitchPage = false;

  @override
  void unitSuccess(data, {String from}) {
    print(data);

    setState(() {
      if (data != null) {
        openSwitchPage = true;
        for (var u in data) {
          if (u["active"]) {
            openSwitchPage = false;
            break;
          }
//        complex.add(com);
        }
        print(
            "openSwitchPageopenSwitchPageopenSwitchPage-------------------------------------------------$openSwitchPage");
      }
    });
    setUnitDetails(true);
  }

  @override
  void dueError(error) {
    print(error);
  }

  @override
  void dueFailed(falied) {
    print(falied);
  }

  @override
  void dueSuccess(successs) {
    /*total_due_amount*/
    print(
        "------------------------------successs----------------------------------------- $successs");
    setState(() {
      amountDue = successs["data"]["total_due_amount"].toString();
    });
    print(successs);
  }

  onUpdateProfile() {
    print(
        "--------------------------------onUpdateProfile---------------------------");
    setState(() {
      SsoStorage.getUserProfile().then((profile) {
        _userProfiew = profile;
//        openMyFlatDashboard();
        _openListMenu(context);
      });
    });
  }

  Future<void> societyIntroduction() async {
    _checkForProfile();
  }

/*
  @override
  onChsLoginError(error) {
    // TODO: implement onError
    return null;
  }

  @override
  onChsLoginFailure(failed) {
    // TODO: implement onFailure
    return null;
  }

  @override
  onChsLoginSuccess(String response) {
    var profilJson = json.decode(response);
    ChsoneStorage.saveChsoneAccessInfo(profilJson["data"]["access_info"]);
    ChsoneStorage.saveChsoneUserData(profilJson["data"]["user_data"]);
  }*/
}

abstract class SocietyCardView implements IUnitsDetails, IUnitDue {}

class SocietyCardPresenter {
  SocietyCardView societyCardView;

  SocietyCardPresenter(SocietyCardView societyCardView) {
    this.societyCardView = societyCardView;
  }

  void getUnitDues(unit) {
    SocietyModel model = new SocietyModel();
    model.getUnitDues(unit, societyCardView.dueSuccess,
        societyCardView.dueFailed, societyCardView.dueError);
  }

  void getAllComplexUnit() {
    ChsoneModel model = new ChsoneModel();
    model.getAllComplexUnits(societyCardView.unitSuccess,
        societyCardView.unitFailed, societyCardView.unitError);
  }
}

class SocietyModel {
  void getUnitDues(unit, dueSuccess, dueFailed, dueError) {
    HashMap<String, String> hashTable = new HashMap<String, String>();
    NetworkHandler networkHandler = new NetworkHandler((success) {
      var response = jsonDecode(success);
      dueSuccess(response);
    }, (failure) {
      dueFailed(failure);
    }, (error) {
      dueError(error);
    });

    SsoStorage.getUserProfile().then((value) {
      hashTable["session_token"] = value["session_token"];
      hashTable["soc_id"] = unit["soc_id"].toString();
      if (unit != null) {
        hashTable["unit_id"] = unit["unit_id"].toString();
      }
      hashTable["username"] = value["username"];
      hashTable["user_id"] = value["user_id"].toString();
      print(hashTable);
      Network network = SSOAPIHandler.getUnitDues(networkHandler, hashTable);
      network.excute();
    }).catchError((e) {
      print(e);
    });
  }
}

class ChsoneModel {
  void getAllComplexUnits(Function unitSuccess, Function unitFailed,
      Function unitError) {
    HashMap<String, String> hashTable = new HashMap<String, String>();
    NetworkHandler networkHandler = new NetworkHandler((success) {
      var response = jsonDecode(success);
      var data = response["data"];
      if (data != null) {
        unitSuccess(unitCHSONEPrepare(data));
//        SsoStorage.setDefaultChsoneUnit(data[0]);
      } else {
        unitSuccess(response);
      }
    }, (failure) {
      unitFailed(failure);
    }, (error) {
      unitFailed(error);
    });

    SsoStorage.getUserProfile().then((value) {
      hashTable["session_token"] = value["session_token"];
      // hashTable["soc_id"] = "65";
      hashTable["username"] = value["username"];
      hashTable["user_id"] = value["user_id"].toString();
      Network network =
      SSOAPIHandler.getAllComplexUnits(networkHandler, hashTable);
      network.excute();
    }).catchError((e) {
      print(e);
    });
  }

  List unitCHSONEPrepare(units) {
//  var units = data["data"];
    List complex = [];
    if (units != null) {
      for (var soc in units["society_details"]) {
//        if (soc["role"] != null && soc["role"].toString().contains("admin")) {
//          var com = {};
//          com["name"] = soc["soc_name"];
//          com["building"] = "Admin";
//          com["unit"] = "SO";
//          com["unit_id"] = "0";
//          com["soc_id"] = soc["soc_id"].toString();
//          com["location"] = AppUtils.mergeAddressSSO(soc);
//          com["active"] = true;
//          complex.add(com);
//        }
        var units = soc["unit_details"];
        if (units == null) {
          continue;
        }
        for (var u in units) {
          var com = {};
          com["name"] = soc["soc_name"]; //u["unit_flat_number"].toString();
          com["building"] = u["soc_building_name"].toString().trim();
          com["unit"] = u["unit_flat_number"].toString().trim();
          com["unit_id"] = u["unit_id"].toString().trim();
          com["soc_id"] = soc["soc_id"].toString().trim();
          com["location"] = AppUtils.mergeAddressSSO(
              soc); //           "Location is pending"; //u["unit_flat_number"].toString();
          com["active"] = u["approved"] == 1 ? true : false;
          complex.add(com);
        }
      }
    }
    if (complex != null && complex.length > 0) {
      SsoStorage.setAllChsoneUnit(complex);
      return complex;
    } else {
      SsoStorage.setAllChsoneUnit(null);
      return null;
    }
  }
}

//Ne6q3NWWgRPmUJgmpvVj0tdysLDqy6RKwcI4UBnK

abstract class IUnitDue {
  void dueSuccess(var successs);

  void dueFailed(var falied);

  void dueError(var error);
}

class SocietyBillingModel {}

class AppConfig {
  int getCurrentCurrency() {
    return 0xf156;
  }

  setCurrentCurrency() {}
}
