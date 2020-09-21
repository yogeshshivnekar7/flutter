import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/pay_already_stepper_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/pay_online_staper_presentor.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';

class PayAlreadyMethodPage extends StatefulWidget {
  Function onNext;

  Function(int x1) _onPrevious;

  PayAlreadyMethodPage({
    Function onNext,
    Function(int x1) onPrevious,
  }) {
    this.onNext = onNext;
    this._onPrevious = onPrevious;
  }

  @override
  PayAlreadyMethodPageState createState() =>
      new PayAlreadyMethodPageState(onNext: onNext, onPrevious: _onPrevious);
}

class PayAlreadyMethodPageState extends State<PayAlreadyMethodPage>
    implements PayAlreadyMethodView {
  PayAlreadyMethodPresentor presentor;
  Function onNext;
  Function(int x1) onPrevious;
  bool isLooading = true;

  PayAlreadyMethodPageState({Function onNext, Function(int x1) onPrevious}) {
    this.onNext = onNext;
    this.onPrevious = onPrevious;
    isLooading = true;
    presentor = new PayAlreadyMethodPresentor(this);
    presentor.getPaymentMethodsForMember();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
              isLooading
                  ? PageLoader()
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: payalreadymethod == null
                          ? 0
                          : payalreadymethod.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map payment = payalreadymethod[index];
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
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
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
                                                          fontSize:
                                                          FSTextStyle
                                                              .h6size,
                                                          color:
                                                          FsColor.basicprimary,
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
              ),
            ],
          ),
        ),
      ],
      /*),*/
    );
  }

  _paymentClicked(payment) {
    setState(() {
      for (var pay in payalreadymethod) {
        pay["selected"] = false;
      }
      payment["selected"] = true;
    });

    onNext({"data": payalreadymethod});

    /*  var paycontroller = "Cheque";*/
  }

  @override
  void onErrorPaymentMode(String error) {
    isLooading = false;
    setState(() {

    });
  }

  @override
  void onFailedPaymentMode(String failed) {
    isLooading = false;
    setState(() {

    });
  }

  List payalreadymethod = [];

  bool hasCashTransfer = false;
  bool hasCHeque = false;

  @override
  void onSuccessPaymentMode(List paymentGateWays, List modes) {
    isLooading = false;
    payalreadymethod = [];
    if (modes.contains("cheque")) {
      hasCHeque = true;
      var cheque = {
        "img": "images/cheque.png",
        "name": "Cheque",
        "selected": false,
      };
      setState(() {
        payalreadymethod.add(cheque);
      });
    }
    if (modes.contains("cashtransfer")) {
      hasCashTransfer = true;
      var cashTransfer = {
        "img": "images/eft.png",
        "name": "Electronic Fund Transfer",
        "selected": false
      };
      setState(() {
        payalreadymethod.add(cashTransfer);
      });
    }
  }
}
