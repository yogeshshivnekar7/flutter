import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

class CancelOrder extends StatefulWidget {
  var orderData;

  var businessAppMode;

  CancelOrder(this.orderData, this.businessAppMode);

  @override
  _CancelOrderState createState() =>
      new _CancelOrderState(orderData, this.businessAppMode);
}

class _CancelOrderState extends State<CancelOrder> implements OnlineOrderView {


  var orderData;

  OnlineOrderPresenter onlineOrderPresenter;

  bool cancelledByConsumer = false;

  BusinessAppMode businessAppMode;

  _CancelOrderState(this.orderData, this.businessAppMode);

  get COMPANY_API => "company_api";

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
    onlineOrderPresenter.getCompanyApi(orderData["company_id"].toString(),
        callingType: COMPANY_API);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor:
              OnlineOrderWebViewState.backgroundColor(businessAppMode),
          elevation: 0.0,
          title: new Text(
            'Cancel Order',
            style: FSTextStyle.appbartextlight,
          ),
          leading: FsBackButtonlight(),
        ),
        body: Container());
  }

  @override
  success(success, {callingType}) {
    print("success -- $callingType ---- $success");
    if (callingType == COMPANY_API) {}
  }

  @override
  error(error, {callingType}) {
    // TODO: implement error
    return null;
  }

  @override
  failure(failed, {callingType}) {
    // TODO: implement failure
    return null;
  }
}
