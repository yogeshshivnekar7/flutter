import 'dart:collection';

import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_model.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_view.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class GatePresenter {
  IntercomView gateView;

  IntercomModel gateModel;

  GatePresenter(IntercomView gateView) {
    this.gateView = gateView;
    this.gateModel = new IntercomModel();
  }

  void getGateDetails(callingType, String unitId, {String search}) {
    SsoStorage.getVizlogToken().then((data) {
      HashMap<String, String> hashMap = new HashMap();
      try {
        hashMap["access_token"] = data["data"]["access_token"].toString();
        hashMap["unit_id"] = unitId;
        hashMap["per_page"] = "100";
        if (search != null) {
          hashMap["search"] = search;
        }

        gateModel.getGateDetails(
            gateView.success, gateView.error, gateView.failure, hashMap,
            callingType: callingType);
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
        gateModel.initiatCall(gateView.success, gateView.error,
            gateView.failure, callingType, hashMap);
      });
    });
  }
}
