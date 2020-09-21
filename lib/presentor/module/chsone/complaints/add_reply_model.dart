import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class AddReplyModel {
  void addReply(String memberId, String reply, complaintId, compalintStatus,
      RequestAddReplyModelResponse addReplyModelResponse) {
    ChsoneStorage.getChsoneAccessInfo().then((accessInfo) {
      if (accessInfo != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["issue_id"] = complaintId.toString();
        hashMap["member_id"] = memberId;
        hashMap["response_text"] = reply;
        hashMap["status"] = compalintStatus;
        hashMap["token"] = accessInfo["access_token"];
        NetworkHandler netwrkHandler = new NetworkHandler(
            (response) => {
                  addReplyModelResponse.onSuccessAddReplyComplaint(
                      jsonDecode(response.toString()))
                },
            (response) => {addReplyModelResponse.onFailure(response)},
            (response) => {addReplyModelResponse.onError(response)});

        Network networkt =
            CHSONEAPIHandler.addComplaintReply(hashMap, netwrkHandler);
        networkt.excute();
      }
    });
  }
}

abstract class RequestAddReplyModelResponse {
  void onSuccessAddReplyComplaint(response);

  void onError(String response);

  void onFailure(String response);
}
