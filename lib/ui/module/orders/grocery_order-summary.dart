import 'dart:async';

import 'package:common_config/utils/fs_navigator.dart';

import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_order-review.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_orderfailed.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_ordersuccess.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/fs_stepper.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/style_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:flutter/material.dart';
class GroceryOrderSummary extends StatefulWidget {
  var orderData;
  var userProfile;

  var businessAppMode;

  GroceryOrderSummary(this.userProfile, this.orderData, this.businessAppMode);

  @override
  _GroceryOrderSummaryState createState() =>
      new _GroceryOrderSummaryState(userProfile, orderData, businessAppMode);
}

class _GroceryOrderSummaryState extends State<GroceryOrderSummary>
    implements OnlineOrderView {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  var orderData;

  var userProfile;

  OnlineOrderPresenter onlineOrderPresenter;

  bool compleStep = false;

//  var orderDetails;

  String estimateTotal = "0";

  List itemDetails;

  bool isRejected = false;

  var orderDetails;

  bool cancelledByConsumer = false;

  static final String CANCELLED_ORDER = "cancelled_order";

//  static final String PLACE_ORDER = "place_order";

  bool isOrderPlacing = false;

  int RESTART_TIMER = 30;

  var businessAppMode;

  _GroceryOrderSummaryState(this.userProfile, this.orderData,
      this.businessAppMode);

  get COMPANY_API => "company_api";

  switchStepType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("orderId --------- $orderData");
//    print("customerId--------- $userProfile");
    onlineOrderPresenter = new OnlineOrderPresenter(this);
    companyApiCall();
  }

  void companyApiCall() {
    onlineOrderPresenter.getCompanyApi(
        orderData["company_id"].toString(), callingType: COMPANY_API);
  }

  void getStatus() {
    getOrderStatus();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: OnlineOrderWebViewState.backgroundColor(
            businessAppMode),
        elevation: 0.0,
        title: new Text(
          'Order Summary'.toLowerCase(),
          style: FsAppBarStyle.getAppStyle(businessAppMode),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              getOrderStatus();
            },
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Icon(
              FlutterIcon.arrows_cw,
              color: FsAppBarStyle.iconColor(businessAppMode),
              size: FSTextStyle.h6size,
            ),
          ),
          SizedBox(width: 5),
        ],
        leading: FsAppBarStyle.getleading(businessAppMode),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Theme(
              data: ThemeData(primaryColor: FsColor.green),
              child: FsStepper(

                //physics: ClampingScrollPhysics(),
                steps: _stepper(),
                type: stepperType,
                currentStep: this._currentStep,
                // onStepTapped: (step) {
                //   setState(() {
                //     this._currentStep = step;
                //   });
                // },

                controlsBuilder: null
                ,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nextStep({String status}) {
    print('nextStepnextStepnextStep');
    setState(() {
//      if (this._currentStep < this._stepper().length - 1) {
//        this._currentStep = this._currentStep + 1;
//      } else {`
//        //Logic
//        print('complete');
//      }
      isRejected = false;
      if (status == FsString.REQUESTED) {
        this._currentStep = 0;
      }
      if (status == FsString.APPROVED) {
        this._currentStep = 2;
      }
      if (status == REVIEWED) {
        this._currentStep = 3;
      }
      if (status == ORDERED_PLACED) {
        this._currentStep = 3;
        this.compleStep = true;
      }

      print('nextStepnextStepnextStep $_currentStep');
    });
  }

  List<FsStep> _stepper() {
    List<FsStep> _steps = [
      FsStep(
          title: Text(
            'Order Sent for Confirmation'.toLowerCase(),
            style: TextStyle(
                color: FsColor.basicprimary, fontFamily: 'Gilroy-SemiBold'),
          ),
          subtitle: Container(
            constraints: new BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 84),
            child: Text(
              'Your order list has been sent to kirana store'.toLowerCase(),
              style: TextStyle(fontFamily: 'Gilroy-Regular'),
            ),
          ),
          content: null,
          isActive: _currentStep >= 0,
          state: StepState.disabled),
      FsStep(
        title: Container(
          constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 84),
          child: Text(
            'Store-Owner will confirm the availability'.toLowerCase(),
            style: TextStyle(
                color: FsColor.basicprimary, fontFamily: 'Gilroy-SemiBold'),
          ),
        ),
        subtitle: Container(
          constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 84),
          child: Text(
            'The Kirana store owner will update the prices and accept/reject the items based on the intentory.'
                .toLowerCase(),
            style: TextStyle(fontFamily: 'Gilroy-Regular'),
          ),
        ),
        content: Container(),
        isActive: _currentStep >= 1,
        state: !isRejected ? StepState.disabled : StepState.error,
      ),
      FsStep(
          title: Text(
            'Review your Order'.toLowerCase(),
            style: TextStyle(
                color: FsColor.basicprimary, fontFamily: 'Gilroy-SemiBold'),
          ),
          subtitle: Container(
            constraints: new BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 84),
            child: Text(
              'Review the item details and acknowledge the estimated bill of the order'
                  .toLowerCase(),
              style: TextStyle(fontFamily: 'Gilroy-Regular'),
            ),
          ),
          content: !cancelledByConsumer
              ? Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: FsColor.primarygrocery.withOpacity(0.1),
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
              border: Border.all(
                width: 1.0,
                color: FsColor.lightgrey,
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'estimated bill : '.toLowerCase(),
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey,
                          fontFamily: 'Gilroy-Regular'),
                    ),
                    Text(
                      hasOrderDetails()
                          ? '₹' + AppUtils.convertStringToDouble(
                          orderDetails["net_amount"])
                          : "₹0",
                      style: TextStyle(
                          fontSize: FSTextStyle.h5size,
                          color: FsColor.basicprimary,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: FsColor.green,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.white,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                    onPressed: () {
                      reviewOrder();
                    },
                  ),
                ),
              ],
            ),
          )
              : Container(),
          isActive: _currentStep >= 3,
          state: !isRejected && !cancelledByConsumer
              ? StepState.disabled
              : StepState.error),
      FsStep(
          title: Text(
            'Pay to Confirm'.toLowerCase(),
            style: TextStyle(
                color: FsColor.basicprimary, fontFamily: 'Gilroy-SemiBold'),
          ),
          subtitle: Container(
            constraints: new BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 84),
            child: Text(
              'Pay Online or opt to COD. The Store will deliver the order'
                  .toLowerCase(),
              style: TextStyle(fontFamily: 'Gilroy-Regular'),
            ),
          ),
          content: !compleStep
              ? Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Currently accepting cash on delivery only'
                        .toLowerCase(),
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.primary.withOpacity(0.8),
                        fontFamily: 'Gilroy-Regular'),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: FsColor.primarygrocery.withOpacity(0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: FsColor.lightgrey,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Item Total : '.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey,
                                fontFamily: 'Gilroy-Regular'),
                          ),
                          Text(
                            hasOrderDetails()
                                ? "₹" +
                                AppUtils.convertStringToDouble(
                                    orderDetails["subtotal"].toString())
                                : "₹0",
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Delivery Charges : (+) '.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey,
                                fontFamily: 'Gilroy-Regular'),
                          ),
                          Text(
                            hasOrderDetails()
                                ? "₹" +
                                AppUtils.convertStringToDouble(
                                    orderDetails["delivery_charges"]
                                        .toString())
                                : "₹0",
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Convenience/Service Charges : (+) '
                                .toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey,
                                fontFamily: 'Gilroy-Regular'),
                          ),
                          Text(
                            hasOrderDetails()
                                ? "₹" +
                                AppUtils.convertStringToDouble(
                                    orderDetails["service_charges"]
                                        .toString())
                                : "₹0",
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Grand Total : '.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey,
                                fontFamily: 'Gilroy-Regular'),
                          ),
                          Text(
                            hasOrderDetails()
                                ? "₹" +
                                AppUtils.convertStringToDouble(
                                    orderDetails["net_amount"].toString())
                                : "₹0",
                            style: TextStyle(
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.basicprimary,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: FsColor.green,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: isOrderPlacing ? SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  FsColor.white),
                              strokeWidth: 3.0,
                            ),
                          ) : Text(
                            'Pay to Confirm',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.white,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),
                          onPressed: () {
                            !isOrderPlacing ?
                            placeOrder() : null;
                          },
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          )
              : Container(),
          isActive: _currentStep >= 3 && compleStep,
          state: !isRejected && !cancelledByConsumer
              ? StepState.disabled
              : StepState.error),
    ];
    return _steps;
  }

  bool hasOrderDetails() => orderDetails != null && orderDetails.length > 0;

  Future reviewOrder() async {
    _timer.cancel();
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              GroceryOrderReview(userProfile, orderDetails, businessAppMode)),
    );
    if (result != null && result.containsKey('reviewed_order')) {
      nextStep(status: REVIEWED);
      orderDetails = result["reviewed_order"];
    } else if (result != null && result.containsKey('cancelled_order')) {
      cancelledByConsumer = true;
      cancelledOrder();
      setState(() {});
    } else if (result != null && result.containsKey('back_called')) {
      getOrderStatus();
    }
  }

  @override
  error(error, {callingType}) {
    print("error -- $callingType ---- $error");
  }

  @override
  failure(failed, {callingType}) {
    print("failed -- $callingType ---- $failed");
    if (callingType == ORDERED_PLACED) {
      failedPlaceOrder();
    }
  }

  @override
  success(success, {callingType}) {
    print("success -- $callingType ---- $success");
    if (callingType == COMPANY_API) {
//      List succes = success["data"];
      SsoStorage.setCompanyApi(success["data"]);
      getStatus();
    }
    if (callingType == SUMMARY_STATUS) {
      orderDetails = success["data"];
      String orderStatus = orderDetails["status"];
      print("orederstatus--------------- $orderStatus");
      if (orderStatus == FsString.REQUESTED) {

        nextStep(status: FsString.REQUESTED);

      } else if (orderStatus == FsString.REJECTED) {
        updateState();
      } else if (orderStatus == FsString.APPROVED) {
        cancelledByConsumer = false;
        nextStep(status: FsString.APPROVED);
      } else if (orderStatus == FsString.CANCELLED) {
        nextStep(status: FsString.APPROVED);
        updateState(cancelled: true);
      } else if (orderStatus == FsString.UNCONFIRMED) {
        nextStep(status: ORDERED_PLACED);
        succefullyPlacedOrder();
      }
    }
    if (callingType == ORDERED_PLACED) {
      nextStep(status: ORDERED_PLACED);
      succefullyPlacedOrder();
    }
  }

  static final String SUMMARY_STATUS = "summary_status";

  static final String REVIEWED = "reviewed";

  static final String ORDERED_PLACED = "order_placed";

  void getOrderStatus() {
    if (_currentStep != 3) {
      onlineOrderPresenter.getOrderSummary(
          userProfile, orderData["order_id"].toString(), SUMMARY_STATUS);
    }
  }

  void updateState({bool cancelled = false}) {
    if (cancelled) {
      cancelledByConsumer = true;
    } else {
      isRejected = true;
    }
    setState(() {});
  }

  void cancelledOrder() {
    onlineOrderPresenter.cancelledOrder(
        orderData["order_id"].toString(), userProfile, CANCELLED_ORDER);
  }

  void placeOrder() {
    isOrderPlacing = true;
    setState(() {});
    onlineOrderPresenter.placeOrder(
        userProfile, orderData["order_id"].toString(), orderDetails,
        ORDERED_PLACED);
  }

  void succefullyPlacedOrder() {
    Navigator.of(context).pop();
    FsNavigator.push(context, GroceryOrderSuccess(orderDetails));
  }

  void failedPlaceOrder() {
    Navigator.of(context).pop();
    FsNavigator.push(context, GroceryOrderFailed(orderDetails));
  }


  Timer _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_start >= RESTART_TIMER) {
//            timer.cancel();
                getOrderStatus();
                _start = 0;
              } else {
                _start = _start + 1;
              }
              print("timer--------------$_start");
            },
          ),
    );
  }

  @override
  void dispose() {
    print("dispose");
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

}
