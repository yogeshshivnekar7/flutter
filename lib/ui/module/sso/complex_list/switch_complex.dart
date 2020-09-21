import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/complex_list/switch_complex.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_view.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_dashboard.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/complex_list.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class SwitchComplexPage extends StatefulWidget {
  String app;

  SwitchComplexPage(String app) {
    this.app = app;
  }

  @override
  _SwitchComplexPageState createState() => _SwitchComplexPageState(app);
}

class _SwitchComplexPageState extends State<SwitchComplexPage>
    implements IUnitsDetails, VizLoginView /*, ChsOneLoginView */ {
  SwitchComplexPresentor switchComplexPresentor;
  bool isLoading = true;

  String app;
  VizlogLoginPresentor vizLoginPresentor;

  var currentUnit;

  _SwitchComplexPageState(String app) {
    this.app = app;
  }

  @override
  void initState() {
    super.initState();
    switchComplexPresentor = SwitchComplexPresentor();
    if (this.app == AppConstant.CHSONE) {
      switchComplexPresentor.getAllChsoneUnits(this);
    } else {
      switchComplexPresentor.getAllVizlogUnits(this);
      vizLoginPresentor = new VizlogLoginPresentor(this);
    }
    isLoading = true;
  }

//  var currentUnit;
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: app == AppConstant.CHSONE
            ? FsColor.primaryflat
            : FsColor.primaryvisitor,
        elevation: 0.0,
        title: new Text(
          'my flats',
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(
          backEvent: (context) {
            _backbtnClick(context);
          },
        ),
      ),
      resizeToAvoidBottomPadding: false,
      body: isLoading
          ? PageLoader()
          : ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: complex == null ? 0 : complex.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map place = complex[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Card(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: const BorderRadius.all(
                              //     Radius.circular(4.0),
                              //   ),
                              //   side:
                              //       BorderSide(color: FsColor.lightgrey, width: 1.0),
                              // ),
                              elevation: 0.0,
                              child: InkWell(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 15.0,
                                    top: 15.0,
                                  ),
                                  // height: 85,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(width: 10),
                                      place["active"]
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.asset(
                                                "images/complex.png",
                                                height: 48,
                                                width: 48,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    height: 52.0,
                                                    width: 52.0,
                                                    child: Opacity(
                                                      opacity: 0.2,
                                                      child: Image.asset(
                                                        "images/complex.png",
                                                        height: 48,
                                                        width: 48,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 0,
                                                    child: Text(
                                                      "waiting\nfor\napproval",
                                                      style: TextStyle(
                                                          fontSize: FSTextStyle
                                                              .h7size,
                                                          fontFamily:
                                                              'Gilroy-SemiBold',
                                                          color: FsColor.red),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: ListView(
                                          primary: false,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .body1,
                                                      children: [
                                                    TextSpan(
                                                      text: '${place["name"]}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-SemiBold',
                                                        fontSize:
                                                            FSTextStyle.h6size,
                                                        color: FsColor
                                                            .basicprimary,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "${place["building"]}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-SemiBold',
                                                      fontSize: 13,
                                                      color: FsColor.lightgrey,
                                                    ),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.location_on,
                                                  size: 13,
                                                  color: FsColor.lightgrey,
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "${place["location"]}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-SemiBold',
                                                      fontSize: 13,
                                                      color: FsColor.lightgrey,
                                                    ),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                          height: 55.0,
                                          width: 100.0,
                                          alignment: Alignment.center,
                                          decoration: new BoxDecoration(
                                            border: new Border.all(
                                              width: 1.0,
                                              color: FsColor.lightgrey,
                                            ),
                                            borderRadius:
                                                new BorderRadius.circular(4.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'unit',
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h7size,
                                                    fontFamily:
                                                        'Gilroy-SemiBold',
                                                    color: FsColor.lightgrey),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${place["unit"]}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h3size,
                                                      fontFamily: 'Gilroy-Bold',
                                                      color: FsColor.darkgrey),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                ),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  place["active"]
                                      ? _unitClicked(place)
                                      : Toasly.error(
                                          context, "not yet approved");
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Text("need to connect more complex? don't worry!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.lightgrey,
                              fontFamily: 'Gilroy-SemiBold')),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                      child: GestureDetector(
                        child: RaisedButton(
                          child: Text('Add More',
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold')),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                          color: app == AppConstant.CHSONE
                              ? FsColor.primaryflat
                              : FsColor.primaryvisitor,
                          textColor: FsColor.white,
                          onPressed: () {
                            _showUnitsList(context);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  void _backbtnClick(BuildContext context) {
    Navigator.pop(context, true);
  }

  _showUnitsList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComplexList()),
    );
  }

  @override
  void unitError(data) {
    setState(() {
      isLoading = false;
      if (complex != null) {
        complex.clear();
      }
    });
  }

  @override
  void unitFailed(data) {
    setState(() {
      isLoading = false;
      if (complex != null) {
        complex.clear();
      }
    });
  }

  List complex;

  @override
  void unitSuccess(data, {String from}) {
    print(
        "---------------------------------------------------unitSuccess------------------------------------------");
    print(data);
    /*if (app == AppConstant.CHSONE) {
//      unitCHSONEPrepare(data);
      complex=data;
      setState(() {
        isLoading = false;
      });
    } else if (app == AppConstant.VIZLOG) {
//      unitVizlogPrepare(data);
    setState(() {
      complex=data;
      isLoading = false;

    });

    }*/
    setState(() {
      complex = data;
      isLoading = false;
    });
  }

  void unitCHSONEPrepare(data) {
    var units = data["data"];
    if (units != null) {
      complex = [];
      for (var soc in units["society_details"]) {
        if (soc["role"] != null && soc["role"].toString().contains("admin")) {
          var com = {};
          com["name"] = soc["soc_name"];
          com["building"] = "Admin";
          com["unit"] = "SO";
          com["unit_id"] = "0";
          com["soc_id"] = soc["soc_id"].toString();
          com["location"] = AppUtils.mergeAddressSSO(soc);
          com["active"] = true;
          complex.add(com);
        }
        var units = soc["unit_details"];
        if (units == null) {
          continue;
        }
        for (var u in units) {
          var com = {};
          com["name"] = soc["soc_name"]; //u["unit_flat_number"].toString();
          com["building"] = u["soc_building_name"].toString();
          com["unit"] = u["unit_flat_number"].toString();
          com["unit_id"] = u["unit_id"].toString();
          com["soc_id"] = soc["soc_id"].toString();
          com["location"] = AppUtils.mergeAddressSSO(
              soc); //           "Location is pending"; //u["unit_flat_number"].toString();
          com["active"] = u["approved"] == 1 ? true : false;
          complex.add(com);
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void _unitClicked(place) {
    /* print(place);
    print(complex);*/
    /* print(units);*/
    //print("sssssssssssssssssssssss");
    /*{name: Root Complex, building: R1, unit: 103, unit_id: 4, soc_id: 65, location: Vashi, active: true}*/
    var company = {
      "company_id": place["soc_id"],
      "company_name": place["name"]
    };
    if (app == AppConstant.CHSONE) {
      for (var a in complex) {
        if (a["unit_id"].toString() == place["unit_id"].toString() &&
            a["soc_id"].toString() == place["soc_id"].toString()) {
          //Toasly.success(context, "Show CHOSNE App");
          SsoStorage.setDefaultChsoneUnit(a);
          print(a["unit_id"]);
          print(place["unit_id"]);
          _openChsone(a, a["soc_id"], company);
          _commonUnit(a);
          break;
        }
      }
    } else if (app == AppConstant.VIZLOG) {
      for (var a in complex) {
        if (a["unit_id"].toString() == place["unit_id"].toString() &&
            a["soc_id"].toString() == place["soc_id"].toString()) {
          // Toasly.success(context, "Show Vizlog App");
          /* SsoStorage.setDefaultChsoneUnit(a);*/
          print(a["unit_id"]);
          print(place["unit_id"]);
          currentUnit = a;
          SsoStorage.setDefaultVizlogUnit(a);
          //          _openVizlog(a["soc_id"], company);
//          _openVizlogDashboard(a["soc_id"].toString(), a["unit_id"].toString());
          _commonUnit(a);
          break;
        }
      }
    }
  }

  _commonUnit(u) {
    if (app == AppConstant.CHSONE) {
      SsoStorage.getAllVizLogUnit().then((vizlogUnits) {
        setDefaultUnit(vizlogUnits, u);
      });
    } else {
      SsoStorage.getAllChsoneUnit().then((vizlogUnits) {
        setDefaultUnit(vizlogUnits, u);
      });
    }
  }

  void setDefaultUnit(vizlogUnits, u) {
    if (vizlogUnits != null) {
      for (var vizUnit in vizlogUnits) {
        if (vizUnit["active"]) {
          if (u["building"] == vizUnit["building"]) {
            app == AppConstant.CHSONE
                ? SsoStorage.setDefaultVizlogUnit(vizUnit)
                : SsoStorage.setDefaultChsoneUnit(vizUnit);
            break;
          }
        }
      }
      if (app == AppConstant.VIZLOG) {
        FsNavigator.push(
            context,
            MyVisitorsDashboard(
              currentUnit: u,
            ));
      }
    }
//    FsSocket().connectSocket01();
  }

  _openChsone(currentUnit, complexId, company) {
    List allUnits = [];
    complex.forEach((x) {
      allUnits.add(x);
    });
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => MyFlatsDashboard(currentUnit)),
    );

//    SsoStorage.getUserProfile().then((profile) {
//      //SsoStorage.getToken().then((accessToken) {
//      print("TTTTTTTTTTTTTTTT");
//      //   print(complexId);
//      autoLoginChsOne(profile, currentUnit, company);
//      /*responseFromNativeCode(
//            accessToken, profile, currentUnit, allUnits, company);*/
//      // });
//    });
  }

  _openVizlog(complexId, company) {
    SsoStorage.getUserProfile().then((profile) {
      SsoStorage.getToken().then((accessToken) {
        responseFromNativeCodeVizlog(accessToken, profile, complexId, company);
      });
    });
  }

  var platform = const MethodChannel('flutter.native/helper');

  Future<void> responseFromNativeCode(
      accessToken, profile, currentUnit, List allUnits, company) async {
    String response = "";
    try {
      if (currentUnit["unit_id"].toString() == "0") {
        final String result = await platform.invokeMethod('chsoneapp', {
          "profile": profile,
          "access_token": accessToken,
          "units": allUnits,
          "role": "admin",
          "company": company
        });
        response = result;
      } else {
        final String result = await platform.invokeMethod('chsoneapp', {
          "profile": profile,
          "access_token": accessToken,
          "units": allUnits,
          "current_unit": currentUnit,
          "role": "member",
          "company": company
        });
        response = result;
      }
    } on PlatformException catch (e) {
      print(e);
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      /* _responseFromNativeCode = response;*/
    });
  }

  Future<void> responseFromNativeCodeVizlog(
      accessToken, profile, complexId, company) async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('vizlogapp', {
        "profile": profile,
        "access_token": accessToken,
        "company": company
      });
      response = result;
    } on PlatformException catch (e) {
      print(e);
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      /* _responseFromNativeCode = response;*/
    });
  }

  void unitVizlogPrepare(data) {
    var units = data["data"];
    if (units != null) {
      complex = [];

      for (var u in units) {
        var com = {};
        Map complexData = u["complex"];
        com["name"] = complexData["complex_name"]
            .toString(); //u["unit_flat_number"].toString();
        com["soc_id"] = complexData["company_id"].toString();

        com["building"] = u["building_name"].toString();
        com["unit"] = u["unit_number"].toString();
        com["unit_id"] = u["building_unit_id"].toString();
        com["location"] = AppUtils.mergeAddressSSOVizlog(
            complexData); //           "Location is pending"; //u["unit_flat_number"].toString();
        com["active"] = u["status"] == "accepted" ? true : false;
        complex.add(com);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

/*
  List<Map<String, Object>> list() {
    return [
      {
        "id": 1,
        "auth_id": 23,
        "unit_id": 0,
        "company_id": 29,
        "member_id": 8,
        "user_role": "member",
        "building_unit_id": 43,
        "floor_no": "5",
        "unit_number": "B1505",
        "building_id": 1,
        "building_name": "Building 1",
        "status": "pending",
        "created_at": "2019-12-06 05:56:11",
        "updated_at": "2019-12-06 05:56:11",
        "complex": {
          "company_id": 29,
          "complex_name": "M Nexzone",
          "address_line_1": "Vashi",
          "address_line_2": "Navi mumbai",
          "near_landmark": null,
          "pincode": "400705",
          "city": "Navi mumbai",
          "state": null,
          "country": null
        }
      },
      {
        "id": 2,
        "auth_id": 23,
        "unit_id": 0,
        "company_id": 29,
        "member_id": 11,
        "user_role": "member",
        "building_unit_id": 47,
        "floor_no": "6",
        "unit_number": "B1601",
        "building_id": 1,
        "building_name": "Building 1",
        "status": "accepted",
        "created_at": "2019-12-06 10:26:57",
        "updated_at": "2019-12-06 11:09:06",
        "complex": {
          "company_id": 29,
          "complex_name": "M Nexzone",
          "address_line_1": "Vashi",
          "address_line_2": "Navi mumbai",
          "near_landmark": null,
          "pincode": "400705",
          "city": "Navi mumbai",
          "state": null,
          "country": null
        }
      }
    ];
  }*/

  void _openVizlogDashboard(String socId, String unitId) {
    FsNavigator.push(context, MyVisitorsDashboard());
//    SsoStorage.getUserProfile().then((profile) {
//      print(profile);
//      print(
//          "----------------------------------------------------------------------------------");
//      print(profile["username"]);
//      print(profile["session_token"]);
//      vizLoginPresentor.doLogin(
//          profile["username"].toString(), profile["session_token"].toString(),
//          socId, unitId, profile["user_id"].toString());
//    });
  }

  @override
  error(error) {
    Toasly.error(context, error.toString());
  }

  @override
  failure(failed) {
    Toasly.error(context, failed.toString());
  }

  @override
  loginSuccess(success) {
    print("succes-------------------$success");
//    Navigator.of(context).pushNamed('/visitordashboard');
    FsNavigator.push(context, MyVisitorsDashboard());
    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyVisitorsDashboard()),
    );*/
    // TODO: implement loginSuccess
    return null;
  }

  @override
  visitorSuccess(success) {
    // TODO: implement visitorSuccess
    return null;
  }

/*void autoLoginChsOne(profile, currentUnit, company) {
    setState(() {
      isLoading = true;
    });
    print("profile " + profile.toString());
    print("currentUnit " + currentUnit.toString());
    print("company " + company.toString());
    this.currentUnit = currentUnit;

    HashMap<String, String> hashMap = new HashMap();
    hashMap["username"] = profile["username"];
    hashMap["user_id"] = profile["user_id"].toString();
    hashMap["grant_type"] = "password";
    hashMap["session_token"] = profile["session_token"];
    hashMap["soc_id"] = company["company_id"];

    ChsOneLoginPresenter loginPresenter = new ChsOneLoginPresenter(this);
    loginPresenter.login_chsone(hashMap);
  }*/

/*@override
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
    print(response);
    var profilJson = json.decode(response);
    ChsoneStorage.saveChsoneAccessInfo(profilJson["data"]["access_info"]);
    ChsoneStorage.saveChsoneUserData(profilJson["data"]["user_data"]);
    openMyFlatDashboard();
  }

  void openMyFlatDashboard() {
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => MyFlatsDashboard(currentUnit)),
    );
  }*/
}
