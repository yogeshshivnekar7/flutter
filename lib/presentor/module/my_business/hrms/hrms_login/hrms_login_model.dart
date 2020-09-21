import 'dart:collection';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/hrms_api.dart';

class HRMSLoginModel {
  RequestHRMSLoginModelResponse _hrmsLoginModelResponse;

  HRMSLoginModel(this._hrmsLoginModelResponse);

  login_hrms(HashMap<String, String> hashMap) async {
    NetworkHandler netwrkHandler = new NetworkHandler(
        (response) => {_hrmsLoginModelResponse.onSuccess(response)},
        (response) => {_hrmsLoginModelResponse.onFailure(response)},
        (response) => {_hrmsLoginModelResponse.onError(response)});

    Network networkt = await HRMSAPIHandler.loginHRMS(hashMap, netwrkHandler);
    networkt.excute();
  }
}

abstract class RequestHRMSLoginModelResponse {
  void onSuccess(String response);

  void onError(String error);

  void onFailure(String error);
}
