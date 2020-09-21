import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class GroceryOrderSuccess extends StatefulWidget {
  var orderDetails;

  GroceryOrderSuccess(this.orderDetails);

  @override
  _GroceryOrderSuccessState createState() =>
      new _GroceryOrderSuccessState(orderDetails);
}

class _GroceryOrderSuccessState extends State<GroceryOrderSuccess> {
  TextEditingController userNameController = new TextEditingController();

  var orderDetails;

  _GroceryOrderSuccessState(this.orderDetails);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: FsColor.primarygrocery,
        elevation: 0.0,
        title: new Text(
          'Order Success'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(
          backEvent: (context) {
            openListing();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/order_success.png',
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  'Thank you for Ordering'.toLowerCase(),
                  style: TextStyle(
                      fontSize: FSTextStyle.h3size,
                      color: FsColor.green,
                      fontFamily: 'Gilroy-SemiBold'),
                )),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Text(
                  'Congratulations! \nyou have successfully placed your order'
                      .toLowerCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.darkgrey,
                      fontFamily: 'Gilroy-SemiBold'),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Order Number'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.lightgrey,
                            fontFamily: 'Gilroy-SemiBold'),
                      ),
                      Text(
                        orderDetails["order_no"].toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey,
                            fontFamily: 'Gilroy-SemiBold'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Order Amount'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.lightgrey,
                            fontFamily: 'Gilroy-SemiBold'),
                      ),
                      Text(
                        "₹" + AppUtils.convertStringToDouble(
                            orderDetails["net_amount"].toLowerCase()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey,
                            fontFamily: 'Gilroy-SemiBold'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                ),
                child: Text('Order More',
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        fontFamily: 'Gilroy-SemiBold')),
                onPressed: () {
                  openListing();
//                        Navigator.pushAndRemoveUntil(
//                            context,
//                            MaterialPageRoute(builder: (context) => GroceryList(businessAppMode: BusinessAppMode
//                                .GROCERY,)),
//                                (Route<dynamic> route) => false);
                },
                color: FsColor.primarygrocery,
                textColor: FsColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openListing() {
/*

    FsNavigator.push(
        context,
        GroceryList(
          businessAppMode: BusinessAppMode.GROCERY,
        ));
*/
    Navigator.of(context).pop();
  }
}
