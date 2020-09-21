import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/main.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/online_payment_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/payment_handler.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/allreadypaid/pay_already_method_all_page.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/allreadypaid/payalready_amount.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/allreadypaid/payalready_method.dart';
import 'package:sso_futurescape/ui/widgets/pay_already_proccees.dart';
import 'package:sso_futurescape/ui/widgets/stapper_widget/stapper_body.dart';
import 'package:sso_futurescape/ui/widgets/stapper_widget/stapper_main.dart';

class PayAlreadyStapper extends StatefulWidget {
  var currentUnit;

  var flatsMaintenance;

  PayAlreadyStapper(this.currentUnit, this.flatsMaintenance);

  @override
  State<StatefulWidget> createState() {
    return PayAlreadyStapperState(currentUnit, flatsMaintenance);
  }
}

class PayAlreadyStapperState extends State<PayAlreadyStapper> {
//

  SFunction changes;
  var optionSelection = {};
  HashMap<String, String> hashMap = new HashMap<String, String>();


  var currentUnit;

  var flatsMaintenance;

  PayAlreadyStapperState(this.currentUnit, this.flatsMaintenance);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(currentUnit);

    hashMap["bill_type"] = "maintenance_quickpay";
    hashMap["unit_id"] = currentUnit["unit_id"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return StepperMainWidget(
      enableStepClick: false,
      heading: false,
      onPageChange: (previous, current) {
        print(previous);
        print(current);
      },
      afterInit: (SFunction change) {
        changes = change;
      },
      title: "payment",
      pages: [
        new StapperBody(
            title: "Already Paid".toLowerCase(),
            description:
            'Notify Complex Office about your Payment'.toLowerCase(),
            child: Container(
                child: PayAlreadyAmountPage(
                    dueAmount: flatsMaintenance,
                    onNext: (s) {
                      hashMap["payment_amount"] = s["payment_amount"];
                      hashMap["received_from"] = s["received_from"];

                      changes.next();
                    }))),
        new StapperBody(
            title: "1",
            description: "select your payment method",
            child: Container(
              child: PayAlreadyMethodPage(
                  onNext: (s) {
                    print(s);
                    var payalreadymethod = s["data"];
                    for (var payi in payalreadymethod) {
                      //print(payi);
                      if (payi["selected"] == true) {
                        if ("Cheque" == payi["name"]) {
                          setState(() {
                            optionSelection["payment_mode"] = "cheque";
                          });
                          changes.next();
                        } else {
                          setState(() {
                            optionSelection["payment_mode"] = "cashtransfer";
                          });
                          changes.next();
                        }
                        hashMap["payment_mode"] =
                        optionSelection["payment_mode"];
                        break;
                      }
                    }
                  },
                  onPrevious: demo),
            )),
        new StapperBody(
            title: 'add EFT details'.toLowerCase(),
            description: "Enter Transaction Number".toLowerCase(),
            child: Container(
                child: PayAlreadyMethodAllPage(optionSelection, onNext: (s) {
                  hashMap["payment_date"] = s["payment_date"];
                  if (s["cheque_date"] != null) {
                    hashMap["cheque_date"] = s["cheque_date"];
                  }
                  if (s["payment_instrument"] != null) {
                    hashMap["payment_instrument"] = s["payment_instrument"];
                  }
                  hashMap["bank_account"] = s["bank_account"];
                  hashMap["transaction_reference"] = s["transaction_reference"];
                  hashMap["file"] = s["file"];
                  //print(hashMap);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PayAlreadyProccees(hashMap)),
                  );
                })))
      ],
    );
  }


}



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
