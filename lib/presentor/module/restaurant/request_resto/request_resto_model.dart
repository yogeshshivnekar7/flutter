import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/resto_api..dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class RequestRestoModel {
  RequestRestoModelResponse requestrestoModelResponse;

  RequestRestoModel(this.requestrestoModelResponse) {}

  addResto(String name, String brandName, String number, String email,
      String title) {
    SsoStorage.getUserProfile().then((profile) {
      var first_name =
      profile["first_name"] == null ? "" : profile["first_name"].toString();
      var last_name =
      profile["last_name"] == null ? "" : profile["last_name"].toString();
      //var last_nameuserName = first_name + " " + last_name;
      HashMap<String, String> hashMap = new HashMap();
      //var currentConfig = Environment().getCurrentConfig();
      hashMap["last_name"] = last_name;
      if (profile["email"] != null) {
        hashMap["email"] = profile["email"];
      }
      if (first_name.isEmpty && last_name.isEmpty) {} else
      if (first_name.isNotEmpty && last_name.isNotEmpty) {
        hashMap["first_name"] = first_name;
        hashMap["last_name"] = first_name;
      } else if (last_name.isNotEmpty) {
        hashMap["first_name"] = last_name;
        hashMap["last_name"] = last_name;
      } else if (first_name.isNotEmpty) {
        hashMap["first_name"] = first_name;
        hashMap["last_name"] = first_name;
      } else {
        print("not found");
      }
      hashMap["mobile"] = number;
      hashMap["phone"] = number;
      hashMap["company"] = brandName;
      hashMap["lead_resource"] = title;
      hashMap["api_key"] = Environment()
          .getCurrentConfig()
          .crm_api_key;
      hashMap["data[subject]"] =
      "$name has requested demo for $brandName with chairman/secretory name $name contact number $number";
      NetworkHandler netwrkHandler = new NetworkHandler((response) {
        requestrestoModelResponse.onSuccess(response);
      }, (response) {
        requestrestoModelResponse.onFailure(response);
      }, (response) {
        requestrestoModelResponse.onError(response);
      });

      Network networkt =
      RESTOAPIHandler.addRequestResto(hashMap, netwrkHandler);
      networkt.excute();
    });
  }
}

abstract class RequestRestoModelResponse {
  void onSuccess(String response);

  void onError(String error);

  void onFailure(String error);
}
