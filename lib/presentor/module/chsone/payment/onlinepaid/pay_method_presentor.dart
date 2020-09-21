import 'package:sso_futurescape/presentor/module/chsone/payment/other/payment_mode_model.dart';

class PayMethodPagePresentor {
  PayMethodPageView payMethodPageView;

  PayMethodPagePresentor(this.payMethodPageView);

  void getOnlinePaymentModes(socId, unitId) {
    PaymentModeModel model = new PaymentModeModel();
    model.getOnlinePaymentOption(socId, unitId, payMethodPageView);
  }
}

abstract class PayMethodPageView implements IPaymentModeModel {}
