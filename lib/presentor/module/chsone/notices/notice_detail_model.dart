import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class NoticeDetailModel {
  // NoticeDetailModel();
  void noticeDetails(noticeId, NoticeDetailModelResponse noticeDetailView) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["token"] = access_info["access_token"];
        hashMap["id"] = noticeId.toString();

        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          // print(a);
          print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
          print(jsonDecode(a)['status_code']);
          var resPonse = jsonDecode(a)["data"];
          // var matedata = resPonse["metadata"];
          // var listResult = resPonse["data"];
          // print(resPonse);

          noticeDetailView.onSuccessDetailNotice(resPonse);
        }, (s) {
          noticeDetailView.onFailureDetailNotice(s);
        }, (s) {
          noticeDetailView.onErrorDetailNotice(s);
        });

        CHSONEAPIHandler.getNoticeDetails(handler, hashMap).excute();
      }
    });
  }
}

abstract class NoticeDetailModelResponse {
  void onSuccessDetailNotice(response);

  void onErrorDetailNotice(String response);

  void onFailureDetailNotice(String response);
}
