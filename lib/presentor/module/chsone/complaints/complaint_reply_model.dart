import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class ComplaintModel {
  void getComplaintRepy(
      complaintId, ComplaintReplyModelResponse complaintReplyView) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        // hashMap["issue_id"] = complaintId;
        hashMap["token"] = access_info["access_token"];
        NetworkHandler handler = new NetworkHandler((a) {
          var resPonse = jsonDecode(a)["data"];
          var listResult = resPonse["threads"];
          complaintReplyView.onSuccessReplyListTopics(resPonse, listResult);
        }, (s) {
          complaintReplyView.onReplyListFailure(s);
        }, (s) {
          complaintReplyView.onReplyListError(s);
        });
        CHSONEAPIHandler.getComplaintReplyList(handler, hashMap, complaintId)
            .excute();
      }
    });
  }
}

abstract class ComplaintReplyModelResponse {
  void onSuccessReplyListTopics(response, listResult);

  void onReplyListError(String response);

  void onReplyListFailure(String response);
}
