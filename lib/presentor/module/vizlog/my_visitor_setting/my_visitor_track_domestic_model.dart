import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/vizlog_api.dart';
import 'package:sso_futurescape/utils/storage/vizlog_storage.dart';

class MyVisitorTrackDomesticModel {
  getDemesticHelpStaff(IDomesticHelpList idomesticHelpList, String companyId,
      String unitId) async {
    HashMap hashMap = new HashMap<String, String>();
    hashMap["access_token"] = await VizlogStorage.getAccessToken();
    hashMap["unit_id"] = companyId.toString();
    NetworkHandler handler = new NetworkHandler((success) {
      var data = jsonDecode(success)["data"];
      idomesticHelpList.successDomesticHelpList(
          data["metadata"], data["results"]);
    }, (failure) {
      idomesticHelpList.failureDomesticHelpList(jsonDecode(failure));
    }, (error) {
      idomesticHelpList.errorDomesticHelpList(error);
    });
    Network network =
        VizlogApiHandler.getDemesticHelp(handler, unitId, hashMap);
    network.excute();
  }

  getTrackDemesticHelpStaff(success, failed, String trackBy,
      String trackTo) async {
    HashMap hashMap = new HashMap<String, String>();
    hashMap["access_token"] = await VizlogStorage.getAccessToken();
    hashMap["track_to"] = trackTo;
    hashMap["track_by"] = trackBy;

    NetworkHandler handler = new NetworkHandler((successResponse) {
      success(jsonDecode(successResponse));
    }, (failure) {
      failed(jsonDecode(failure));
    }, (error) {
      failed(error);
    });
    Network network =
        VizlogApiHandler.getTrackDemesticHelpStaf(handler, hashMap);
    network.excute();
  }
}

abstract class ITrackDomesticHelp {
  void successTrackDomesticHelp(dynamic jsonDecode);

  void failureTrackDomesticHelp(dynamic jsonDecode);

  void errorTrackDomesticHelp(String error);
}

abstract class IDomesticHelpList {
  void successDomesticHelpList(dynamic metadata, dynamic receiptList);

  void failureDomesticHelpList(dynamic jsonDecode);

  void errorDomesticHelpList(String error);
}
