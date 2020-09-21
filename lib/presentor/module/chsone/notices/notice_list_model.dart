import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class ListNoticeModel {
  ListNoticeModel();

  void listNotice(currentUnit, ListNoticeModelResponse noticeListView,
      {noticeType, page}) {
    ChsoneStorage.getChsoneAccessInfo().then((access_info) {
      if (access_info != null) {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["token"] = access_info["access_token"];
        if (noticeType == null) {
          hashMap["type"] = noticeType;
        }
        if (page != null) {
          hashMap["page"] = page;
        }
        hashMap["unit_id"] = currentUnit['unit_id'].toString();

        print(hashMap);
        NetworkHandler handler = new NetworkHandler((a) {
          print(a);
          var resPonse = jsonDecode(a)["data"];
          var matedata = resPonse["metadata"];
          var listResult = resPonse["results"];

          noticeListView.onSuccessListNotice(matedata, listResult);
        }, (s) {
          noticeListView.onFailureListNotice(s);
        }, (s) {
          noticeListView.onErrorListNotice(s);
        });

        CHSONEAPIHandler.getNoticeList(handler, hashMap).excute();
      }
    });
  }
}

abstract class ListNoticeModelResponse {
  void onSuccessListNotice(matedata, List allNoticeList);

  void onErrorListNotice(String response);

  void onFailureListNotice(String response);
}
