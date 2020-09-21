import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/online_payment_model.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class OfflinePaymentModel extends APaymentModel {
  String token;

  void initParam(HashMap<String, String> hashMap) {}

  void initPayment(HashMap<String, String> hashMap) {
    var handler = new NetworkHandler((s) {
      print("ssssssssssssssssssss");
      var data = jsonDecode(s)["data"]["payment_token"].toString();
      conformPayment(data);
    }, (f) {
      var data = jsonDecode(f);
      iPaymentHandler.onPaymentFailed(
          data["status_code"], AppUtils.errorDecoder(data));
    }, (e) {
      iPaymentHandler.onPaymentFailed(500, "Server not reachable");
    });

    ChsoneStorage.getAccessToken().then((token) {
      hashMap["token"] = token;
      this.token = hashMap["token"];
      print(token);
      CHSONEAPIHandler.getPaymentInit(handler, hashMap).excute();
    });
  }

  void conformPayment(String payementToken) {
    HashMap hashMap = new HashMap<String, String>();
    var handler = new NetworkHandler((s) {
      var data = jsonDecode(s);
      iPaymentHandler.onPaymentSuccessFull(data);
      print(s);
    }, (f) {
      var data = jsonDecode(f);

      iPaymentHandler.onPaymentFailed(
          data["status_code"], AppUtils.errorDecoder(data));
    }, (e) {
      iPaymentHandler.onPaymentFailed(500, "Server not reachable");
    });
    hashMap["token"] = token;
    hashMap["payment_token"] = payementToken;
    SsoStorage.getUserProfile().then((profile) {
      hashMap["session_token"] = profile["session_token"];
      hashMap["username"] = profile["username"];
      CHSONEAPIHandler.conformedPayment(handler, hashMap).excute();
    });
  }
}
