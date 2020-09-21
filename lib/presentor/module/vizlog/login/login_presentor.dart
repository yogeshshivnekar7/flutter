import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/model/vizlog/vizlog.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'login_view.dart';

class VizlogLoginPresentor {
  VizLoginView view;

  VizLogModel _vizLogModel;

  String _unitId;

  String _socId;

  VizlogLoginPresentor(VizLoginView param0) {
    this.view = param0;

    _vizLogModel = new VizLogModel();
  }

  bool _getVisitor = false;

  void doLogin(String userName, String sessionToken, String socId,
      String unitId, String userId, {bool getVisitor}) {
    print(
        "--------------doLogin---------------------------------------------------");
    _getVisitor = getVisitor;
    _socId = socId;
    _unitId = unitId;
//    socId TODO use later
    HashMap<String, String> parameter = new HashMap<String, String>();
    parameter["client_id"] = Environment()
        .getCurrentConfig()
        .vizlogClientId;
    parameter["client_secret"] =
        Environment()
            .getCurrentConfig()
            .vizlogClientSecret;
    parameter["grant_type"] = "password";
    parameter["platform"] = "android";
    parameter["username"] = userName;
    parameter["session_token"] = sessionToken;
    parameter["auto_login"] = "1";
    parameter["user_id"] = userId;
    parameter["company_id"] = _socId;
    _vizLogModel.doLogin(parameter, onSuccess, view.error, view.failure);
  }

  void onSuccess(success) {
    HashMap<String, String> hashMap = new HashMap();
    SsoStorage.setVizlogToken(success);
    hashMap["access_token"] = success["data"]["access_token"].toString();
    _vizLogModel.getVizProfile(
        hashMap, profileSucces, view.error, view.failure);
  }

  void profileSucces(success) {
    print("vizprofile---------- $success");
    SsoStorage.setVizProfile(success);

    if (_getVisitor != null && _getVisitor) {
      getVisitors(_socId, _unitId, isForToday: true);
    } else {
      view.loginSuccess(success);
    }
    print(
        "--------------profileSucces---------------------------------------------------");

//    getVisitors(_socId,_unitId);

//    view.loginSuccess(success);
  }

  void getVisitors(String _socId, String _unitId,
      {bool isForToday, String page, String memberId}) {
    SsoStorage.getVizlogToken().then((data) {
      print(
          "--------------getVizlogToken---------------------------------------------------");
      print(data);
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
      //      hashMap["visitor_type[]"] = "member";
      hashMap["visitor_type[0]"] = "guest";
//      hashMap["visitor_type[1]"] = "member";
//      hashMap["visitor_type[2]"] = "staff";
      if (page == null || page.length <= 0)
        hashMap["page"] = "1";
      else {
        hashMap["page"] = page;
      }
      if (isForToday != null && isForToday) {
        hashMap["only_today_visitor"] = "1";
      }
//      hashMap["start_date"] = AppUtils.getCurrentDate();
//      hashMap["end_date"] = AppUtils.getCurrentDate();
      hashMap["unit_id"] = _socId;

      if (memberId != null) {
        hashMap["member_id"] = memberId;
      } else {
        hashMap["member_id"] = null;
      }
      print(
          "--------------getVizlogToken---------------------------------------------------$hashMap");
      _vizLogModel.getVisitors(
          hashMap, _unitId, view.visitorSuccess, view.error, view.failure);
    });
  }

//  void getGuests(String _socId, String _unitId, {String page}) {
//    SsoStorage.getVizlogToken().then((data) {
//      print(
//          "--------------getVizlogToken---------------------------------------------------");
//      print(data);
//      HashMap<String, String> hashMap = new HashMap();
//      try {
//        hashMap["access_token"] = data["data"]["access_token"].toString();
//        if (page != null && page.length > 0) {
//          hashMap["page"] = page;
//        }
//      } catch (e, s) {
//        print(
//            "--------------ex---------------------------------------------------");
//        print(s);
//      }
//      hashMap["unit_id"] = _socId;
//      _vizLogModel.getGuests(
//          hashMap, _unitId, view.visitorSuccess, view.error, view.failure);
//    });
//  }

  void getStaff(String _socId, String _unitId) {
    SsoStorage.getVizlogToken().then((data) {
      print(
          "--------------getVizlogToken---------------------------------------------------");
      print(data);
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
      hashMap["unit_id"] = _socId;
      hashMap["is_track"] = "1";
      _vizLogModel.getStaff(
          hashMap, _unitId, view.visitorSuccess, view.error, view.failure);
    });
  }


  void getBuilding(IntercomView view, {bool allBuilding = false}) {
    SsoStorage.getVizlogToken().then((data) {
      print(
          "--------------getVizlogToken---------------------------------------------------");
      print(data);
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();


        hashMap["check_intercom_config"] = "1";
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
      _vizLogModel.getBuilding(
          hashMap, view.intercomSuccess, view.intercomError,
          view.intercomFailure);
    });
  }

}

abstract class IntercomView {
  void intercomSuccess(success);

  void intercomError(error);

  void intercomFailure(failure);

}
