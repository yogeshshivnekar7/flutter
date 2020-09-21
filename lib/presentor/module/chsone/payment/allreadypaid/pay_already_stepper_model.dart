import 'dart:collection';

import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/online_payment_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/other/payment_mode_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/payment_handler.dart';

abstract class PayAlreadyStapperView implements IPaymentHandler {}

class PayAlreadyStapperPresentor {
  PayAlreadyStapperView alreadyStapperView;

  PayAlreadyStapperPresentor(PayAlreadyStapperView alreadyStapperView) {
    this.alreadyStapperView = alreadyStapperView;
  }

  void pay(HashMap<String, String> hashMap) {
    PaymentHandler handler =
        new PaymentHandler(PAYMENTTYPE.OFF_LINE, alreadyStapperView);
    handler.doPayment(
      hashMap,
    );
  }
}

abstract class PayAlreadyMethodView extends IPaymentModeModel {}
