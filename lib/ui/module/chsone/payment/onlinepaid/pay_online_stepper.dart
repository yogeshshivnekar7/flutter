import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/main.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/pay_online_staper_presentor.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/onlinepaid/PayGatewayPage.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/onlinepaid/pay_amount.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/onlinepaid/pay_confirm.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/onlinepaid/pay_ecollect.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/onlinepaid/pay_method.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/stapper_widget/stapper_body.dart';
import 'package:sso_futurescape/ui/widgets/stapper_widget/stapper_main.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class PayOnlineStepper extends StatefulWidget {
  var currentUnit;

  var dueAmount;

  PayOnlineStepper(this.currentUnit, {this.dueAmount});

  @override
  State<StatefulWidget> createState() {
    return new PayOnlineStepperState(currentUnit, dueAmount: dueAmount);
  }
}

class PayOnlineStepperState
    extends State<PayOnlineStepper> /* implements PayOnlineStaperView*/ {
  SFunction changes;
  PayOnlineStaperPresentor payOnlineStaperPresentor;
  var currentUnit;
  HashMap<String, String> paymentPayLoad;

  var dueAmount;

  var _selectedGateWay = {};

  PayOnlineStepperState(this.currentUnit, {this.dueAmount});

  @override
  void initState() {
    super.initState();
    payOnlineStaperPresentor = new PayOnlineStaperPresentor(this);
    print(currentUnit);
    paymentPayLoad = new HashMap();
    paymentPayLoad["soc_id"] = currentUnit["soc_id"].toString();
    paymentPayLoad["unit_id"] = currentUnit["unit_id"].toString();
    paymentPayLoad["source"] = "APPANDROID";
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
      title: "payment",
      afterInit: (SFunction change) {
        changes = change;
      },
      pages: [
        new StapperBody(
            title: "Already Paid".toLowerCase(),
            description:
            'Notify Complex Office about your Payment'.toLowerCase(),
            child: Container(
                child: PayAmountPage(
                    dueAmount: dueAmount,
                    onNext: (s) {
                      paymentPayLoad["payment_amount"] = s["payment_amount"];
                      paymentPayLoad["paid_by"] = s["received_from"];
                      changes.next();
                    }))),

        new StapperBody(
            title: "Already Paid".toLowerCase(),
            description:
            'select your payment gateway'.toLowerCase(),
            child: Container(
                child: PayGatewayPage(currentUnit,
                    dueAmount: dueAmount,
                    onNext: (s) {
                      print("hhhhhhhhhhhhhhhhhhhhhhh");
                      print(s);
                      _selectedGateWay["gateway"] = s;
                      /* paymentPayLoad["payment_amount"] = s["payment_amount"];
                      paymentPayLoad["paid_by"] = s["received_from"];*/
                      changes.next();
                    }))),

        new StapperBody(
            title: "1",
            description: "select your payment method",
            child: Container(
              child: PayMethodPage(
                  currentUnit, gateWays: _selectedGateWay, onNext: (s) {

                paymentPayLoad["mode"] = s["mode"];
                paymentPayLoad["payment_mode"] = s["payment_mode"];
                paymentPayLoad["pay_option"] = s["pay_option"];
                paymentPayLoad["vpa"] = s["vpa"];
                if (s["pay_option"].toString() != "vpa") {
                  changes.next();
                } else {
                  print(paymentPayLoad);
                  print(s);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PayEcollectPage(s)),
                  );
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PayEcollectPage()),
                  );*/
                }
                print(s);
              }),
            )),
        new StapperBody(
            title: "1",
            description: "select your payment method",
            child: Container(
              child: PayConfirmPage(
                  paymentPayLoad, gateWays: _selectedGateWay, onNext: (s) {
                //payOnlineStaperPresentor.doOnlinePayment(paymentPayLoad);
                onPaymentInitiatedSuccessFully(paymentPayLoad);
              }),
            )),
      ],
    );
  }

/*  @override
  void onPaymentError(String s) {}

  @override
  void onPaymentFailed(String s) {}

  @override
  void onPaymentSuccessFull(data) {}*/

  @override
  void onPaymentInitiatedSuccessFully(data) {
/*
 String urls =
        "http://stg.chsone.in/payment/make-payment/gateway/1137/1?username=minuahir@gmail.com&session_token=JDJ5JDEwJFFNczVjc2czN2xLZmtRZUM3dTI3cnVUYUlBaXlzS1Uyb3FZdjV3aGZnei9qdEo4Y1VIM1l1&amount=1.00&mode=DB&gateway=yesbankpg&access_token=LjN58OAM4L7nIU3C6EVUTCZac8sPzOLk3bDQPd1I&refresh_token=ELtT9b6I7t5rDNkRLpGmkhzKlO01xqtOMufRfCvc";
*/

    SsoStorage.getUserProfile().then((profile) {
      var username = profile["username"].toString();
      var session_token = profile["session_token"].toString();
      var unitId = paymentPayLoad["unit_id"];
      var socId = paymentPayLoad["soc_id"];
      var amount = paymentPayLoad["payment_amount"];
      var gayWay = paymentPayLoad["payment_mode"];
      var chsonePaymentType = paymentPayLoad["mode"];
      SsoStorage.getToken().then((token) {
        var access = jsonDecode(token);
        String accessToken = access["access_token"];
        String refreshToken = access["refresh_token"];
        String paymentUrls = Environment()
            .getCurrentConfig()
            .chsoneWebUrl +
            "payment/make-payment/gateway/$socId/$unitId?username=$username&session_token=$session_token" +
            "&amount="
                "$amount&mode=$chsonePaymentType&gateway=$gayWay&access_token=$accessToken&refresh_token=$refreshToken";
        print(paymentUrls);
        /*html.window.open(paymentUrls, "payment");*/
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentWebView(paymentUrls)),
        );
      });
    });
  }
}

class PaymentWebView extends StatefulWidget {
  String paymentUrls;

  PaymentWebView(this.paymentUrls);

  @override
  State<StatefulWidget> createState() {
    return PaymentWebViewState(paymentUrls);
  }
}

class PaymentWebViewState extends State<PaymentWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  String paymentUrls;

  PaymentWebViewState(this.paymentUrls);

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
      if (url.contains("chsone.in/dashboard")) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MainDashboard()),
                (Route<dynamic> route) => false);
      }
      /*http://devwebsite.chsone.in/payment/success http://devwebsite.chsone.in/payment/failed*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: paymentUrls,
        withJavascript: true,
        withZoom: false,
        hidden: true,
        appCacheEnabled: true,
        appBar: AppBar(
          title: Text("payment"),
          centerTitle: false,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.white),
        ));
  }
}

/*
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
*/
