import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class BuildingModel {
  void getBuildings(String socId, onBuildingFound, onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onBuildingFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getBuildings(a, socId);
    network.excute();
  }

  void getUnits(String socId, String buildingId, String floor, onUnitFound,
      onError, onFailure) {
    HashMap<String, String> map = new HashMap();

    map["floor"] = floor;
    map["building_id"] = buildingId;
    NetworkHandler a = new NetworkHandler((s) {
      onUnitFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getUnits(a, map, socId);
    network.excute();
  }

  void getMemberStatus(
      String socId, String unitId, onMemberStatus, onError, onFailure) {
    HashMap<String, String> map = new HashMap();

    map["soc_id"] = socId;
    map["unit_id"] = unitId;
    NetworkHandler a = new NetworkHandler((s) {
      onMemberStatus(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getMemberStatus(a, map);
    network.excute();
  }

  void getMemberType(String socId, onMemberTypeFound, onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onMemberTypeFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getMemberType(a, null, socId);
    network.excute();
  }

  void sendUnitRequestChsone(HashMap<String, String> registerMemberParams,
      onRequestSent, onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onRequestSent(jsonDecode(s.toString()));
    }, (f) {
      print("responsecccccccccccccccccccc");
      onFailure(jsonDecode(f));
    }, (e) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      onError(e);
    });
    Network network = SSOAPIHandler.postMemberRegister(a, registerMemberParams);
    network.excute();
  }

  void getMemberStatusVizlog(String socId, String unitId,
      memberStatusFoundVizlog, onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      memberStatusFoundVizlog(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getMemberStatusVizlog(a, socId, unitId);
    network.excute();
  }
}
