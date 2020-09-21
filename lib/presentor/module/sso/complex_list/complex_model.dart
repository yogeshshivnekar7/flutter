import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/logger.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class ComplexModel {
  void searchComplex(String search, onComplexFound, onError, onFailure,
      clearList) {
    if (search.length < 3) {
      clearList();
      return;
    }
    bool pinSearch = true;
    try {
      int.parse(search);
//      print(q);
    } catch (e) {
      pinSearch = false;
//      print("--------------------------excep-----------------------");
    }
    if (pinSearch && search.length < 6) {
      clearList();
      return;
    }

    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    if (pinSearch) {
      hashMap["zip_code"] = search;
    } else {
      hashMap["search"] = search;
    }


//    hashMap["filter"] = "type:society";

    Logger.log("api - " + currentConfig.ssoApiKey + "  search -" + search);

    NetworkHandler a = new NetworkHandler((s) {
//      print(s.runtimeType.toString());

      //var jsonDecode2 = jsonDecode(s);
//      Logger.log("JSON_------------------ "+jsonDecode2);
      onComplexFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getSearchSocieties(a, hashMap);
    network.excute();
  }
}
