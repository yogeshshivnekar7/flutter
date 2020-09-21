import 'dart:collection';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';

class ChsOneLoginModel {
  RequestChsOneLogindModelResponse _chsOneLogindModelResponse;

  ChsOneLoginModel(this._chsOneLogindModelResponse);

  login_chsone(HashMap<String, String> hashMap) {
    NetworkHandler netwrkHandler = new NetworkHandler(
        (response) => {_chsOneLogindModelResponse.onSuccess(response)},
        (response) => {_chsOneLogindModelResponse.onFailure(response)},
        (response) => {_chsOneLogindModelResponse.onError(response)});

    Network networkt = CHSONEAPIHandler.loginChsOne(hashMap, netwrkHandler);
    networkt.excute();
  }
}

abstract class RequestChsOneLogindModelResponse {
  void onSuccess(String response);

  void onError(String error);

  void onFailure(String error);
}
