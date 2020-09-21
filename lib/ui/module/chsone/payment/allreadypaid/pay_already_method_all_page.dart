import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/allreadypaid/Payalready_eft.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/allreadypaid/payalready_cheque.dart';

class PayAlreadyMethodAllPage extends StatefulWidget {
  var optionSelection;
  var onNext;

  PayAlreadyMethodAllPage(var optionSelection, {Function onNext}) {
    this.optionSelection = optionSelection;
    this.onNext = onNext;
  }

  @override
  State<StatefulWidget> createState() {
    return PayAlreadyMethodAllPageState(this.optionSelection, onNext);
  }
}

class PayAlreadyMethodAllPageState extends State<PayAlreadyMethodAllPage> {
  var optionSelection;

  var onNext;

  PayAlreadyMethodAllPageState(optionSelection, onNext) {
    this.optionSelection = optionSelection;
    this.onNext = onNext;
  }

  @override
  Widget build(BuildContext context) {
    print(optionSelection);
    print("fffffffffffffffffffffffff");
    return optionSelection == null ||
        optionSelection["payment_mode"] == "cheque"
        ? PayAlreadyChequePage(onNext)
        : PayAlreadyEFTPage(
      onNext: onNext,
          );
  }
}
