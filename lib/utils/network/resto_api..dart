import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/end_point.dart';

import 'api_handler.dart';

class RESTOAPIHandler {
  static Network getNetworkRequest(NetworkHandler a) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest("http://localhost:35839/#/");
    return network;
  }

  static Network getLoginRequest(NetworkHandler a,
      HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["client_id"] = currentConfig.ssoClientId;
    hashMap["client_secret"] = currentConfig.ssoClientSecret;

    /*hashMap["username"] = userName;
    hashMap["password"] = password;*/
    /* print("params- " + hashMap.toString());*/
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl + Constant.USER_LOGIN,
        hashMap);
    return network;
  }

  static Network addRequestResto(Map<String, String> hashMap,
      NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();

    Network network = new Network(networkHandler);

    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.restoApiUrl + Constant.REQUEST_RESTO, hashMap);
    return network;
  }
}
