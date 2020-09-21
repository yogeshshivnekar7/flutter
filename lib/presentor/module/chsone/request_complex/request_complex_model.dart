import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class RequestComplexModel {
  RequestComplexModelResponse requestComplexModelResponse;

  RequestComplexModel(this.requestComplexModelResponse) {}

  addComplexRequest(String name, String complexName, String phone) {
    SsoStorage.getUserProfile().then((profile) {
      var first_name =
      profile["first_name"] == null ? "" : profile["first_name"];
      var last_name = profile["last_name"] == null ? "" : profile["last_name"];
      var userName = first_name + " " + last_name;

      HashMap<String, String> hashMap = new HashMap();
      var currentConfig = Environment().getCurrentConfig();
      hashMap["data[name]"] = userName;
      if (profile["email"] != null) {
        hashMap["data[email]"] = profile["email"];
      }
      hashMap["data[phone]"] = profile["mobile"];

      hashMap["data[subject]"] =
      "$userName has requested demo for $complexName with chairman/secretory name $name contact number $phone";

      NetworkHandler netwrkHandler = new NetworkHandler(
              (response) => {requestComplexModelResponse.onSuccess(response)},
              (response) => {requestComplexModelResponse.onFailure(response)},
              (response) => {requestComplexModelResponse.onError(response)});

      Network networkt =
      CHSONEAPIHandler.addRequestComplex(hashMap, netwrkHandler);
      networkt.excute();
    });
  }
}

abstract class RequestComplexModelResponse {
  void onSuccess(String response);

  void onError(String error);

  void onFailure(String error);
}
