import 'dart:collection';

import 'package:common_config/utils/firebase/firebase_util.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/sso/unit_building_setup/building_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/unit_building_setup/building_view.dart';
import 'package:sso_futurescape/ui/module/sso/unit_building_setup/pending_approval.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

import 'my_flutter_app_icons.dart';

class ConfirmDialog extends StatefulWidget {
  int _appAccess;

  var _selectedMemberType;

  var _complex;

  var _memberStatus;

  var _selectedUnit;

  var _selectedFloor;

  var _userProfie;

  String membership;

  var _selectedBuilding;

  ConfirmDialog(
      this._complex,
      this._selectedBuilding,
      this._selectedFloor,
      this._selectedUnit,
//      this._memberStatus,
      this._userProfie,
      this.membership,
      this._selectedMemberType,
      this._appAccess);

  @override
  _MyDialogState createState() => new _MyDialogState(
      this._complex,
      this._selectedBuilding,
      this._selectedFloor,
      this._selectedUnit,
//      this._memberStatus,
      this._userProfie,
      this.membership,
      this._selectedMemberType,
      this._appAccess);
}

class _MyDialogState extends State<ConfirmDialog> implements BuildingView {
  bool isLoading = false;

  int _appAccess;

  var _selectedMemberType;

  var _complex;

//  var _memberStatus;

  var _selectedUnit;

  var _selectedFloor;

  var _userProfie;

  String membership;

  var _selectedBuilding;

  BuildingPresenter _buildingPresenter;

  _MyDialogState(
      this._complex,
      this._selectedBuilding,
      this._selectedFloor,
      this._selectedUnit,
//      this._memberStatus,
      this._userProfie,
      this.membership,
      this._selectedMemberType,
      this._appAccess) {
    print(
        "----------------------------_selectedMemberType------------------------$_selectedMemberType");
    print(
        "----------------------------_userProfie------------------------$_userProfie");
    _buildingPresenter = new BuildingPresenter(this);
  }

//  Color _c = Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("please confirm",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h4size,
              color: FsColor.darkgrey)),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(7.0),
      ),
      content: Container(
        height: 250.0,
        alignment: Alignment.centerLeft,
        // width: 900.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                  (membership.toLowerCase() == "primary")
                                    ?'confirm your complex details so that we can send your details to complex office for approval'
                      :'confirm your complex details so that we can send your details to complex office and primary member for approval',
                  style: TextStyle(
                      fontFamily: 'Gilroy-Regular',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.darkgrey)),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(FlutterIcon.circle, color: FsColor.basicprimary, size: 8.0),
                    SizedBox(width: 10),
                    Text(_complex["company_name"],
                        style: TextStyle(
                            fontFamily: 'Gilroy-Bold',
                            fontSize: FSTextStyle.h5size,
                            color: FsColor.darkgrey)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(FlutterIcon.circle, color: FsColor.basicprimary, size: 8.0),
                    SizedBox(width: 10),
                    Text(_selectedBuilding["soc_building_name"].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy-Bold',
                            fontSize: FSTextStyle.h5size,
                            color: FsColor.darkgrey)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(FlutterIcon.circle, color: FsColor.basicprimary, size: 8.0),
                    SizedBox(width: 10),
                    Text(_selectedFloor["name"].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy-Bold',
                            fontSize: FSTextStyle.h5size,
                            color: FsColor.darkgrey)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(FlutterIcon.circle, color: FsColor.basicprimary, size: 8.0),
                    SizedBox(width: 10),
                    Text(_selectedUnit["unit_flat_number"].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy-Bold',
                            fontSize: FSTextStyle.h5size,
                            color: FsColor.darkgrey)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(FlutterIcon.circle, color: FsColor.basicprimary, size: 8.0),
                    SizedBox(width: 10),
                    Text(membership,
                        style: TextStyle(
                            fontFamily: 'Gilroy-Bold',
                            fontSize: FSTextStyle.h5size,
                            color: FsColor.darkgrey)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: FSTextStyle.h6size,
                color: FsColor.darkgrey),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
        ),
        isLoading
            ? SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(FsColor.darkgrey),
                  strokeWidth: 3.0,
                ),
              )
            : RaisedButton(
                child: new Text(
                  "Confirm",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.white),
                ),
                color: FsColor.primaryflat,
                onPressed: () {
                  /*if (_callingType == AppConstant.CHSONE) {
                  sendUnitRequestChsone(memberTypeId);
                } else if (_callingType == AppConstant.VIZLOG) {
                  sendUnitRequestVizlog(membership);
                }*/

                  if (_appAccess == AppConstant.BOTH ||
                      _appAccess == AppConstant.CHSONE_ACCESS) {
                    sendUnitRequestChsone();
                  } else if (_appAccess == AppConstant.VIZLOG_ACCESS) {
                    sendUnitRequestVizlog();
                  }
                  setState(() {
                    isLoading = true;
                  });
                  /*else if (_appAccess== AppConstant.CHSONE_ACCESS) {
                  sendUnitRequestChsone(memberTypeId);
                }*/
                },
              ),
      ],
    );
  }

  void sendUnitRequestChsone() {

    if (_selectedMemberType["is_approved"] != null) {
      if (_appAccess == AppConstant.BOTH) {
        sendUnitRequestVizlog();
      } else {
        routeToApprovalPage();
      }
      return;
    }
//    print("------------------------memberStatus----------------------$_memberStatus");
    sendData();
    String memberTypeId = _selectedMemberType["member_type_id"].toString();
    HashMap<String, String> registerMemberParams = new HashMap();
    registerMemberParams["soc_id"] = _complex["company_id"].toString();
//    if (_memberStatus != null) {
    if (_selectedMemberType["member_id"] != null) {
      registerMemberParams["member_id"] =
          _selectedMemberType["member_id"].toString();
//      }
//      if (_memberStatus["type"] != null) {
//        registerMemberParams["member_type"] = _memberStatus["type"].toString();
//      }
    }
    registerMemberParams["soc_building_id"] =
        _selectedUnit["soc_building_id"].toString();
    registerMemberParams["unit"] = _selectedUnit["unit_id"].toString();
    registerMemberParams["floor"] = _selectedFloor["floor_id"].toString();
    registerMemberParams["member_type_id"] = memberTypeId;
    registerMemberParams["user_id"] = _userProfie["user_id"].toString();
    registerMemberParams["member_first_name"] =
        _userProfie["first_name"].toString();
    registerMemberParams["member_last_name"] =
        _userProfie["last_name"].toString();
    registerMemberParams["member_mobile_number"] =
        _userProfie["mobile"].toString();
    String gender = _userProfie["gender"];
//    if (gender != null && gender.length > 0) {
//      registerMemberParams["member_gender"] = gender.toLowerCase();
//    }
    registerMemberParams["member_email_id"] = _userProfie["email"].toString();
    print(registerMemberParams);
    _buildingPresenter.sendUnitRequestChsone(registerMemberParams);
  }

  void sendUnitRequestVizlog() {
    sendData();
    String memberType = _selectedMemberType["member_type_name"].toString();
    if (_selectedMemberType["viz_is_taken"] != null) {
      /*setState(() {
        isLoading = false;
        if (_sendVizlogRequest) {
          setState(() {
            isLoading = false;
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PendingApprovalPage(_complex)),
            );
          });
        }
      });
      return;*/
      memberType = "family";
    }

    if (memberType.toLowerCase() == "primary") {
      memberType = "owner";
    } else if (memberType.toLowerCase() == "tenant") {
      memberType = "tenant";
    } else {
      memberType = "family";
    }
    HashMap<String, String> params = new HashMap<String, String>();

    params["visitor_type"] = "member";
    params["start_date"] = AppUtils.getCurrentDate();
    params["unit_id"] = _complex["company_id"].toString();
    params["api_key"] = Environment().getCurrentConfig().ssoApiKey;
    params["member_type"] = memberType;
    params["first_name"] = _userProfie["first_name"].toString();
//  params["username"]=
    params["last_name"] = _userProfie["last_name"].toString();
    params["user_id"] = _userProfie["user_id"].toString();
    params["mobile"] = _userProfie["mobile"].toString();
    String gender = _userProfie["gender"];
//    if (gender != null && gender.length > 0) {
//      params["gender"] = gender.toLowerCase();
//    }

    params["email"] = _userProfie["email"].toString();
//  params["state"]=
//  params["city"]=
//  params["country"]=
//  params["zip_code"]=
    print(params);
    String socBuildingId;
    String unitId;
    if (_appAccess == AppConstant.VIZLOG_ACCESS) {
      socBuildingId = _selectedUnit["soc_building_id"].toString();
      unitId = _selectedUnit["unit_id"].toString();
    } else if (_appAccess == AppConstant.BOTH) {
      socBuildingId = _selectedUnit["viz_soc_building_id"].toString();
      unitId = _selectedUnit["viz_unit_id"].toString();
    }
    _buildingPresenter.sendUnitRequestVizlog(
        _complex["company_id"].toString(), socBuildingId, unitId, params);
  }

  @override
  onBuildingFound(buildings) {
    // TODO: implement onBuildingFound
    return null;
  }

  @override
  onError(error) {
    print("ddddddddddddddddddddddddddddddd");
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
//    if(_appAccess !=AppConstant.BOTH){
//    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  onFailure(failure) {
    Toasly.error(context, AppUtils.errorDecoder(failure));
//    if(_appAccess !=AppConstant.BOTH) {
//    }
    setState(() {
      isLoading = false;
      if (_sendVizlogRequest) {
        routeToApprovalPage();
      }
    });
  }

  @override
  onMemberStatus(memberStatus) {
    // TODO: implement onMemberStatus
    return null;
  }

  @override
  onMemberTypeFound(memberType) {
    // TODO: implement onMemberTypeFound
    return null;
  }

  bool _sendVizlogRequest = false;

  @override
  onRequestSent(requestSent) {
    print(requestSent);
    if (_appAccess == AppConstant.BOTH &&
        _selectedUnit["viz_unit_id"] != null) {
      _sendVizlogRequest = true;
      sendUnitRequestVizlog();
    } else {
      routeToApprovalPage();
    }
  }

  void routeToApprovalPage() {
    setState(() {
      isLoading = false;
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PendingApprovalPage(_complex,membership)),
      );
    });
  }

  void sendData() {
    try {
      String companyId = _complex["company_id"].toString();
      String userId = _userProfie["user_id"].toString();

      FirebaseDatabaseUtils.saveComapnayUsers(companyId, userId);
    } catch (e) {

    }
  }
  @override
  onUnitFound(units) {
    // TODO: implement onUnitFound
    return null;
  }

  @override
  onVizRequestSent(requestSent) {
    routeToApprovalPage();
  }

  @override
  onVizlogBuildingFound(buildings) {
    // TODO: implement onVizlogBuildingFound
    return null;
  }

  @override
  onVizlogUnitFound(units) {
    // TODO: implement onVizlogUnitFound
    return null;
  }

  @override
  onMemberStatusVizlog(memberStatus) {
    // TODO: implement onMemberStatusVizlog
    throw UnimplementedError();
  }
}
