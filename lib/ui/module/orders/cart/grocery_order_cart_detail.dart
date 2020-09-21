import 'dart:ui';

import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_order-summary.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/ui/widgets/style_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import '../store_detail_helper.dart';

class GroceryOrderCartDetail extends StatefulWidget {
  var userProfile;

  var orderData;

  var businessAppMode;
  var type;

  GroceryOrderCartDetail(this.userProfile, this.orderData, this.businessAppMode,
      {this.type});

  @override
  _GroceryOrderCartDetailState createState() =>
      new _GroceryOrderCartDetailState(
          this.userProfile, this.orderData, this.businessAppMode,
          type: this.type);
}

class _GroceryOrderCartDetailState extends State<GroceryOrderCartDetail>
    implements OnlineOrderView {
  List historyitems = [];
  var CT_ORDER_SUMARRY = "order_summary";
  var userProfile;

//  var orderId;

  OnlineOrderPresenter onlineOrderPresenter;

  var orderData;

  bool isLoading = false;

  BusinessAppMode businessAppMode;

  String companyName = "";

  String companyAddress = "";
  var type;

  _GroceryOrderCartDetailState(
      this.userProfile, this.orderData, this.businessAppMode,
      {this.type});

  @override
  void initState() {
    super.initState();
    onlineOrderPresenter = new OnlineOrderPresenter(this);
    isLoading = true;
    //onlineOrderPresenter.getorderData(orderData, CT_ORDER_SUMARRY);
    mapData();
  }

  void companyApiCall() {
    onlineOrderPresenter.getCompanyApi(orderData["company_id"].toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void mapData() {
    print('value');
    List items = orderData["value"];
    companyName = orderData['company_name'];
    /* orderData["subtotal"] =
        AppUtils.convertStringToDouble(orderData["subtotal"]);
    orderData["total_tax"] =
        AppUtils.convertStringToDouble(orderData["total_tax"]);
    orderData["delivery_charges"] =
        AppUtils.convertStringToDouble(orderData["delivery_charges"]);
    orderData["service_charges"] =
        AppUtils.convertStringToDouble(orderData["service_charges"]);
    orderData["net_amount"] =
        AppUtils.convertStringToDouble(orderData["net_amount"]);
    orderData["total_discount"] =
        AppUtils.convertStringToDouble(orderData["total_discount"]);
    orderData["promo_code"] = orderData["promo_code"] != null &&
            orderData["promo_code"].length > 0
        ? orderData["promo_code"]
        : "";
    orderData["payment_mode"] = orderData["payment_mode"] != null &&
            orderData["payment_mode"].length > 0
        ? orderData["payment_mode"]
        : "";
    orderData["order_date"] = orderData["order_date"] != null &&
            orderData["order_date"].length > 0
        ? AppUtils.getConvertDate(orderData["order_date"])
        : "";
    orderData["delivery_date"] = orderData["delivery_date"] != null &&
            orderData["delivery_date"].length > 0
        ? AppUtils.getConvertDate(orderData["delivery_date"])
        : "";
    orderData["pickup_date"] = orderData["pickup_date"] != null &&
            orderData["pickup_date"].length > 0
        ? AppUtils.getConvertDate(orderData["pickup_date"])
        : "";
    orderData["full_address"] = getFullAddress(orderData);
    orderData["phone_no"] = orderData["customer_contact_number"];
    orderData["order_status"] = getOrderStatus(orderData);
    orderData["delivery_status"] = getDeliveryStatus(orderData);
    orderData["pickup_slot"] = getPickupSlot(orderData);
    orderData["call_at"] =
        getPhoneNumber(orderData["mobiles"], callAt: true);*/
    historyitems.clear();
    print(items);
    for (int i = 0; items != null && i < items.length; i++) {
      var itemDetails = items[i];
      print("itemsdetails------------$itemDetails");
      double name = double.parse(itemDetails["price"]) * itemDetails['count'];
      print(name);
      var item = {
        "id": itemDetails["id"].toString(),
        "order_id": itemDetails["order_id"].toString(),
        "name": itemDetails["name"].toString(),
        "qty": AppUtils.convertStringToDouble(itemDetails["count"].toString()),
        "amount":
            AppUtils.convertStringToDouble(itemDetails["price"].toString()),
        "totalamount": AppUtils.convertStringToDouble((name).toString()),
        "isavailable": true,
        "cancelled": false,
      };
      historyitems.add(item);
    }
    isLoading = false;
    setState(() {});
    // companyApiCall();
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
          'Cart Details'.toLowerCase(),
          style: FsAppBarStyle.getAppStyle(businessAppMode),
        ),
        leading: FsAppBarStyle.getleading(businessAppMode),
      ),
      body: isLoading
          ? PageLoader()
          : orderData == null
              ? FsNoData(
                  title: false,
                  message: "Sorry, something went wrong",
                )
              : Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              border: Border.all(
                                width: 1.0,
                                color: FsColor.lightgrey.withOpacity(0.5),
                              )),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: orderData['company_code'] == null ||
                                        AppUtils.getCompanyImage(orderData) ==
                                            null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          AppUtils.getDefultImage(
                                              businessAppMode),
                                          height: 48,
                                          width: 48,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : FadeInImage(
                                        image: NetworkImage(
                                            AppUtils.getCompanyImage(
                                                orderData)),
                                        placeholder: AssetImage(
                                            AppUtils.getDefultImage(
                                                businessAppMode)),
                                        height: 48,
                                        width: 48,
                                        fit: BoxFit.cover),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Text(
                                            companyName,
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h5size,
                                                color: FsColor.basicprimary,
                                                fontFamily: 'Gilroy-SemiBold'),
                                          )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Your Order'.toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.basicprimary,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListView.builder(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: historyitems == null
                                    ? 0
                                    : historyitems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map place = historyitems[index];
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      width: 1.0,
                                      color: FsColor.lightgrey.withOpacity(0.2),
                                    ))),
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: ListView(
                                                primary: false,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      '${place["name"]}',
                                                      style: TextStyle(
                                                          fontSize: FSTextStyle
                                                              .h6size,
                                                          color:
                                                              FsColor.darkgrey,
                                                          fontFamily:
                                                              'Gilroy-SemiBold'),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                "${place["qty"]}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Regular',
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h6size,
                                                                  color: FsColor
                                                                      .darkgrey,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                "x",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Regular',
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h6size,
                                                                  color: FsColor
                                                                      .darkgrey,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                "₹" +
                                                                    "${place["amount"]}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy-Regular',
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h6size,
                                                                  color: FsColor
                                                                      .darkgrey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "₹" +
                                                                "${place["totalamount"]}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy-SemiBold',
                                                              fontSize:
                                                                  FSTextStyle
                                                                      .h6size,
                                                              color: FsColor
                                                                  .darkgrey,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FsColor.primarygrocery.withOpacity(0.05),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Sub Total'.toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h3size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                    Text(
                                      "₹" +
                                          AppUtils.convertStringToDouble(
                                                  orderData["sub_total"]
                                                      .toString())
                                              .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h3size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /*Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'promo code' +
                                          orderData["promo_code"]
                                              .toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                    Text(
                                      "(-) " +
                                          "₹" +
                                          orderData["total_discount"],
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Delivery Charges'.toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                    Text(
                                      "(+) " +
                                          "₹" +
                                          orderData["delivery_charges"]
                                              .toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Total tax'.toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                    Text(
                                      "(+) " +
                                          "₹" +
                                          orderData["total_tax"]
                                              .toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                decoration: BoxDecoration(
                                  color:
                                      FsColor.primarygrocery.withOpacity(0.1),
                                  border: Border(
                                    top: BorderSide(
                                      width: 1.0,
                                      color: FsColor.lightgrey.withOpacity(0.5),
                                    ),
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: FsColor.lightgrey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Total'.toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.basicprimary,
                                      ),
                                    ),
                                    Text(
                                      "₹" +
                                          orderData["net_amount"]
                                              .toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.basicprimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),*/
                            ],
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              padding:
                              EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              child: Text("Continue Shopping & Checkout",
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold')),
                              onPressed: () {
                                StoreDetailHelper(context).termsDialog(
                                    context,
                                    StoreDetailHelper
                                        .getAccordingToIndustryType(
                                        orderData['industry_type']),
                                    orderData,
                                    shoeBottom: false);
                                Navigator.pop(context);
                              },
                              color: FsColor.basicprimary,
                              textColor: FsColor.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }

  getColor(String status) {
    if (status == FsString.REJECTED) {
      return FsColor.rejected;
    } else if (status == FsString.CANCELLED) {
      return FsColor.cancelled;
    } else if (status == FsString.REQUESTED) {
      return FsColor.requested;
    } else if (status == FsString.UNCONFIRMED) {
      return FsColor.unconfirmed;
    } else if (status == FsString.APPROVED) {
      return FsColor.approved;
    } else if (status == FsString.INPROCESS) {
      return FsColor.inProcess;
    } else if (status == FsString.COMPLETED) {
      return FsColor.completed;
    }
    return FsColor.green;
  }

  Color getstatusColor() => isRequested()
      ? FsColor.yellow
      : isUnconfirmed()
          ? Colors.orange
          : !isOrderCancelled() ? FsColor.green : FsColor.red;

  @override
  error(error, {callingType}) {
    if (callingType == 'timing') {
      return;
    }
    Toasly.error(context, error);
    orderData = null;
    notifyUi();
  }

  @override
  failure(failed, {callingType}) {
    if (callingType == 'timing') {
      return;
    }
    // TODO: implement failure
    Toasly.error(context, failed);
    orderData = null;
    notifyUi();
  }

  @override
  success(success, {callingType}) {
    // TODO: implement success
//    return null;
    print("success ---- $success");
    if (callingType == CT_ORDER_SUMARRY) {
      companyName = success["from_company_name"].toString();
      orderData = success["data"];

      mapData();
      notifyUi();
    } else if (callingType == 'defalt_company_api') {
      print("success company-api ---------------- $success");
      List succes = success["data"];
      if (succes.length > 0) {
        setState(() {});
        SsoStorage.setCompanyApi(succes);
        SsoStorage.getCompanyApi("MONEY").then((value) {
          print("money Api ------------- $value");
          onlineOrderPresenter.getStoreTiming(value, "timing");
        });
      } else {}
    } else if (callingType == 'timing') {
      List settings = success["data"];
      List a = settings
          .where((element) => element['key'] == 'SUPPORT_CONTACT_NO')
          .toList();
      if (a != null && a.length > 0) {
        String number = a[0]['value'];
        if (number == null || number.isEmpty) {
          return;
        }
        orderData["call_at"] = number;
        setState(() {});
      }
      print(a);
      print("success setting ---------------- $success");
    }
  }

  void notifyUi() {
    isLoading = false;
    setState(() {});
  }

  getFullAddress(place) {
    String address = "";

    if (place["delivery_address"] != null &&
        place["delivery_address"].length > 0) {
      address = place["delivery_address"];
    }
    if (place["delivery_landmark"] != null &&
        place["delivery_landmark"].length > 0) {
      address = address.length > 0
          ? address + ", " + place["delivery_landmark"]
          : place["delivery_landmark"];
    }
    if (place["delivery_locality"] != null &&
        place["delivery_locality"].length > 0) {
      address = address.length > 0
          ? address + ", " + place["delivery_locality"]
          : place["delivery_locality"];
    }
    if (place["delivery_city"] != null && place["delivery_city"].length > 0) {
      address = address.length > 0
          ? address + ", " + place["delivery_city"]
          : place["delivery_city"];
    }
    return address;
  }

  String getButtonName() {
//    if (orderData["status"] == FsString.REQUESTED ||
//        orderData["status"] == FsString.APPROVED) {
//      return "Review Your Order";
//    } else {
    return "Track Your Order";
//    }
//    return "Repeat Order";
  }

  void orderStatus() {
    if (!isOrderCancelled()) {
      if (orderData["status"] == FsString.REQUESTED ||
          orderData["status"] == FsString.APPROVED) {
        Navigator.of(context).pop();
        FsNavigator.push(context,
            new GroceryOrderSummary(userProfile, orderData, businessAppMode));
      } else {
        var userName = userProfile['username'];
        var sessionToken = userProfile['session_token'];
        String con = Environment().getCurrentConfig().vezaPlugInUrl;
        var industry_type = orderData["unit"]["industry_type"];
        if (industry_type == "retail") {
          con = Environment().getCurrentConfig().vezaGroceryPlugInUrl;
        }
        String order_id = orderData['id'].toString();
        String comapny_id = orderData['company_id'].toString();
        String order_tracking = con +
            "confirmed?session_token=$sessionToken&username="
                "$userName&companyId=$comapny_id&orderId=$order_id&trackOrder=true&trackOrderOneapp=true";
        print(order_tracking);
        FsNavigator.push(
            context,
            OnlineOrderWebView(
                businessAppMode, 'Order Tracking', order_tracking));
      }
    }
  }

  String getPhoneNumber(mobiles, {bool callAt = false}) {
    String mobNos = "";
    if (mobiles != null) {
      for (int i = 0; i < mobiles.length; i++) {
        if (i == 0) {
          mobNos = mobiles[i];
          if (callAt) {
            return mobNos;
          }
        } else {
          mobNos = mobNos + ", " + mobiles[i];
        }
      }
    }
    return mobNos;
  }

  String getOrderStatus(orderData) {
    return orderData["status"];
  }

  bool isPickupType() {
    if (orderData["delivery_type"] == FsString.DELIVERY) {
      return false;
    } else {
      return true;
    }
  }

  String getDeliveryStatus(orderData) {
    return orderData["delivery_status"];
  }

  bool isOrderCancelled() {
    if (orderData["status"] == FsString.CANCELLED ||
        orderData["status"] == FsString.REJECTED) {
      return true;
    } else {
      return false;
    }
  }

  bool isRequested() {
    if (orderData["status"] == FsString.REQUESTED) {
      return true;
    } else {
      return false;
    }
  }

  Widget deliveryStatusWidget() {
    return isOrderCancelled() || isPickupType()
        ? Container()
        : Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Status'.toLowerCase(),
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.lightgrey,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      orderData["delivery_status"].toLowerCase(),
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          color:
                              !isOrderCancelled() ? FsColor.green : FsColor.red,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          );
  }

  Widget deliveryDateWidget() {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                !isPickupType() ? 'Delivery Date'.toLowerCase() : 'pickup date',
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.lightgrey,
                ),
              ),
              SizedBox(height: 3),
              Text(
                !isPickupType()
                    ? orderData["delivery_date"]
                    : orderData["pickup_date"].toLowerCase(),
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.darkgrey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget pickupSlot() {
    if (orderData["unit"]["industry_type"] != 'retail') {
      return Container();
    }
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                !isPickupType() ? 'delivery slot' : 'Pickup slot'.toLowerCase(),
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.lightgrey,
                ),
              ),
              SizedBox(height: 3),
              Text(
                orderData["pickup_slot"].toLowerCase(),
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-SemiBold'),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  String getPickupSlot(orderData) {
    try {
      return AppUtils.getConvertDate(orderData["slot_start_time"].toString(),
              date_from_format: "HH:mm:ss", date_to_formate: "hh:mm a") +
          " - " +
          AppUtils.getConvertDate(orderData["slot_end_time"].toString(),
              date_from_format: "HH:mm:ss", date_to_formate: "hh:mm a");
    } catch (e) {
      return "";
    }
  }

  Widget addressWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPickupType()
                ? 'pickup address'.toLowerCase()
                : 'Deliver address'.toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h6size,
              color: FsColor.lightgrey,
            ),
          ),
          SizedBox(height: 3),
          Text(
            isPickupType()
                ? orderData["pickup_address"].toLowerCase()
                : orderData["full_address"].toLowerCase(),
            style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h6size,
              color: FsColor.darkgrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget phoneNoWidget() {
    return true == false
        ? Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone number'.toLowerCase(),
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.lightgrey,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      orderData["phone_no"].toLowerCase(),
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          )
        : Container();
  }

  bool isUnconfirmed() {
    if (orderData["status"] == FsString.UNCONFIRMED) {
      return true;
    } else {
      return false;
    }
  }

  getPaymentStatusColor() {
    if (orderData["payment_status"].toString().toLowerCase() == "paid") {
      return FsColor.paid;
    } else if (orderData["payment_status"].toString().toLowerCase() ==
        "unpaid") {
      return FsColor.unPaid;
    } else {
      return FsColor.partialPaid;
    }
  }
}
