import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/vizlog_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MyVisitorSettingsModule {
  Future<void> setVisitorApproval(String settingKey, bool settingValue,
      String memberId, IVisitorApprovaled iVisitorApproved) async {
    var accessTokenModel = await SsoStorage.getVizlogToken();
    print(memberId);
    print(accessTokenModel);
    HashMap<String, String> hashmap = new HashMap();
    hashmap["access_token"] = accessTokenModel["data"]["access_token"];
    hashmap["member_id"] = memberId;
    hashmap[settingKey] = settingValue ? "1" : "0";
    //hashmap["member_id"] = approved ? "1" : "0";

    NetworkHandler networkHandler = new NetworkHandler((success) {
      iVisitorApproved.onSuccessApproved(
          jsonDecode(success)["message"], settingKey);
    }, (failure) {
      iVisitorApproved.onFailedApproved(jsonDecode(failure), settingKey);
    }, (error) {
      iVisitorApproved.onErrorApproved(error, settingKey);
    });

    Network network =
        VizlogApiHandler.setVisitorApproval(networkHandler, hashmap);
    network.excute();
  }

  Future<void> getVisitorApprovals(IVisitorApprovals iVisitorApprovals) async {
    print("getvoidvoidVisitorApprovals");
    HashMap<String, String> hashmap = new HashMap();
    try {
      var accessTokenModel = await SsoStorage.getVizlogToken();
      print(accessTokenModel);
      hashmap["access_token"] = accessTokenModel["data"]["access_token"];
      print(hashmap);
      NetworkHandler networkHandler = new NetworkHandler((success) {
        print(success);
        iVisitorApprovals.onSuccessUnitsApprovals(jsonDecode(success)["data"]);
      }, (failure) {
        print(failure);
        iVisitorApprovals.onFailedUnitsApprovals(jsonDecode(failure));
      }, (error) {
        print(error);
        iVisitorApprovals.onErrorUnitsApprovals(error);
      });
      Network network =
          VizlogApiHandler.getVisitorApproval(networkHandler, hashmap);
      network.excute();
    } catch (e) {
      print(e);
    } //8055954796
  }

  Future<void> setMemberLog(String visitorId, String isLogVisible,
      IMemebrLoggedOnOff iMemebrLoggedOnOff) async {
    NetworkHandler networkHandler = new NetworkHandler((success) {
      iMemebrLoggedOnOff
          .onSuccessMemeberLoggedOnOff(jsonDecode(success)["data"]);
    }, (failure) {
      iMemebrLoggedOnOff.onFailedMemeberLoggedOnOff(jsonDecode(failure));
    }, (error) {
      iMemebrLoggedOnOff.onErrorMemeberLoggedOnOff(error);
    });
    var accessTokenModel = await SsoStorage.getVizlogToken();
    print(accessTokenModel);
    HashMap<String, String> hashmap = new HashMap();
    hashmap["access_token"] = accessTokenModel["data"]["access_token"];
    hashmap["is_log_visible"] = isLogVisible;
    hashmap["visitor_id"] = visitorId;
    Network network = VizlogApiHandler.showMemberLog(networkHandler, hashmap);
    network.excute();
  }

  Future<void> getMemberLog(
      String visitorId, String socId, IMemberLogGet iMemberLogGet) async {
    NetworkHandler networkHandler = new NetworkHandler((success) {
      iMemberLogGet.onSuccessMemberLog(jsonDecode(success)["data"]);
    }, (failure) {
      iMemberLogGet.onFailedMemberLog(jsonDecode(failure));
    }, (error) {
      iMemberLogGet.onErrorMemberLog(error);
    });
    var accessTokenModel = await SsoStorage.getVizlogToken();
    print(accessTokenModel);
    HashMap<String, String> hashmap = new HashMap();
    hashmap["access_token"] = accessTokenModel["data"]["access_token"];
    hashmap["unit_id"] = socId;
    Network network =
        VizlogApiHandler.getMemberLog(networkHandler, visitorId, hashmap);
    network.excute();
  }
}

abstract class IVisitorApprovaled {
  void onSuccessApproved(var approved, String settingKey);

  void onFailedApproved(var failure, String settingKey);

  void onErrorApproved(String error, String settingKey);
}

abstract class IVisitorApprovals {
  void onSuccessUnitsApprovals(List approved);

  void onFailedUnitsApprovals(var failure);

  void onErrorUnitsApprovals(String error);
}

abstract class IMemberLogGet {
  void onSuccessMemberLog(var approved);

  void onFailedMemberLog(var failure);

  void onErrorMemberLog(String error);
}

abstract class IMemebrLoggedOnOff {
  void onSuccessMemeberLoggedOnOff(var approved);

  void onFailedMemeberLoggedOnOff(var failure);

  void onErrorMemeberLoggedOnOff(String error);
}
