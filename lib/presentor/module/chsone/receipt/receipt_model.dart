import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class ReceiptModel {
  Future<void> getReceiptList(
      onReceiptFound, onError, onFailure, String unit_id,
      {String search,
      String per_page,
      String page,
      String search_by,
      String search_value,
      String filter_status,
      String filter_payment_mode,
      String is_pagination}) async {
    NetworkHandler a = new NetworkHandler((s) {
      onReceiptFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    var token = await ChsoneStorage.getAccessToken();
    Network network = SSOAPIHandler.getReceipts(a, unit_id, token,
        per_page: per_page, is_pagination: is_pagination, page: page);
    network.excute();
  }
}

abstract class ReceiptModelResponse {
  void onSuccess(String success);

  void onLoadingStart();

  void onFailure(String failure);

  void onError(String error);
}
