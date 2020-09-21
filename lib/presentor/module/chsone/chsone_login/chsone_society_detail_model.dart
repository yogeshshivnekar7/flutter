import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class SocietyDetailModel {
  RequestChsOneSocietyDetailModelResponse _chsOneSocietyDetailModelResponse;

  void getDetails(String accessToken) {
    NetworkHandler netwrkHandler = new NetworkHandler(
        (response) => {
          //_chsOneSocietyDetailModelResponse.onSuccess(response)
          ChsoneStorage.saveSocietyDetails(jsonDecode(response)["data"])
        },
        (response) => {
          // _chsOneSocietyDetailModelResponse.onFailure(response)
        },
        (response) => {
          //_chsOneSocietyDetailModelResponse.onError(response)
        });

    Network networkt =
    CHSONEAPIHandler.getSocietyDetails(netwrkHandler, accessToken);
    networkt.excute();
  }
}

abstract class RequestChsOneSocietyDetailModelResponse {
  void onSuccess(String response);

  void onError(String error);

  void onFailure(String error);
}
