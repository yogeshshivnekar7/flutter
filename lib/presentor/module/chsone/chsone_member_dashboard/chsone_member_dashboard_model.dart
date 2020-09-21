import 'dart:collection';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class DashboardModel {
  RequestDashboardModelResponse dashboardModelResponse;

  DashboardModel(this.dashboardModelResponse);

  void getMyFlatDashboardDetails(HashMap<String, String> hashMap) {
    //var currentConfig = Environment().getCurrentConfig();
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        hashMap["token"] = access_info["access_token"];

        NetworkHandler netwrkHandler = new NetworkHandler(
                (response) => {dashboardModelResponse.onSuccess(response)},
                (response) => {dashboardModelResponse.onFailure(response)},
                (response) => {dashboardModelResponse.onError(response)});

        Network networkt =
        CHSONEAPIHandler.getMemberDashboardDetails(hashMap, netwrkHandler);
        networkt.excute();
      }
    });
  }
}

abstract class RequestDashboardModelResponse {
  void onSuccess(String response);

  void onError(String error);

  void onFailure(String error);
}
