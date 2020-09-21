import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/pay_method_presentor.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';

class PayMethodPage extends StatefulWidget {
  var onNext;

  var currentUnit;

  var gateWays;

  PayMethodPage(this.currentUnit, {this.onNext, this.gateWays}) {
    print(currentUnit);
    print(gateWays);
  }

  @override
  PayMethodPageState createState() =>
      new PayMethodPageState(currentUnit, gateWays, onNext);
}

class PayMethodPageState extends State<PayMethodPage>
    implements PayMethodPageView {
  PayMethodPagePresentor payMethodPageState;
  var onNext;

  var currentUnit;
  List paymethod = [];

  var gateWays;

  PayMethodPageState(this.currentUnit, this.gateWays, this.onNext);

  @override
  void initState() {
    super.initState();
    print("dddddddddddddddd");
    print(gateWays);
    /* if (gateWays["gateway"]["gateway"] == "yesbank") {*/
    payMethodPageState = new PayMethodPagePresentor(this);
    payMethodPageState.getOnlinePaymentModes(
        currentUnit["soc_id"].toString(), currentUnit["unit_id"].toString());
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              alignment: Alignment.center,
              child: Text(
                'select your payment method',
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h5size,
                  color: FsColor.darkgrey,
                ),
              ),
            ),
            isLoading
                ? PageLoader()
                : paymethod.length != 0
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0),
                  child: ListView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    paymethod == null ? 0 : paymethod.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map payment = paymethod[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                            side: BorderSide(
                                color: FsColor.lightgrey, width: 1.0),
                          ),
                          elevation: 0.0,
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(
                                bottom: 15.0,
                                top: 15.0,
                              ),
                              // height: 85,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    child: Image.asset(
                                      getImage(payment),
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: ListView(
                                      primary: false,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Container(
                                          alignment:
                                          Alignment.centerLeft,
                                          child: RichText(
                                              text: TextSpan(
                                                  style: Theme
                                                      .of(
                                                      context)
                                                      .textTheme
                                                      .body1,
                                                  children: [
                                                    TextSpan(
                                                      text: '${payment["name"]}'
                                                                .toLowerCase(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Gilroy-SemiBold',
                                                        fontSize:
                                                        FSTextStyle
                                                            .h6size,
                                                        color: FsColor
                                                            .basicprimary,
                                                      ),
                                                    ),
                                                  ])),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  payment["selected"]
                                      ? Container(
                                      height: 48.0,
                                      width: 50.0,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceAround,
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Icon(
                                            FlutterIcon
                                                .ok_circled,
                                            color: FsColor
                                                .primaryflat,
                                            size: 24.0,
                                          ),
                                        ],
                                      ))
                                      : Container(
                                      height: 48.0,
                                      width: 50.0,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceAround,
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        children: <Widget>[],
                                      )),
                                ],
                              ),
                            ),
                            onTap: () {
                              _paymentClicked(payment);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
                : Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                child: Text(
                  "Presently your complex has no online payment option available. Kindly get in touch with your complex office to make your payment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: FsColor.darkgrey,
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h6size),
                ),
              ),
            ),
          ],
        ),
      ),

      /*  ),*/
    );
  }

  String getImage(Map payment) {
    try {
      return "${payment["img"]}";
    } catch (e) {
      print(e);
      return null;
    }
  }

  _paymentClicked(payment) {
    setState(() {
      for (var pay in paymethod) {
        pay["selected"] = false;
      }
      payment["selected"] = true;
    });
    {
      // print(payment);
      // print(gateWays);
      print(gateWays["gateway"]["gateway"]);
      onNext({
        "mode": payment["chsone_key"],
        "pay_option": payment["key"],
        "vpa": payment["vpa"],
        "value": payment["value"],
        "payment_mode": gateWays["gateway"]["gateway"],// "yesbankpg"
            "extra_data": payment["extra_data"],
        // "selectedGateway": gateWays["gateway"]["gateway"],
      });
    }
  }

  @override
  void onErrorPaymentMode(String failed) {
    print("onErrorPaymentMode");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onFailedPaymentMode(String failed) {
    print("onFailedPaymentMode");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSuccessPaymentMode(List paymentGateWays, List modes) {
    print("onSuccessPaymentMode");
    print(paymentGateWays);
    for (var a in paymentGateWays) {
      if (a["gateway"] == gateWays["gateway"]["gateway"]) {
        paymethod = a["all_"];
        break;
      } else if (a["gateway"] == gateWays["gateway"]["gateway"]) {
        paymethod = a["all_"];
        break;
      }
    }
    print("onSuccessPaymentMode");
    print(modes);
    isLoading = false;
    /*paymethod = modes;*/
    paymethod.removeWhere((a) {
      return a == null;
    });
    print(paymethod);
    setState(() {});
  }
}
