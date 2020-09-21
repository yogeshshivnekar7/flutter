import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/pay_method_presentor.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';

class PayGatewayPage extends StatefulWidget {
  var onNext;

  var dueAmount;

  var currentUnit;

  PayGatewayPage(this.currentUnit, {this.onNext, this.dueAmount}) {}

  @override
  PayGatewayPageState createState() =>
      new PayGatewayPageState(currentUnit, this.onNext);
}

class PayGatewayPageState extends State<PayGatewayPage>
    implements PayMethodPageView {
  List paygateway = [];
  var onNext;
  PayMethodPagePresentor payMethodPageState;
  var currentUnit;

  PayGatewayPageState(this.currentUnit, this.onNext);

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    payMethodPageState = new PayMethodPagePresentor(this);
    payMethodPageState.getOnlinePaymentModes(
        currentUnit["soc_id"].toString(), currentUnit["unit_id"].toString());
    isLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? PageLoader()
        : hasItemInList()
        ? FsNoData(
      message:
      "payment method not configured. please contact with society office to active payment gateway.",
    )
        : Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          alignment: Alignment.center,
          child: Text(
            'select your payment gateway'.toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h5size,
              color: FsColor.darkgrey,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: paygateway == null ? 0 : paygateway.length,
                itemBuilder: (BuildContext context, int index) {
                  Map payment = paygateway[index];
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
                                  "${payment["img"]}",
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
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                          text: TextSpan(
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .body1,
                                              children: [
                                                TextSpan(
                                                  text:
                                                  '${payment["name"]}'
                                                      .toLowerCase(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'Gilroy-SemiBold',
                                                    fontSize: FSTextStyle
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
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        FlutterIcon.ok_circled,
                                        color:
                                        FsColor.primaryflat,
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
                                    CrossAxisAlignment.center,
                                    children: <Widget>[],
                                  )),
                            ],
                          ),
                        ),
                        onTap: () {
                          /* Navigator.push(context,MaterialPageRoute(
                                    builder: (context) => PayMethodPage("")
                                  ),
                                  );*/
                          print(payment);
                          onNext(payment);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool hasItemInList() => paygateway == null || paygateway.length == 0;

  @override
  void onErrorPaymentMode(String failed) {
    isLoading = false;
    setState(() {});
  }

  @override
  void onFailedPaymentMode(String failed) {
    isLoading = false;
    setState(() {});
  }

  @override
  void onSuccessPaymentMode(paymentGateWays, List modes) {
    print(modes);
    isLoading = false;
    paygateway = paymentGateWays;
    print(paymentGateWays);
    setState(() {});
  }
}
