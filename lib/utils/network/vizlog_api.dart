import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';

import 'api_handler.dart';

class VizlogApiHandler {
  static Network vizLogin(NetworkHandler a, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().vizlogAppUrl + "users/login", hashMap);
    return network;
  }

  static Network getVizProfile(
      NetworkHandler a, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().vizlogAppUrl + "users/profile",
        hashMap);
    return network;
  }

  static Network getVisitors(
      NetworkHandler a, String unitId, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().vizlogAppUrl +
            "visits/logs/units/" +
            unitId,
        hashMap);
    return network;
  }

  static Network getGuest(NetworkHandler a, String unitId,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "members/" +
            unitId +
            "/guests",
        hashMap);
    return network;
  }

  static Network getStaff(NetworkHandler a, String unitId,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "members/" +
            unitId +
            "/staffs/log",
        hashMap);
    return network;
  }

  static Network setVisitorApproval(NetworkHandler handler, HashMap hashmap) {
    print(hashmap);
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    var url =
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl + "members/approval";
    network.putRequest(url, hashmap);
    print(url);
    return network;
  }

  static Network getVisitorApproval(NetworkHandler handler, HashMap hashmap) {
    print(hashmap);
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    var url =
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl + "members/approval";
    network.getRequest(url, hashmap);
    print(url);
    return network;
  }

  static Network getMemberLog(NetworkHandler networkHandler, String visitorId,
      HashMap hashMap) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
//            .vizlogAppUrl + "members/log/visiblity",
            .vizlogAppUrl +
            "visitors/${visitorId}",
        hashMap);
    return network;
  }

  static Network showMemberLog(NetworkHandler networkHandler, HashMap hashMap) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.putRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl + "members/log/visiblity",
        hashMap);
    return network;
  }

  static Network getDemesticHelp(NetworkHandler networkHandler, String unitId,
      HashMap hashMap) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "member/unit/$unitId/staff",
        hashMap);
    return network;
  }

  static Network getTrackDemesticHelpStaf(NetworkHandler handler,
      HashMap<String, String> hashMap) {
    print(hashMap);
    Network network = new Network(handler);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.putRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "members/track/staff",
        hashMap);
    return network;
  }

  static Network postVisitor(NetworkHandler a,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "visitors",
        hashMap);
    return network;
  }

  static Network postInviteGuest(NetworkHandler a,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "expected/guest",
        hashMap);
    return network;
  }

  static Network putInviteGuest(NetworkHandler a,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.putRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "expected/guest/" + hashMap["added_to"].toString(),
        hashMap);
    return network;
  }

  static Network getGlobalVisitor(NetworkHandler a,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "global/vpasses",
        hashMap);
    return network;
  }

  static Network getExpectedGuest(NetworkHandler a,
      HashMap<String, String> hashMap, String unitId) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "expected/$unitId/unit",
        hashMap);
    return network;
  }

  static Network getGateDetails(NetworkHandler a, HashMap hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "gates",
        hashMap);
    return network;
  }

  static Network initiateCall(NetworkHandler a, hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "members/gate/gsm",
        hashMap);
    return network;
  }

  static Network getBuilding(NetworkHandler a,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl +
            "buildings",
        hashMap);
    return network;
  }

  static Network getMemberDetails(NetworkHandler a,
      HashMap<String, String> hashMap, {String buildingId}) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    if (buildingId == null || buildingId.length <= 0) {
      buildingId = "1";
    }
    var uri = "buildings/" + buildingId + "/members";
    network.getRequest(
        Environment().getCurrentConfig().vizlogAppUrl + uri, hashMap);
    return network;
  }

  static Network loadCommitteeMembers(
      NetworkHandler a, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    var uri = "members/committee";
    network.getRequest(
        Environment().getCurrentConfig().vizlogAppUrl + uri, hashMap);
    return network;
  }
}
