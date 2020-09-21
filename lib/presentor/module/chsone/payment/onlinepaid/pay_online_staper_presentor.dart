import 'dart:collection';

import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/pay_already_stepper_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/online_payment_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/other/payment_mode_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/payment_handler.dart';

abstract class PayOnlineStaperView implements IPaymentHandlerOnline {}

abstract class IPaymentHandlerOnline implements IPaymentHandler {
  @override
  void onPaymentInitiatedSuccessFully(data);
}

class PayOnlineStaperPresentor {
  var payOnlineStaperView;

  PayOnlineStaperPresentor(this.payOnlineStaperView);

  void doOnlinePayment(HashMap<String, String> paymentPayLoad) {
    PaymentHandler handler =
        new PaymentHandler(PAYMENTTYPE.ONLINE, payOnlineStaperView);
    handler.doPayment(paymentPayLoad);
  }
}

class PayAlreadyMethodPresentor {
  PayAlreadyMethodView alreadyMethodView;

  PayAlreadyMethodPresentor(PayAlreadyMethodView alreadyMethodView) {
    this.alreadyMethodView = alreadyMethodView;
  }

  void getPaymentMethodsForMember() {
    PaymentModeModel model = new PaymentModeModel();
    model.getPaymentModeMember(
        alreadyMethodView.onSuccessPaymentMode,
        alreadyMethodView.onFailedPaymentMode,
        alreadyMethodView.onErrorPaymentMode);
  }
}
