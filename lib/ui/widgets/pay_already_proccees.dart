import 'dart:collection';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/pay_already_stepper_model.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/payment_failed.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/payment_success.dart';

class PayAlreadyProccees extends StatefulWidget {
  HashMap<String, String> hashMap;

  PayAlreadyProccees(this.hashMap);

  @override
  State<StatefulWidget> createState() {
    return PayAlreadyProcceesState(hashMap);
  }
}

class PayAlreadyProcceesState extends State<PayAlreadyProccees>
    implements PayAlreadyStapperView {
  HashMap<String, String> hashMap;
  PayAlreadyStapperPresentor paymentPresentor;

  PayAlreadyProcceesState(this.hashMap);

  @override
  void initState() {
    super.initState();
    paymentPresentor = PayAlreadyStapperPresentor(this);
    paymentPresentor.pay(hashMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(FsColor.darkgrey),
                strokeWidth: 3.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Payment is processing...",
                style: TextStyle(
                  fontSize: FSTextStyle.h5size,
                  fontFamily: 'Gilroy-SemiBold',
                  color: FsColor.darkgrey,
                )),
          ],
        ),
      ),
    );
  }

  @override
  void onPaymentError(String s) {
    Toasly.error(context, s);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentFailedPage()),
    );
  }

  @override
  void onPaymentFailed(int statusCode, String s) {
    print(statusCode);
    if (statusCode == 422) {
      Toasly.error(context, s);
      Navigator.pop(context);
    } else {
      Toasly.error(context, s);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentFailedPage()),
      );
    }
  }

  @override
  void onPaymentSuccessFull(data) {
    Toasly.success(context, data["message"]);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
    );
  }
}
