import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/presentor/module/chsone/payment/payment_handler.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class OnlinePaymentModel extends APaymentModel {
/*  String token;*/

  @override
  void initParam(HashMap<String, String> hashMap) {}

  void initPayment(HashMap<String, String> hashMap) {
    var handler = new NetworkHandler((s) {
      print("ssssssssssssssssssss");
      String data = jsonDecode(s)["data"]["payment_token"].toString();
      conformPayment(data);
    }, (f) {
      var data = jsonDecode(f);
      iPaymentHandler.onPaymentFailed(
          data["status_code"], AppUtils.errorDecoder(data));
    }, (e) {
      iPaymentHandler.onPaymentFailed(500, "Server not reachable");
    });

    SsoStorage.getUserProfile().then((profile) {
      hashMap["session_token"] = profile["session_token"];
      hashMap["username"] = profile["username"];
      /*hashMap["token"] = token;*/
      /*  this.token = hashMap["token"];
      print(token);*/
      CHSONEAPIHandler.initiateOnlinePayment(handler, hashMap).excute();
    });

    /*ChsoneStorage.getAccessToken().then((token) {
      hashMap["token"] = token;
      this.token = hashMap["token"];
      print(token);

    });*/
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
    /*hashMap["token"] = token;*/
    hashMap["payment_token"] = payementToken;
    SsoStorage.getUserProfile().then((profile) {
      hashMap["session_token"] = profile["session_token"];
      hashMap["username"] = profile["username"];
      CHSONEAPIHandler.conformedOnlinePayment(handler, hashMap).excute();
    });
  }
}

abstract class APaymentModel {
  IPaymentHandler iPaymentHandler;

  void initParam(HashMap<String, String> hashMap);

  void addListners(
    IPaymentHandler iPaymentHandler,
  ) {
    this.iPaymentHandler = iPaymentHandler;
  }
}

enum PAYMENTTYPE { ONLINE, OFF_LINE }
