import 'package:common_config/utils/fs_navigator.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/orders/cart/grocery_order_cart_detail.dart';
import 'package:sso_futurescape/ui/module/orders/store_detail_helper.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/ui/widgets/style_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

// For get saved cart

// URL: https://stgmoneyapi.vezaone.com/api/v1/app/customers/session/cart
// ?api_key=da5b43e3f5098dd3877cdf81bfef0b7446cbc80f1cb42d13c7df13d1bae40c4c&company_id=3&user_id=1254

// for save in session cart
// URL: https://stgmoneyapi.vezaone.com/api/v1/app/customers/session/cart
// parameters: api_key:da5b43e3f5098dd3877cdf81bfef0b7446cbc80f1cb42d13c7df13d1bae40c4c
// company_id:3
// user_id:1254
// value:JSON value

class CartOrders extends StatefulWidget {
  var companyDetails;

  var businessAppMode;

  CartOrders(
    this.companyDetails,
    this.businessAppMode,
  );

  _OlderOrderState a;

  @override
  _OlderOrderState createState() =>
      a = new _OlderOrderState(companyDetails, businessAppMode);

  void updateOrderList() {
    print("Cart List111");
    a.getOldOrder();
  }
}

class _OlderOrderState extends State<CartOrders> implements OnlineOrderView {
  var userProfile;

  var addresses;

  List items = [];

//  String companyId;
  var onlineOrderPresenter;

  var businessAppMode;

  bool repeatUnable = false;

  var companyDetails;

  bool allOrder = false;

  var getCartList = [];

  _OlderOrderState(this.companyDetails, this.businessAppMode,
      {this.allOrder = true});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onlineOrderPresenter = new OnlineOrderPresenter(this);
    getOldOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map address;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor:
            OnlineOrderWebViewState.backgroundColor(businessAppMode),
        elevation: 0.0,
        title: new Text(
          companyDetails == null
              ? " My Cart".toLowerCase()
              : 'Orders History'.toLowerCase(),
          style: FsAppBarStyle.getAppStyle(businessAppMode),
        ),
        /* actions: <Widget>[
          IconButton(
            onPressed: () {
              listListner.clearAllState();
              getOldOrder();
            },
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            icon: Icon(
              FlutterIcon.arrows_cw,
              color: FsAppBarStyle.iconColor(businessAppMode),
              size: FSTextStyle.h4size,
            ),
          ),
          SizedBox(width: 5)
        ],*/
        leading: FsAppBarStyle.getleading(businessAppMode),
      ),
      body: isListLoading
          ? PageLoader()
          : Stack(
              children: <Widget>[
                mapOrderList == null || mapOrderList.length == 0
                    ? getEmpty()
                    : ListView.builder(
                        itemCount: mapOrderList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          Map place = mapOrderList[index];
                          return GestureDetector(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                  width: 1.0,
                                  color: FsColor.lightgrey.withOpacity(0.5),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  companyDetails == null
                                      ? Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            width: 1.0,
                                            color: FsColor.lightgrey
                                                .withOpacity(0.5),
                                          ))),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: place['company_code'] ==
                                                            null ||
                                                        AppUtils.getCompanyImage(
                                                                place) ==
                                                            null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
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
                                                            AppUtils
                                                                .getCompanyImage(
                                                                    place)),
                                                        placeholder: AssetImage(
                                                            AppUtils.getDefultImage(
                                                                businessAppMode)),
                                                        height: 48,
                                                        width: 48,
                                                        fit: BoxFit.cover),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        '${place["company_name"]}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                FSTextStyle
                                                                    .h6size,
                                                            color: FsColor
                                                                .basicprimary,
                                                            fontFamily:
                                                                'Gilroy-SemiBold'),
                                                      ),
                                                      SizedBox(height: 5),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    getOrderSummary(place);
                                                  },
                                                  child: Text(
                                                    'View Detail'.toLowerCase(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h6size,
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Total items '.toLowerCase(),
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h6size,
                                                    color: FsColor.lightgrey,
                                                    fontFamily:
                                                        'Gilroy-SemiBold'),
                                              ),
                                              SizedBox(height: 3),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    place["item_count"]
                                                        .toString()
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            FSTextStyle.h6size,
                                                        color: FsColor.darkgrey,
                                                        fontFamily:
                                                            'Gilroy-SemiBold'),
                                                  ),
                                                  SizedBox(width: 7),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Sub total'.toLowerCase(),
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h6size,
                                                    color: FsColor.lightgrey,
                                                    fontFamily:
                                                        'Gilroy-SemiBold'),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "₹" +
                                                    "${AppUtils.convertStringToDouble(place["sub_total"].toString())}",
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h6size,
                                                    color: FsColor.darkgrey,
                                                    fontFamily:
                                                        'Gilroy-SemiBold'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 32,
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      width: double.infinity,
                                      child: RaisedButton(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 0.0, 10.0, 0.0),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(4.0),
                                        ),
                                        onPressed: () {
                                          //getOrderSummary(place);
                                          StoreDetailHelper(context).termsDialog(
                                              context,
                                              StoreDetailHelper
                                                  .getAccordingToIndustryType(
                                                  place['industry_type']),
                                              place,
                                              shoeBottom: false);
                                        },
                                        child: Text(
                                          'Continue Shopping & Checkout',
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold'),
                                        ),
                                        color: FsColor.basicprimary,
                                        textColor: FsColor.white,
                                      )),
                                ],
                              ),
                            ),
                            onTap: () => getOrderSummary(place),
                          );
                        })
                /*FsListWithSearchWidget(
            errorWidget: getEmpty(),
            showError: false,
            message: null,
            title: false,
            pageLoadListner: this,
            itemBuilder: (BuildContext context, int index, var place) {
              */ /*return Container(
                height: 100,
                child: ListTile(
                  title: Text(item["order_no"]),
                  subtitle: Text("Order Status -${item["status"]}\nDelivery Status -${item["delivery_status"]}",),
                  onTap: () => getOrderSummary(item),
                ),
              );*/ /*
              return GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(
                      width: 1.0,
                      color: FsColor.lightgrey.withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      companyDetails == null
                          ? Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                width: 1.0,
                                color: FsColor.lightgrey.withOpacity(0.5),
                              ))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: place['unit'] == null ||
                                            AppUtils.getCompanyImage(
                                                    place['unit']) ==
                                                null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                    place['unit'])),
                                            placeholder: AssetImage(
                                                AppUtils.getDefultImage(
                                                    businessAppMode)),
                                            height: 48,
                                            width: 48,
                                            fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${place["company_name"]}',
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                color: FsColor.basicprimary,
                                                fontFamily: 'Gilroy-SemiBold'),
                                          ),
                                          SizedBox(height: 5),
                                          */ /*Text(
                                      '${place["company_address"]}',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),*/ /*
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        getOrderSummary(place);
                                      },
                                      child: Text(
                                        'View Detail'.toLowerCase(),
                                        style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            */ /*Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Items',
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                Text(
                                  '${place["orderitem"]}',
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.darkgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),*/ /*
                            */ /*Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Order number'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.lightgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '${place["order_no"].toString()}',
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Ordered on'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.lightgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '${AppUtils.getConvertDate(
                                        place["order_date"]).toString()}',
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                ],
                              ),
                            ),
                            */ /*
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Total items '.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.lightgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '10'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.darkgrey,
                                            fontFamily: 'Gilroy-SemiBold'),
                                      ),
                                      SizedBox(width: 7),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Total Amount'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.lightgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "₹" +
                                        "${AppUtils.convertStringToDouble(place["net_amount"].toString())}",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Container(
                          height: 32,
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: double.infinity,
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),
                            ),
                            onPressed: () {
                              //getOrderSummary(place);
                            },
                            child: Text(
                              'Continue Shopping',
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                            color: FsColor.basicprimary,
                            textColor: FsColor.white,
                          )),
                    ],
                  ),
                ),
                onTap: () => null,
              );
            },
            afterView: (FsListWithSearchState v) {
              listListner = v;
            },
          ),
          _loader()*/
              ],
            ),
    );
  }

  bool isListLoading = true;

  @override
  error(error, {var callingType}) {
    isListLoading = false;
    setState(() {});
    print("error company-api ---------------- $error");
  }

  @override
  failure(failed, {var callingType}) {
    isListLoading = false;
    setState(() {});
    print("failed company-api ---------------- $failed");
  }

  @override
  success(success, {var callingType}) {
    print("success company-api ---------------- $success");
    isListLoading = false;
    /*var metadata = success["data"];
    if (allOrder) {
//      companyDetails={
//        "company_name":metadata["from_company_name"],
//        "company_id":metadata["company_id"],
//        "address":metadata["address"]!=null &&metadata["address"].length>0?metadata["address"]:"not mentioned"
//
//      };;
    }

    List orders = metadata["data"];*/
    mapList(success);
  }

  void getOldOrder({String page = "1"}) {
    print("Cart List");
    if (userProfile == null) {
      SsoStorage.getUserProfile().then((userProfile) {
        this.userProfile = userProfile;
        getOrders(userProfile, page);
      });
    } else {
      getOrders(userProfile, page);
    }

    /* SsoStorage.getPastOrderDetails(companyId).then((orderDetails) {
//      List orders=[];
      if (orderDetails != null) {
        items = orderDetails;
      }
//      items=orders;
      print("order------------------ $items");
      setState(() {});
    });*/
  }

  void getOrders(userProfile, String page) {
//    if (!allOrder) {
//      onlineOrderPresenter.getOldOrder(userProfile, "OldOnline", page);
//    } else {
    onlineOrderPresenter.getAllCartOrders(userProfile, "OldOnline");
//    }
  }

  void getOrderSummary(var order) {
    print("oreeder --------------$order");
//    Navigator.of(context).pop();
    FsNavigator.push(
        context,
        new GroceryOrderCartDetail(userProfile, order, this.businessAppMode,
            type: "cart"));
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

  List mapOrderList = [];
  List cartList = [];

  void mapList(Map orders1) {
    List orders = orders1['items'];
    mapOrderList.clear();
    cartList.clear();
    getCartList = [];
    for (int i = 0; i < orders.length; i++) {
      List a = orders[i]["value"];
      var order = {
        "company_id": orders[i]["company"]['id'].toString(),
        "company_name": orders[i]["company"]['name'],
        "company_code": orders[i]["company"]['code'],
        "industry_type": orders[i]["company"]['industry_type'],
        "item_count": getTotalQty(a),
        "value": a,
        'sub_total': getSubTotal(a),
      };

      mapOrderList.add(order);
    }

    setState(() {});
  }

  Widget getEmpty() {
    return Container(
        height: 350.0,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*Image.asset('images/empty-list.png',
               fit: BoxFit.contain,
               width: 150.0, height: 150.0,
             ),*/
            Text(
              FsString.NO_CART_ORDER_FOUND.toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  letterSpacing: 1.0,
                  fontSize: FSTextStyle.h3size,
                  height: 1.5,
                  color: FsColor.darkgrey),
            ),
            Text(
              /*'Add items to it now '*/
              " ".toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  letterSpacing: 1.0,
                  height: 1.5,
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey),
            ),
          ],
        ));
    ;
  }

  Map mapAll(Map place) {
    return {
      "company_id": place["company_id"],
      "company_name": place["company_name"],
      "minimum_order": place["minimum_order_value"].toString(),
      "phone_no": AppUtils.getDetails("support_no", place),
      "user_address": address,
    };
  }

  double getSubTotal(List<dynamic> a) {
    double total = 0;
    for (int i = 0; i < a.length; i++) {
      Map itemDetails = a[i];
      total += double.parse(itemDetails["price"]) * itemDetails['count'];
    }
    return total;
  }

  double getTotalQty(List<dynamic> a) {
    double total = 0;
    for (int i = 0; i < a.length; i++) {
      Map itemDetails = a[i];
      total += itemDetails['count'];
    }
    return total;
  }
}
