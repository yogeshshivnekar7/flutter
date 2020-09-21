import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/ui/widgets/style_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'grocery_orderhistory_detail.dart';

class OlderOrder extends StatefulWidget {
  var companyDetails;

  var businessAppMode;

  OlderOrder(
    this.companyDetails,
    this.businessAppMode,
  );

  @override
  _OlderOrderState createState() =>
      new _OlderOrderState(companyDetails, businessAppMode);
}

class _OlderOrderState extends State<OlderOrder>
    implements OnlineOrderView, PageLoadListener {
  var userProfile;

  var addresses;

  List items = [];

//  String companyId;
  OnlineOrderPresenter onlineOrderPresenter;

  var businessAppMode;

  bool repeatUnable = false;

  var companyDetails;

  bool allOrder = false;

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
  FsListState listListner;

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
              ? " My Orders".toLowerCase()
              : 'Orders History'.toLowerCase(),
          style: FsAppBarStyle.getAppStyle(businessAppMode),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              listListner.clearListAndData();
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
        ],
        leading: FsAppBarStyle.getleading(businessAppMode),
      ),
      body: isCancelListLoading
          ? PageLoader()
          : Stack(
              children: <Widget>[
                FsListWidget(
                  message: FsString.NO_ORDER_FOUND,
                  title: false,
                  pageLoadListner: this,
                  itemBuilder: (BuildContext context, int index, var place) {
                    /*return Container(
                height: 100,
                child: ListTile(
                  title: Text(item["order_no"]),
                  subtitle: Text("Order Status -${item["status"]}\nDelivery Status -${item["delivery_status"]}",),
                  onTap: () => getOrderSummary(item),
                ),
              );*/
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
                                                      fontSize:
                                                          FSTextStyle.h6size,
                                                      color:
                                                          FsColor.basicprimary,
                                                      fontFamily:
                                                          'Gilroy-SemiBold'),
                                                ),
                                                SizedBox(height: 5),
                                                /*Text(
                                      '${place["company_address"]}',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      FlutterIcon.angle_right,
                                      size: FSTextStyle.h4size,
                                      color: FsColor.darkgrey,
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
                                  /*Container(
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
                          SizedBox(height: 5),*/
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                  SizedBox(height: 5),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                              "${AppUtils.convertStringToDouble(
                                                  place["net_amount"]
                                                      .toString())}",
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Delivery type'.toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.lightgrey,
                                              fontFamily: 'Gilroy-SemiBold'),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          place["delivery_type"].toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.darkgrey,
                                              fontFamily: 'Gilroy-SemiBold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                        width: 1.0,
                                        color: FsColor.lightgrey.withOpacity(
                                            0.5),
                                      ))),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      place["delivery_status"] == 'delivered'
                                          ? '${place["delivery_status"]
                                          .toString()}'
                                          : '${place["status"].toString()}',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: getColor(
                                              place["status"].toString()),
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                  ),
                                  repeatUnable
                                      ? Container(
                                    height: 30,
                                    child: FlatButton(
                                        onPressed: () {},
                                        padding: EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(FlutterIcon.cw,
                                                color: FsColor
                                                    .primarygrocery,
                                                size: FSTextStyle.h6size),
                                            SizedBox(width: 5),
                                            Text(
                                              'Repeat Order',
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle.h6size,
                                                  color: FsColor
                                                      .primarygrocery,
                                                  fontFamily:
                                                  'Gilroy-SemiBold'),
                                            )
                                          ],
                                        )),
                                  )
                                      : Container(),
                                  isCancelableAvailable(place)
                                      ? Container(
                                    height: 30,
                                    child: RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(4.0),
                                        ),
                                        color: FsColor.basicprimary,
                                        textColor: FsColor.white,
                                        onPressed: () {
                                          showCancelOrderConfitmationAlertDialog(
                                              context, place);
                                        },
                                        padding: EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Cancel Order',
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle.h6size,
                                                  color: FsColor.white,
                                                  fontFamily:
                                                  'Gilroy-SemiBold'),
                                            )
                                          ],
                                        )),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => getOrderSummary(place),
                    );
                  },
                  afterView: (FsListState v) {
                    listListner = v;
                  },
                ),
                _loader()
              ],
      ),
    );
  }

  bool isListLoading = false;

  Widget _loader() {
    return isListLoading
        ? new Align(
      child: new Container(
        width: 45.0,
        height: 45.0,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      FsColor.primarygrocery),
                ))),
      ),
      alignment: FractionalOffset.bottomCenter,
    )
        : new SizedBox(
      width: 0.0,
      height: 0.0,
    );
  }

  @override
  error(error, {var callingType}) {
    /*  if (callingType == 'defalt_company_api') {
      return;
    }*/
    isListLoading = false;
    isCancelListLoading = false;
    setState(() {});
    print("error company-api ---------------- $error");
  }

  @override
  failure(failed, {var callingType}) {
    /* if (callingType == 'defalt_company_api') {
      return;
    }*/
    isListLoading = false;
    isCancelListLoading = false;
    setState(() {});
    print("failed company-api ---------------- $failed");
  }

  @override
  success(success, {var callingType}) {
    print("success company-api ---------------- $success");
    if (callingType == 'defalt_company_api') {
      print("success company-api ---------------- $success");
      List succes = success["data"];
      if (succes.length > 0) {
        setState(() {});
        SsoStorage.setCompanyApi(succes);
        SsoStorage.getCompanyApi("MONEY").then((value) {
          print("money Api ------------- $value");
          onlineOrderPresenter.cancelOrder(
              order_id, "cancel_order", userProfile);
        });
      }
      return;
    } else if (callingType == 'cancel_order') {
      isCancelListLoading = false;
      setState(() {});
      Toasly.success(context, 'Order Cancelled Successfully!');
      getOldOrder();
    } else {
      var metadata = success["data"];
      setState(() {});
      if (allOrder) {
//      companyDetails={
//        "company_name":metadata["from_company_name"],
//        "company_id":metadata["company_id"],
//        "address":metadata["address"]!=null &&metadata["address"].length>0?metadata["address"]:"not mentioned"
//
//      };;
      }
      isListLoading = false;
      List orders = metadata["data"];
      mapList(orders);
      listListner.addListList(metadata, mapOrderList);
    }
  }

  void getOldOrder({String page = "1"}) {
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
    onlineOrderPresenter.getAllOrders(userProfile, "OldOnline", page,
        companyId: companyDetails != null
            ? companyDetails["company_id"].toString()
            : null);
//    }
  }

  void getOrderSummary(var order) {
    print("oreeder --------------$order");
//    Navigator.of(context).pop();
    FsNavigator.push(
        context,
        new GroceryOrderHistoryDetail(
            userProfile, order, this.businessAppMode));
//    print("order ---- $order");
//    if (order["status"] == FsString.REQUESTED ||
//        order["status"] == FsString.APPROVED) {
//      FsNavigator.push(context,
//          new GroceryOrderHistoryDetail(userProfile, order["id"].toString(),companyDetails,this.businessAppMode));
//    } else {
//      var userName = userProfile['username'];
//      var sessionToken = userProfile['session_token'];
//      String con = Environment()
//          .getCurrentConfig()
//          .vezaPlugInUrl;
//      String order_id = order['id'].toString();
//      String comapny_id = order['company_id'].toString();
//      String order_tracking = con +
//          "confirmed?session_token=$sessionToken&username="
//              "$userName&companyId=$comapny_id&orderId=$order_id&trackOrder=true";
//      print(order_tracking);
//      FsNavigator.push(
//          context,
//          OnlineOrderWebView(
//              businessAppMode, 'Order Tracking', order_tracking));
//    }
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    isListLoading = true;
    setState(() {});
    // TODO: implement loadNextPage
    getOldOrder(page: page);
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

  void mapList(List orders) {
    mapOrderList.clear();
    for (int i = 0; i < orders.length; i++) {
      var order = {
        "company_id": orders[i]["company_id"].toString(),
        "company_name": orders[i]["from_company_name"],
        "order_no": orders[i]["data"]["order_no"],
        "order_date": orders[i]["data"]["order_date"],
        "order_id": orders[i]["data"]["id"].toString(),
        "status": orders[i]["data"]["status"],
        "delivery_status": orders[i]["data"]["delivery_status"],
        "delivery_type": orders[i]["data"]["delivery_type"],
        "net_amount": AppUtils.convertStringToDouble(
            orders[i]["data"]["net_amount"].toString()),
        "company_address": "",
        "unit": orders[i]['data']['unit'],
      };
      mapOrderList.add(order);
    }
    setState(() {});
  }

  bool isCancelableAvailable(Map place) {
    if (place['status'] == FsString.UNCONFIRMED) {
      return true;
    } else {
      return false;
    }
  }

  String order_id;
  bool isCancelListLoading = false;

  void cancelOrder(Map place) {
    isCancelListLoading = true;
    setState(() {});
    order_id = place['order_id'];
    OnlineOrderPresenter onlineOrderPresenter = new OnlineOrderPresenter(this);
    onlineOrderPresenter.getCompanyApi(place['company_id']);
  }

  void showCancelOrderConfitmationAlertDialog(BuildContext context, Map place) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Cancel Order ?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text("Are you sure you want to cancel this order ?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[

              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColorStepper.active),
                ),
              ),
              FlatButton(
                onPressed: () {
                  cancelOrder(place);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColorStepper.active),
                ),
              ),
            ],
          );
        });
  }
}
