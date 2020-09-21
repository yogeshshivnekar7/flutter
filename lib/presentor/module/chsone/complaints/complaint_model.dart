import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class ComplaintModel {
  ComplaintModel();

  void getHelpdeskTopic(
      String socId, RequestComplaintModelResponse complaintModelResponse) {
    //var currentConfig = Environment().getCurrentConfig();
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        var hashMap = new HashMap<String, String>();
        hashMap["token"] = access_info["access_token"];

        NetworkHandler netwrkHandler = new NetworkHandler(
            (response) => {
                  complaintModelResponse
                      .onSuccessHelpTopics(jsonDecode(response.toString()))
                },
            (response) =>
                {complaintModelResponse.onFailureHelpTopics(response)},
            (response) => {complaintModelResponse.onErrorHelpTopics(response)});

        Network networkt =
            CHSONEAPIHandler.getHelpTopic(hashMap, netwrkHandler);
        networkt.excute();
      }
      // print(access_info);
    });
  }
}

abstract class RequestComplaintModelResponse {
  void onSuccessHelpTopics(response);

  void onErrorHelpTopics(String response);

  void onFailureHelpTopics(String response);
}
