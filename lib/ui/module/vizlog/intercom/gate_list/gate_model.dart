import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/vizlog_api.dart';

class IntercomModel {
  void getGateDetails(onSuccess, onError, onFailure, HashMap hashMap,
      {callingType}) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = VizlogApiHandler.getGateDetails(a, hashMap);
    network.excute();
  }

  String errorDecoder(userFalure) {
    return AppUtils.errorDecoder(userFalure);
  }

  void initiatCall(success, error, failure, callingType, hashMap) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = VizlogApiHandler.initiateCall(a, hashMap);
    network.excute();
  }

  void getMemberDetails(success, error, failure, callingType, page, hasMap,
      {String buildingId}) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network =
        VizlogApiHandler.getMemberDetails(a, hasMap, buildingId: buildingId);
    network.excute();
  }

  void loadCommitteeMembers(success, error, failure, callType, hashMap) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callType);
    }, (e) {
      error(e, callingType: callType);
    });
    Network network = VizlogApiHandler.loadCommitteeMembers(a, hashMap);
    network.excute();
  }
}
