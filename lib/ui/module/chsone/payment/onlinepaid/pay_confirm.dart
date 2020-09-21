import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/other/payment_mode_model.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';

class PayConfirmPage extends StatefulWidget {
  var onNext;

  var paymentPayLoad;

  var gateWays;

  PayConfirmPage(this.paymentPayLoad, {this.onNext, this.gateWays});

  @override
  State<StatefulWidget> createState() {
    return new PayConfirmPageState(paymentPayLoad, onNext, gateWays);
  }
}

class PayConfirmPageState extends State<PayConfirmPage>
    implements PayConfirmPageView {
  var onNext;
  bool isLoading = true;
  var paymentPayLoad;

  Map calculation;

  var gateWays;

  PayConfirmPageState(this.paymentPayLoad, this.onNext, this.gateWays);

  PayConfirmPagePresentor payConfirmPagePresentor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    payConfirmPagePresentor = PayConfirmPagePresentor(this);
    payConfirmPagePresentor.calculateAmount(
        paymentPayLoad["payment_amount"], paymentPayLoad["mode"],
        gateWays["gateway"]["gateway"]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: isLoading
          ? PageLoader()
          : Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    'confirm your payment details'.toLowerCase(),
                    style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.darkgrey,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 0.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text('Amount to be paid :'.toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  fontSize: FSTextStyle.h5size,
                                  color: FsColor.darkgrey,
                                )),
                            Row(
                              children: <Widget>[
                                Text(calculation["base_amount"].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: FSTextStyle.h5size,
                                      color: FsColor.darkgrey,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text('Convenience Charges + GST :'.toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  fontSize: FSTextStyle.h7size,
                                  color: FsColor.darkgrey,
                                )),
                            Row(
                              children: <Widget>[
                                Text(
                                    calculation["convenience_charge"]
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: FSTextStyle.h7size,
                                      color: FsColor.darkgrey,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text('Total Payable :'.toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  fontSize: FSTextStyle.h5size,
                                  color: FsColor.darkgrey,
                                )),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FlutterIcon.rupee,
                                  size: FSTextStyle.h2size,
                                  color: FsColor.primaryflat,
                                ),
                                Text(calculation["payable_amount"].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: FSTextStyle.h2size,
                                      color: FsColor.primaryflat,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: GestureDetector(
                          child: RaisedButton(
                            padding:
                                EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),
                            ),
                            child: Text('Pay',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold')),
                            onPressed: () {
                              onNext({});
                              /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentFailedPage()),
                        );*/
                            },
                            color: FsColor.primaryflat,
                            textColor: FsColor.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: 'Note : '.toLowerCase(),
                          style: TextStyle(
                            fontFamily: 'Gilroy-Bold',
                            fontSize: FSTextStyle.h7size,
                            color: FsColor.darkgrey,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    'You will be redirected to payment gateway'
                                        .toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  fontSize: FSTextStyle.h7size,
                                  color: FsColor.darkgrey,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
      /* ),*/
    );
  }

  @override
  void onErrorCalculation() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onFailedCalculation() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSuccessCalculation(calculation) {
    setState(() {
      isLoading = false;
      this.calculation = calculation;
    });

    /*"data":{"base_amount":466,
   "payable_amount":480.84,
   "convenience_charge":14.84,
   "gst":2.26,
   "payment_mode":"CC"}*/
  }
}

abstract class PayConfirmPageView implements IPaymentCalculation {}

class PayConfirmPagePresentor {
  PayConfirmPageView confirmPageView;

  PayConfirmPagePresentor(this.confirmPageView);

  void calculateAmount(String amount, String mode, gateWay) {
    PaymentModeModel model = PaymentModeModel();
    model.getPaymentCalculation(confirmPageView, amount, mode, gateWay);
  }
}
