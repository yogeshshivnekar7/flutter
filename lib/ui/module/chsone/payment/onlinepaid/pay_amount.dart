import 'package:common_config/utils/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/widgets/InputDone.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class PayAmountPage extends StatefulWidget {
  var onNext;

  var dueAmount;

  PayAmountPage({this.dueAmount, var onNext}) {
    this.onNext = onNext;
  }

  @override
  PayAmountPageState createState() => new PayAmountPageState(onNext, dueAmount);
}

class PayAmountPageState extends State<PayAmountPage> {
  FocusNodeDone amountFocus = new FocusNodeDone();
  var onNext;
  TextEditingController paymentAmountControllar = new TextEditingController();
  TextEditingController paidByNameControllar = new TextEditingController();

  String paymentAmountError;
  String paidByNameError;
  var dueAmount;

  /*PayAmountPageState(onNext);*/

  PayAmountPageState(var onNext, this.dueAmount) {
    this.onNext = onNext;
  }

  @override
  void initState() {
    amountFocus.initFocus();

    if (dueAmount == null) {
      dueAmount = {};
    }
    super.initState();
    SsoStorage.getUserProfile().then((profile) {
      setState(() {
        var fname = profile["first_name"].toString();
        var lName = profile["last_name"];
        var fullName = fname + " " + (lName == null ? "" : lName.toString());
        paidByNameControllar.text = fullName;
        print(fname + lName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: new Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              alignment: Alignment.center,
              child: Text(
                'Maintenance Due'.toLowerCase(),
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
                bottom: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('total due amount : ',
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.darkgrey,
                      )),
                  Row(
                    children: <Widget>[
                      Icon(
                        FlutterIcon.rupee,
                        size: FSTextStyle.h2size,
                        color: FsColor.darkgrey,
                      ),
                      Text(
                          dueAmount["total_due_amount"] == null
                              ? "0"
                              : dueAmount["total_due_amount"].toString(),
                          style: TextStyle(
                            fontFamily: 'Gilroy-Bold',
                            fontSize: FSTextStyle.h1size,
                            color: FsColor.darkgrey,
                          )),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('other due amount : ',
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.darkgrey,
                      )),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
              child: TextField(
                focusNode: amountFocus,
                controller: paymentAmountControllar,
                keyboardType: TextInputType.number,
                inputFormatters: [AppUtils.getAmountFormatter()],
                decoration: InputDecoration(
                    errorText: paymentAmountError,
                    labelText: "Enter Amount",
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.basicprimary))),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
              child: TextField(
                controller: paidByNameControllar,
                decoration: InputDecoration(
                    errorText: paidByNameError,
                    labelText: "Paid by",
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.basicprimary))),
              ),
            ),

            // Divider(thickness: 0.5, color: FsColor.basicprimary,)

            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Text('Next',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        onPressed: () {
                          setState(() {
                            paymentAmountError = null;
                            paidByNameError = null;
                          });

                          bool isValid = true;
                          if (paymentAmountControllar.text.trim() == "") {
                            setState(() {
                              paymentAmountError = "Please enter amount";
                            });
                            isValid = false;
                          }
                          var amount = double.tryParse(
                              paymentAmountControllar.text.trim());
                          if (amount == null) {
                            setState(() {
                              paymentAmountError = "Please enter valid amount";
                            });
                            isValid = false;
                          } else if (!(amount > 0 && amount <= 10000000)) {
                            setState(() {
                              paymentAmountError =
                              "Amount should be between 1 to 10000000";
                            });
                            isValid = false;
                          }
                          if (paidByNameControllar.text.trim() == "") {
                            setState(() {
                              paidByNameError = "Please payer name";
                            });
                            isValid = false;
                          }

                          if (isValid) {
                            onNext({
                              "payment_amount": paymentAmountControllar.text,
                              "received_from": paidByNameControllar.text,
                            });
                          }
                        },
                        color: FsColor.primaryflat,
                        textColor: FsColor.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),);
  }

}

class FocusNodeDone extends FocusNode {
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }

  var overlayEntry;

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  void initFocus() {
    if (Environment().getCurrentConfig().geCurrentPlatForm() ==
        FsPlatforms.IOS) {
      addListener(() {
        if (hasFocus)
          showOverlay(context);
        else
          removeOverlay();
      });
    }
  }


}
