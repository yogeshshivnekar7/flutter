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

class GroceryOrderHistoryDetail extends StatefulWidget {
  var userProfile;

  var orderDetails;

  var businessAppMode;
  var type;

  GroceryOrderHistoryDetail(
      this.userProfile, this.orderDetails, this.businessAppMode,
      {this.type});

  @override
  _GroceryOrderHistoryDetailState createState() =>
      new _GroceryOrderHistoryDetailState(
          this.userProfile, this.orderDetails, this.businessAppMode,
          type: this.type);
}

class _GroceryOrderHistoryDetailState extends State<GroceryOrderHistoryDetail>
    implements OnlineOrderView {
  List historyitems = [];
  var CT_ORDER_SUMARRY = "order_summary";
  var userProfile;

//  var orderId;

  OnlineOrderPresenter onlineOrderPresenter;

  var orderDetails;

  var orderData;

  bool isLoading = false;

  BusinessAppMode businessAppMode;

  String companyName = "";

  String companyAddress = "";
  var type;

  _GroceryOrderHistoryDetailState(
      this.userProfile, this.orderData, this.businessAppMode,
      {this.type});

  @override
  void initState() {
    super.initState();
    onlineOrderPresenter = new OnlineOrderPresenter(this);
    isLoading = true;
    onlineOrderPresenter.getOrderDetails(orderData, CT_ORDER_SUMARRY);
  }

  void companyApiCall() {
    onlineOrderPresenter.getCompanyApi(orderDetails["company_id"].toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void mapData() {
    List items = orderDetails["items"];

    orderDetails["subtotal"] =
        AppUtils.convertStringToDouble(orderDetails["subtotal"]);
    orderDetails["total_tax"] =
        AppUtils.convertStringToDouble(orderDetails["total_tax"]);
    orderDetails["delivery_charges"] =
        AppUtils.convertStringToDouble(orderDetails["delivery_charges"]);
    orderDetails["service_charges"] =
        AppUtils.convertStringToDouble(orderDetails["service_charges"]);
    orderDetails["net_amount"] =
        AppUtils.convertStringToDouble(orderDetails["net_amount"]);
    orderDetails["total_discount"] =
        AppUtils.convertStringToDouble(orderDetails["total_discount"]);
    orderDetails["promocode_discount"] =
        AppUtils.convertStringToDouble(orderDetails["promocode_discount"]);
    orderDetails["promo_code"] = orderDetails["promo_code"] != null &&
            orderDetails["promo_code"].length > 0
        ? orderDetails["promo_code"]
        : "";
    orderDetails["payment_mode"] = orderDetails["payment_mode"] != null &&
            orderDetails["payment_mode"].length > 0
        ? orderDetails["payment_mode"]
        : "";
    orderDetails["order_date"] = orderDetails["order_date"] != null &&
            orderDetails["order_date"].length > 0
        ? AppUtils.getConvertDate(orderDetails["order_date"])
        : "";
    orderDetails["delivery_date"] = orderDetails["delivery_date"] != null &&
            orderDetails["delivery_date"].length > 0
        ? AppUtils.getConvertDate(orderDetails["delivery_date"])
        : "";
    orderDetails["pickup_date"] = orderDetails["pickup_date"] != null &&
            orderDetails["pickup_date"].length > 0
        ? AppUtils.getConvertDate(orderDetails["pickup_date"])
        : "";
    orderDetails["full_address"] = getFullAddress(orderDetails);
    orderDetails["phone_no"] = orderDetails["customer_contact_number"];
    orderDetails["order_status"] = getOrderStatus(orderDetails);
    orderDetails["delivery_status"] = getDeliveryStatus(orderDetails);
    orderDetails["pickup_slot"] = getPickupSlot(orderDetails);
    orderDetails["call_at"] =
        getPhoneNumber(orderDetails["mobiles"], callAt: true);
    historyitems.clear();
    for (int i = 0; items != null && i < items.length; i++) {
      var itemDetails = items[i];
      print("itemsdetails------------$itemDetails");
      var item = {
        "id": itemDetails["id"].toString(),
        "order_id": itemDetails["order_id"].toString(),
        "name": itemDetails["item"].toString(),
        "qty":
            AppUtils.convertStringToDouble(itemDetails["quantity"].toString()),
        "amount":
            AppUtils.convertStringToDouble(itemDetails["price"].toString()),
        "totalamount":
            AppUtils.convertStringToDouble(itemDetails["subtotal"].toString()),
        "isavailable": true,
        "cancelled": false
      };
      historyitems.add(item);
    }
    setState(() {});
    companyApiCall();
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
          'Order Details'.toLowerCase(),
          style: FsAppBarStyle.getAppStyle(businessAppMode),
        ),
        leading: FsAppBarStyle.getleading(businessAppMode),
        actions: <Widget>[
          true == false
              ? Container(
                  width: 70,
                  child: FlatButton(
                    onPressed: () {
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (BuildContext context) {
//                    return GrocerySupport();
//                  },
//                ),
//              );
                    },
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      'Help',
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          color: FsAppBarStyle.iconColor(businessAppMode),
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      body: isLoading
          ? PageLoader()
          : orderDetails == null
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
                                child: orderDetails['unit'] == null ||
                                        AppUtils.getCompanyImage(
                                                orderDetails['unit']) ==
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
                                                orderDetails['unit'])),
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
                                    /*Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              companyAddress,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h7size,
                                  color: FsColor.lightgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Container(
                        //   // decoration: BoxDecoration(
                        //   //     border: Border(
                        //   //       top: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.3),),
                        //   //       bottom: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.3),)
                        //   //     )
                        //   // ),
                        //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        //   padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        //   alignment: Alignment.center,
                        //     child: Text(
                        //     'your order with A1 Mart is delivered'.toLowerCase(),
                        //     style: TextStyle(fontSize: FSTextStyle.h6size,color: FsColor.green,fontFamily: 'Gilroy-SemiBold'),
                        //   ),
                        // ),

                        // Container(
                        //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        //   padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        //   alignment: Alignment.centerRight,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         Icon(FlutterIcon.ok_circled2, color: FsColor.green,  size: FSTextStyle.h6size),
                        //         SizedBox(width: 5),
                        //         Text(
                        //           'order delivered'.toLowerCase(),
                        //           style: TextStyle(fontSize: FSTextStyle.h6size,color: FsColor.green,fontFamily: 'Gilroy-SemiBold'),
                        //         ),
                        //       ],
                        //     ),

                        // ),

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
                              false == true
                                  ? GestureDetector(
                                      child: FlatButton(
                                      onPressed: null,
                                      padding: EdgeInsets.all(0),
                                      child: Text(
                                        'Mark as Favorite'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.primarygrocery,
                                            fontFamily: 'Gilroy-SemiBold'),
                                      ),
                                    ))
                                  : Container(),
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
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                    Text(
                                      orderDetails["subtotal"],
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              orderDetails["promocode_discount"] == "0" ||
                                  orderDetails["promocode_discount"] ==
                                      "0.0"
                                  ? Container()
                                  : Container(
                                padding:
                                EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'promo code (' +
                                          orderDetails["promo_code"] +
                                          ")".toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                    Text(
                                      "(-) " +
                                          "₹" +
                                          orderDetails[
                                          "promocode_discount"],
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
                                      'discount',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                      ),
                                    ),
                                    Text(
                                      "(-) " +
                                          "₹" +
                                          orderDetails["total_discount"],
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
                                          orderDetails["delivery_charges"]
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
                                          orderDetails["total_tax"]
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
                              true != true
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Convenience/Service Charges'
                                                .toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Regular',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.darkgrey,
                                            ),
                                          ),
                                          Text(
                                            "(+) " +
                                                "₹" +
                                                orderDetails["service_charges"]
                                                    .toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.darkgrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
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
                                          orderDetails["net_amount"]
                                              .toLowerCase(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.basicprimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        type == null
                            ? Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                alignment: Alignment.centerLeft,
                                // decoration: BoxDecoration(
                                //   color: FsColor.darkgrey.withOpacity(0.05),
                                //   border: Border(
                                //     top: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.3),),
                                //     bottom: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.3),)
                                //   )
                                // ),
                                child: Text(
                                  'Order Details'.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h5size,
                                      color: FsColor.basicprimary,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                              )
                            : Container(),
                        type == null
                            ? Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
//                    deliveryStatusWidget(),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Number'.toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.lightgrey,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            orderDetails["order_no"],
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

                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Status'.toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.lightgrey,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            orderDetails['order_status'] ==
                                                'completed' ||
                                                orderDetails[
                                                "delivery_status"] ==
                                                    'delivered'
                                                ? 'delivered'.toLowerCase()
                                                : orderDetails["order_status"]
                                                .toLowerCase(),
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                color: getColor(
                                                    orderDetails["order_status"]
                                                        .toLowerCase()),
                                                fontFamily: 'Gilroy-SemiBold'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Payment status'.toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.lightgrey,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            orderDetails["payment_status"]
                                                .toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h6size,
                                              color: getPaymentStatusColor(),
                                            ),
                                          ),
                                          orderDetails['order_status'] ==
                                              FsString.CANCELLED &&
                                              orderDetails[
                                              'payment_status'] ==
                                                  'paid'
                                              ? Text(
                                            '(paid amount will be refunded within 5 to 7 days)'
                                                .toLowerCase(),
                                            style: TextStyle(
                                                fontFamily:
                                                'Gilroy-SemiBold',
                                                fontSize:
                                                FSTextStyle.h7size,
                                                color: Colors.black87),
                                          )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Payment mode'.toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.lightgrey,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            orderDetails["payment_mode"]
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
                                    SizedBox(height: 10),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Date'.toLowerCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.lightgrey,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            orderDetails["order_date"]
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
                                    SizedBox(height: 10),
                                    deliveryDateWidget(),
                                    pickupSlot(),
                                    phoneNoWidget(),

                                    addressWidget(),
                                    SizedBox(height: 20),
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                  width: 1,
                                                  color: FsColor.darkgrey
                                                      .withOpacity(0.1),
                                                ),
                                                bottom: BorderSide(
                                                  width: 1,
                                                  color: FsColor.darkgrey
                                                      .withOpacity(0.1),
                                                ))),
                                        padding:
                                        EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Call ' +
                                              orderDetails["call_at"]
                                                  .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.red,
                                              fontFamily: 'Gilroy-SemiBold'),
                                        ),
                                      ),
                                      onTap: () {
                                        AppUtils.callIntent(
                                            orderDetails["call_at"])
                                            .then((value) {
//                                  Toasly.error(context, value);
                                        });
                                      },
                                    )
                                  ],
                                ),
                        )
                            : Container(),
                        SizedBox(height: 70),
                      ],
                    ),
                    type != null
                        ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(
                                30.0, 10.0, 30.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(4.0),
                            ),
                            child: Text("Continue Shopping",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold')),
                            onPressed: () {
                              orderStatus();
                            },
                            color: FsColor.basicprimary,
                            textColor: FsColor.white,
                          ),
                        ),
                      ),
                    )
                        : (orderDetails['delivery_status'] == 'delivered' ||
                        orderDetails['order_status'] ==
                            'rejected') ||
                        orderDetails['order_status'] ==
                            FsString.CANCELLED
                        ? Container()
                        : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(
                                30.0, 10.0, 30.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(4.0),
                            ),
                            child: Text(getButtonName(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold')),
                            onPressed: () {
                              orderStatus();
                            },
                            color: !isOrderCancelled()
                                ? FsAppBarStyle.getButtonColor(
                                businessAppMode)
                                : FsColor.lightgrey,
                            textColor: FsColor.white,
                          ),
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
    orderDetails = null;
    notifyUi();
  }

  @override
  failure(failed, {callingType}) {
    if (callingType == 'timing') {
      return;
    }
    // TODO: implement failure
    Toasly.error(context, failed);
    orderDetails = null;
    notifyUi();
  }

  @override
  success(success, {callingType}) {
    // TODO: implement success
//    return null;
    print("success ---- $success");
    if (callingType == CT_ORDER_SUMARRY) {
      companyName = success["from_company_name"].toString();
      orderDetails = success["data"];

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
        orderDetails["call_at"] = number;
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
//    if (orderDetails["status"] == FsString.REQUESTED ||
//        orderDetails["status"] == FsString.APPROVED) {
//      return "Review Your Order";
//    } else {
    return "Track Your Order";
//    }
//    return "Repeat Order";
  }

  void orderStatus() {
    if (!isOrderCancelled()) {
      if (orderDetails["status"] == FsString.REQUESTED ||
          orderDetails["status"] == FsString.APPROVED) {
        Navigator.of(context).pop();
        FsNavigator.push(context,
            new GroceryOrderSummary(userProfile, orderData, businessAppMode));
      } else {
        var userName = userProfile['username'];
        var sessionToken = userProfile['session_token'];
        String con = Environment().getCurrentConfig().vezaPlugInUrl;
        var industry_type = orderDetails["unit"]["industry_type"];
        if (industry_type == "retail") {
          con = Environment().getCurrentConfig().vezaGroceryPlugInUrl;
        }
        String order_id = orderDetails['id'].toString();
        String comapny_id = orderDetails['company_id'].toString();
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

  String getOrderStatus(orderDetails) {
    return orderDetails["status"];
  }

  bool isPickupType() {
    if (orderDetails["delivery_type"] == FsString.DELIVERY) {
      return false;
    } else {
      return true;
    }
  }

  String getDeliveryStatus(orderDetails) {
    return orderDetails["delivery_status"];
  }

  bool isOrderCancelled() {
    if (orderDetails["status"] == FsString.CANCELLED ||
        orderDetails["status"] == FsString.REJECTED) {
      return true;
    } else {
      return false;
    }
  }

  bool isRequested() {
    if (orderDetails["status"] == FsString.REQUESTED) {
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
                      orderDetails["delivery_status"].toLowerCase(),
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
                    ? orderDetails["delivery_date"]
                    : orderDetails["pickup_date"].toLowerCase(),
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
    if (orderDetails["unit"]["industry_type"] != 'retail') {
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
                orderDetails["pickup_slot"].toLowerCase(),
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

  String getPickupSlot(orderDetails) {
    try {
      return AppUtils.getConvertDate(orderDetails["slot_start_time"].toString(),
              date_from_format: "HH:mm:ss", date_to_formate: "hh:mm a") +
          " - " +
          AppUtils.getConvertDate(orderDetails["slot_end_time"].toString(),
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
                ? orderDetails["pickup_address"].toLowerCase()
                : orderDetails["full_address"].toLowerCase(),
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
                      orderDetails["phone_no"].toLowerCase(),
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
    if (orderDetails["status"] == FsString.UNCONFIRMED) {
      return true;
    } else {
      return false;
    }
  }

  getPaymentStatusColor() {
    if (orderDetails["payment_status"].toString().toLowerCase() == "paid") {
      return FsColor.paid;
    } else if (orderDetails["payment_status"].toString().toLowerCase() ==
        "unpaid") {
      return FsColor.unPaid;
    } else {
      return FsColor.partialPaid;
    }
  }
}
