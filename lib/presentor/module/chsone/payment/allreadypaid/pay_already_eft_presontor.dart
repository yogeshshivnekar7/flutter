import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/payment_bank_model.dart';

class PayAlreadyEFTPageStatePresentor {
  var payAlreadyEFTPageState;

  PayAlreadyEFTPageStatePresentor(this.payAlreadyEFTPageState);

  void getBankAccounts() {
    PaymentBankModel payment = PaymentBankModel();
    payment.getBankAccounts(payAlreadyEFTPageState);
  }
}
