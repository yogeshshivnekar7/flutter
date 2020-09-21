import 'dart:collection';

import 'package:sso_futurescape/model/vizlog/vizlog.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/expected_guest_view.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest_view.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';


class GuestPresenter {
  GuestView guestView;

  VizLogModel _vizLogModel;

  HashMap<String, String> _hashMap;

  HashMap<String, String> hmInvitGuset;

  GuestPresenter(this.guestView) {
    _vizLogModel = new VizLogModel();
  }

  void inviteGuest(HashMap<String, String> hashMap) {
    SsoStorage.getVizlogToken().then((data) {
      _hashMap = hashMap;
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
      } catch (e, s) {}
      print("guestName ---------------------- " + _getName());

      _hashMap["guest_name"] = _getName();
      print(
          "--------------getVizlogToken---------------------------------------------------$_hashMap");
      _vizLogModel.postInviteGuest(
          hashMap, guestView.success, guestView.error, guestView.failure);
    });
  }

  void reInviteGuest(HashMap<String, String> hashMap) {
    SsoStorage.getVizlogToken().then((data) {
      _hashMap = hashMap;
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
      } catch (e, s) {}
//      print("guestName ---------------------- " + _getName());

      var name = _getName();
      if (name != null) {
        _hashMap["guest_name"] = name;
      }
      print(
          "--------------getVizlogToken---------------------------------------------------$_hashMap");
      _vizLogModel.putInviteGuest(
          hashMap, guestView.success, guestView.error, guestView.failure);
    });
  }

  void addNewGuest(HashMap<String, String> hashMap) {
    SsoStorage.getVizlogToken().then((data) {
      print(
          "--------------getVizlogToken---------------------------------------------------");
      print(data);

      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
      _hashMap = hashMap;
//      visitorSuccess(null);
      _vizLogModel.postVisitor(
          hashMap, _visitorSuccess, guestView.error, guestView.failure);
    });
  }

  void _visitorSuccess(success) {
//    hmInvitGuset = new HashMap();
//    _hashMap["unit_id"];
//    _hashMap["building_unit_id"];
//    _hashMap["coming_from"];
//    _hashMap["visitor_type"];
//    _hashMap["pass_type"];
//    _hashMap["pass_validity"];
//    _hashMap["purpose"];
//    _hashMap["expected_date_time"];
//    _hashMap["is_existing_guest"];
//    _hashMap["added_by"];
//    print(success);
//    print(success["data"]["visitor_id"]);
    _hashMap["added_to"] = success["data"]["visitor_id"].toString();
    var name = _getName();
    if (name != null) {
      _hashMap["guest_name"] = name;
    }

    _vizLogModel.postInviteGuest(
        _hashMap, guestView.success, guestView.error, guestView.failure);
  }

  String _getName() {
    try {
      print(
          "----------------------------getName-----------------------$_hashMap");
      if (_hashMap["last_name"] != null && _hashMap["last_name"].length > 0) {
        return _hashMap["first_name"] + " " + _hashMap["last_name"];
      }
      return _hashMap["first_name"] != null ? _hashMap["first_name"] : null;
    } catch (e) {
      print("-----------------------e----------------$e");
      return null;
    }
  }

  void getGlobalVisitor(String mobileNo, String socId) {
    SsoStorage.getVizlogToken().then((data) {
      print(
          "--------------getVizlogToken---------------------------------------------------");
      print(data);
      HashMap<String, String> hashMap = new HashMap();

      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        hashMap["unit_id"] = socId;
        hashMap["mobile"] = mobileNo;
        _vizLogModel.getGlobalVisitor(
            hashMap, guestView.success, guestView.error, guestView.failure);
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
    });
  }

  void getExpectedGuest(
      HashMap<String, String> hashMap, String socId, String unitId) {
    SsoStorage.getVizlogToken().then((data) {
      print("-------------getVizlogToken----------------------------");
      print(data);

      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        hashMap["unit_id"] = socId;
        hashMap["member_privacy"] = "1";

        _vizLogModel.getExpectedGuest(unitId, hashMap, guestView.success,
            guestView.error, guestView.failure);
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
    });
  }

  static void getExpectedGuestCount(HashMap<String, String> hashMap,
      String socId, String unitId, ExpectedGuestView expectedGuestView) {
    SsoStorage.getVizlogToken().then((data) {
      print("-------------getVizlogToken----------------------------");
      print(data);

      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        hashMap["unit_id"] = socId;
        VizLogModel _vizLogModel = new VizLogModel();
        _vizLogModel.getExpectedGuest(
            unitId, hashMap, expectedGuestView.onTodaysExpectedGuest,
            expectedGuestView.onGuestError, expectedGuestView.onGuestFailure);
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
    });
  }

  void getGuests(String _socId, String _unitId,
      {String page, bool visitedGuest}) {
    SsoStorage.getVizlogToken().then((data) {
      print(
          "--------------getVizlogToken---------------------------------------------------");
      print(data);
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        if (page != null && page.length > 0) {
          hashMap["page"] = page;
        }
        hashMap["member_privacy"] = "1";
        if (visitedGuest != null && !visitedGuest) {
          hashMap["not_visited"] = "1";
        } else {
          hashMap["expected_visited"] = "1";
        }
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
      hashMap["unit_id"] = _socId;
      _vizLogModel.getGuests(hashMap, _unitId, guestView.success,
          guestView.error, guestView.failure);
    });
  }

  void getStaff(String _socId, String _unitId, {String page}) {
    SsoStorage.getVizlogToken().then((data) {
      print(
          "--------------getVizlogToken---------------------------------------------------");
      print(data);
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        if (page != null && page.length > 0) {
          hashMap["page"] = page;
        }
      } catch (e, s) {
        print(
            "--------------ex---------------------------------------------------");
        print(s);
      }
      hashMap["unit_id"] = _socId;
      hashMap["is_track"] = "1";
      _vizLogModel.getStaff(hashMap, _unitId, guestView.success,
          guestView.error, guestView.failure);
    });
  }
}
