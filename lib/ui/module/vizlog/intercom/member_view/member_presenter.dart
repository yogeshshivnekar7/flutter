import 'dart:collection';

import 'package:sso_futurescape/model/vizlog/vizlog.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_model.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_view.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MemberPresenter {
  IntercomView intercomView;

  IntercomModel intercomModel;

  MemberPresenter(IntercomView intercomView) {
    this.intercomView = intercomView;
    this.intercomModel = new IntercomModel();
  }

  void getBuilding() {
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

      VizLogModel _vizLogModel = new VizLogModel();
      _vizLogModel.getBuilding(
          hashMap, intercomView.success, intercomView.error,
          intercomView.failure);
    });
  }


  void getGateDetails(
    callingType,
    String unitId,
  ) {
    SsoStorage.getVizlogToken().then((data) {
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        hashMap["unit_id"] = unitId;
        intercomModel.getGateDetails(intercomView.success, intercomView.error,
            intercomView.failure, hashMap,
            callingType: callingType);
      } catch (e, s) {}
    });
  }

  void getMemberDetails(callingPage, page, {String search, String buildingId, String perPage}) {
    SsoStorage.getVizlogToken().then((data) {
      HashMap<String, String> hashMap = new HashMap();
      try {
//        print("serarch         --- "+search);
        hashMap["access_token"] = data["data"]["access_token"].toString();
        if (buildingId == null || buildingId.length <= 0) {
          hashMap["all_members"] = "1";
        }
        hashMap["page"] = page;
        if(perPage!=null && perPage.length>0) {
          hashMap["per_page"] = perPage;
        }
        if(search!=null && search.length>0) {
          hashMap["search"] = search;
        }

        intercomModel.getMemberDetails(intercomView.success, intercomView.error,
            intercomView.failure, callingPage, page, hashMap,
            buildingId: buildingId);
      } catch (e, s) {}
    });
  }

  void initiatCall(String to, callingType) {
    SsoStorage.getUserProfile().then((data) {
      print("data ----- $data");
      String from = data["mobile"];
      HashMap<String, String> hashMap = new HashMap();
      hashMap["to"] = to;
      hashMap["from"] = from;
      SsoStorage.getVizlogToken().then((token) {
        hashMap["access_token"] = token["data"]["access_token"].toString();
        intercomModel.initiatCall(intercomView.success, intercomView.error,
            intercomView.failure, callingType, hashMap);
      });
    });
  }

  void loadCommitteeMembers(callType, String societyId, {String search}) {
    SsoStorage.getVizlogToken().then((data) {
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        hashMap["unit_id"] = societyId == null ? "" : societyId;
        if (search != null && search.trim().isNotEmpty) {
          hashMap["search"] = search;
        }

        intercomModel.loadCommitteeMembers(intercomView.success,
            intercomView.error, intercomView.failure, callType, hashMap);
      } catch (e) {}
    });
  }
}
