import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

class GroceryOrderFailed extends StatefulWidget {
  var orderDetails;

  GroceryOrderFailed(this.orderDetails);

  @override
  _GroceryOrderFailedState createState() =>
      new _GroceryOrderFailedState(orderDetails);
}

class _GroceryOrderFailedState extends State<GroceryOrderFailed> {
  TextEditingController userNameController = new TextEditingController();

  var orderDetails;

  _GroceryOrderFailedState(this.orderDetails);

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
          'Order Failed'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(
          backEvent: (context) {
            openListing(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/order_failed.png',
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  'Order Failed'.toLowerCase(),
                  style: TextStyle(
                      fontSize: FSTextStyle.h3size,
                      color: FsColor.red,
                      fontFamily: 'Gilroy-SemiBold'),
                )),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Text(
                  "Sorry!  your order transaction couldn't be made \n  please retry to order"
                      .toLowerCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.darkgrey,
                      fontFamily: 'Gilroy-SemiBold'),
                )),
            Container(
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                ),
                child: Text('Retry',
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        fontFamily: 'Gilroy-SemiBold')),
                onPressed: () {
                  openListing(context);
                },
                color: FsColor.red,
                textColor: FsColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openListing(BuildContext context) {
    Navigator.pop(context, {});
//    Navigator.push(context,MaterialPageRoute(
//      builder: (context) => GroceryList(businessAppMode: BusinessAppMode.GROCERY,),
//    ),
//    );
  }
}
