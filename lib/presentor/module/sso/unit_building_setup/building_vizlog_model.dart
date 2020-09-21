import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class BuildingVizlogModel {
  void getBuildings(String socId, onBuildingFound, onError, onFailure) {
    HashMap<String, String> hashMap = new HashMap();
    hashMap["session_token"] = Environment().getCurrentConfig().ssoApiKey;
    NetworkHandler a = new NetworkHandler((s) {
      onBuildingFound(jsonDecode(s.toString()));
    }, (f) {
      onFailure(jsonDecode(f));
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getBuildingVizlog(a, socId, hashMap);
    network.excute();
  }

  void getUnits(String socId, String buildingId, String floorId, onUnitFound,
      onError, onFailure) {
    HashMap<String, String> hashMap = new HashMap();
    hashMap["session_token"] = Environment().getCurrentConfig().ssoApiKey;
    hashMap["floor"] = floorId;
    hashMap["unit_id"] = socId;
    NetworkHandler a = new NetworkHandler((s) {
      onUnitFound(jsonDecode(s.toString()));
    }, (f) {
      onFailure(jsonDecode(f));
    }, (e) {
      onError(e);
    });
    Network network =
        SSOAPIHandler.getVizlogUnit(a, socId, buildingId, hashMap);
    network.excute();
  }

  void sendUnitRequestVizlog(
      socId,
      buildingId,
      unitId,
      HashMap<String, String> registerMemberParams,
      onRequestSent,
      onError,
      onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onRequestSent(jsonDecode(s.toString()));
    }, (f) {
      onFailure(jsonDecode(f));
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.postMemberRegisterVizlog(
        a, socId, buildingId, unitId, registerMemberParams);
    network.excute();
  }
}
