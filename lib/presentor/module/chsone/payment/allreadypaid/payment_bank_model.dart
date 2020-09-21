import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

/*this.
onNext = onNext;}

@override
PayAlreadyChequePageState createState() =>
    new PayAlreadyChequePageState(onNext);}*/

class PayAlreadyChequePagePresentor {
  PayAlreadyChequePageView payAlreadyChequePageView;

  PayAlreadyChequePagePresentor(
      PayAlreadyChequePageView payAlreadyChequePageView) {
    this.payAlreadyChequePageView = payAlreadyChequePageView;
  }

  void getBankAccounts() {
    PaymentBankModel payment = PaymentBankModel();
    payment.getBankAccounts(payAlreadyChequePageView);
  }
}

class PaymentBankModel {
  void getBankAccounts(IPaymentBankModel bankModel) {
    ChsoneStorage.getAccessToken().then((token) {
      NetworkHandler netWorkHandler = new NetworkHandler((success) {
        List banks = [];
        List data = jsonDecode(success)["data"];
        for (var a in data) {
          print(a);
          banks.add(a);
        }
        print(banks);
        bankModel.onBanksDetails(banks);
      }, (failure) {
        bankModel.onBanksDetailsFailed();
      }, (error) {
        bankModel.onBanksDetailsError();
      });
      CHSONEAPIHandler.getBankAccounts(token, netWorkHandler).excute();
    });
  }
}

abstract class IPaymentBankModel {
  void onBanksDetails(List banks);

  void onBanksDetailsFailed();

  void onBanksDetailsError();
}

abstract class PayAlreadyChequePageView implements IPaymentBankModel {}
/*{"payment_mode":"cheque",
"received_from":"Rahul G",
"payment_instrument":"Cncncnnc",
"payment_amount":"6.0",
"bill_type":"maintenance_quickpay",
"transaction_reference":"899898",
"cheque_date":"17/12/2019","unit_id":"163",
"payment_date":"17/12/2019",
"bank_account":"213",
"token":"U2pdVWvQPRAYgeU6yPC38bbjaV8kW4SBAejol6um"}*/
//https://api.chsone.in/residentapi/v2/banks/accounts?token=U2pdVWvQPRAYgeU6yPC38bbjaV8kW4SBAejol6um
