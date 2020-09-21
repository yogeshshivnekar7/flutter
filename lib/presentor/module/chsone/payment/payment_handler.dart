import 'dart:collection';

import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/offline_payment_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/online_payment_model.dart';

class PaymentHandler {
  IPaymentHandler iPaymentHandler;

  PAYMENTTYPE paymenttype;

  PaymentHandler(this.paymenttype, this.iPaymentHandler);

  void doPayment(HashMap<String, String> hashMap) {
    if (paymenttype == PAYMENTTYPE.ONLINE) {
      OnlinePaymentModel model = new OnlinePaymentModel();
      model.initParam(hashMap);
      model.addListners(iPaymentHandler);
      model.initPayment(hashMap);
    } else {
      OfflinePaymentModel model = new OfflinePaymentModel();
      model.initParam(hashMap);
      model.addListners(iPaymentHandler);
      model.initPayment(hashMap);
    }
  }
}

abstract class IPaymentHandler {
  void onPaymentSuccessFull(var data);

  void onPaymentFailed(int statusCode, String s);

  void onPaymentError(String s);
}
