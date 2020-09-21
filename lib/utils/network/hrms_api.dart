import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'api_handler.dart';

class HRMSAPIHandler {
//public static
  static punchAttendance(HashMap hashMap, NetworkHandler netwrkHandler) async {
    Network network = new Network(netwrkHandler);
    print("Request Param " + hashMap.toString());
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    String url = await getHRMSUrl();
    var url2 = url + "time/punches";
    network.postRequest(url2, hashMap);
    return network;
  }

  static trackLocation(HashMap hashMap, NetworkHandler netwrkHandler) async {
    Network network = new Network(netwrkHandler);

    print("Request Param " + hashMap.toString());
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    String url = await getHRMSUrl();
    var url2 = url + "time/locations";
    network.postRequest(url2, hashMap);
    return network;
  }

  static getAttendance(HashMap hashMap, NetworkHandler netwrkHandler) async {
    Network network = new Network(netwrkHandler);

    print("Request Param " + hashMap.toString());
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    String url = await getHRMSUrl();
    var url2 = url + "time/punches";
    network.getRequest(url2, hashMap);
    return network;
  }

  static loginHRMS(HashMap<String, String> hashMap,
      NetworkHandler netwrkHandler) async {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    hashMap["client_id"] = currentConfig.hrmsClientId;
    hashMap["client_secret"] = currentConfig.hrmsClientSecret;
    print("Request Param " + hashMap.toString());
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    String url = await getHRMSUrl();
    var url2 = url + "users/login";
    network.postRequest(url2, hashMap);
    return network;
  }

  static Future<String> getHRMSUrl() async {
    List _companies = await SsoStorage.getHRMSCompany();
    List _companies1 = _companies;
    String url = _companies1[0]['api_end_point'] +
        "/" +
        _companies1[0]['api_version'] +
        "/";
    return url;
  }
}
