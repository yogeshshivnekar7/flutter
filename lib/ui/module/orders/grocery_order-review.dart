import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/custom_dialog.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/ui/widgets/style_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class GroceryOrderReview extends StatefulWidget {
  var orderDetails;

  var userProfile;

  var businessAppMode;

  GroceryOrderReview(this.userProfile,
      this.orderDetails, this.businessAppMode,);

  @override
  _GroceryOrderReviewState createState() =>
      new _GroceryOrderReviewState(orderDetails, userProfile, businessAppMode);
}

class _GroceryOrderReviewState extends State<GroceryOrderReview>
    implements OnlineOrderView, CustomDialogListener {
  List revieworder = [];

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  var orderDetails;

  bool isCancelling = false;

  OnlineOrderPresenter onlineOrderPresenter;

  static final String DELETE_ITEM = "delete_item";

  var userProfile;

  String SUMMARY_STATUS = "summary_status";

  CustomDialog customDialog;

  var selected;

  bool itemCancelled = false;

  var businessAppMode;

  _GroceryOrderReviewState(this.orderDetails, this.userProfile,
      this.businessAppMode);

  switchStepType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  bool isShown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onlineOrderPresenter = new OnlineOrderPresenter(this);
    customDialog = new CustomDialog(
      this, content: "Are you sure want to remove this item".toLowerCase(),);
    mapData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          backgroundColor: OnlineOrderWebViewState.backgroundColor(
              businessAppMode),
        elevation: 0.0,
        title: new Text(
          'Order Review'.toLowerCase(),
          style: FsAppBarStyle.getAppStyle(businessAppMode),
        ),
          leading: FsAppBarStyle.getleading(
              businessAppMode, clickEvent: (context) {
            backPressed();
          })
      ),
      body: isCancelling
          ? PageLoader(
        title: "please wait...",
      )
          : Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 24,
                      width: 24,
                      child: Icon(FlutterIcon.info_circled,
                          color: FsColor.yellow,
                          size: FSTextStyle.h5size),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                          child: Text(
                            'Review your order list and the item price before confirming the order'
                                .toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.lightgrey,
                                fontFamily: 'Gilroy-SemiBold'),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Items Details'.toLowerCase(),
                    style: TextStyle(
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.basicprimary,
                        fontFamily: 'Gilroy-SemiBold'),
                  )),
              ListView.builder(
                primary: false,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: revieworder == null ? 0 : revieworder.length,
                itemBuilder: (BuildContext context, int index) {
                  Map place = revieworder[index];
                  Widget w = Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: FsColor.lightgrey.withOpacity(0.5),
                            ))),
                    child: Column(
                      children: <Widget>[
                        !place["isavailable"] && !isShown
                            ? Container(
                          width: double.infinity,
                          padding:
                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          color: FsColor.darkgrey.withOpacity(0.1),
                          child: Text(
                            'unavailable items',
                            style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.darkgrey,
                            ),
                          ),
                        )
                            : Container(),
                        Container(
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
                                        child: place["isavailable"]
                                            ? Text(
                                          '${place["name"]}',
                                          style: TextStyle(
                                            fontFamily:
                                            'Gilroy-SemiBold',
                                            fontSize:
                                            FSTextStyle.h6size,
                                            color: place[
                                            "isavailable"]
                                                ? FsColor.darkgrey
                                                : FsColor.lightgrey,
                                            decoration:
                                            place["cancelled"]
                                                ? TextDecoration
                                                .lineThrough
                                                : TextDecoration
                                                .none,
                                          ),
                                        )
                                            : Text(
                                          '${place["name"]}',
                                          style: TextStyle(
                                            fontFamily:
                                            'Gilroy-SemiBold',
                                            fontSize:
                                            FSTextStyle.h6size,
                                            color: place[
                                            "isavailable"]
                                                ? FsColor.darkgrey
                                                : FsColor.lightgrey,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "${place["qty"]}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Gilroy-Regular',
                                                      fontSize:
                                                      FSTextStyle
                                                          .h6size,
                                                      color: place[
                                                      "isavailable"]
                                                          ? FsColor
                                                          .darkgrey
                                                          : FsColor
                                                          .lightgrey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "x",
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Gilroy-Regular',
                                                      fontSize:
                                                      FSTextStyle
                                                          .h6size,
                                                      color: place[
                                                      "isavailable"]
                                                          ? FsColor
                                                          .darkgrey
                                                          : FsColor
                                                          .lightgrey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "₹" +
                                                        "${AppUtils
                                                            .convertStringToDouble(
                                                            place["amount"])}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Gilroy-Regular',
                                                      fontSize:
                                                      FSTextStyle
                                                          .h6size,
                                                      color: place[
                                                      "isavailable"]
                                                          ? FsColor
                                                          .darkgrey
                                                          : FsColor
                                                          .lightgrey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),

                                child: Text(
                                  "₹" +
                                      "${AppUtils
                                          .convertStringToDouble(
                                          place["totalamount"])}",
                                  style: TextStyle(
                                    fontFamily:
                                    'Gilroy-SemiBold',
                                    fontSize:
                                    FSTextStyle.h6size,
                                    color: place[
                                    "isavailable"]
                                        ? FsColor.darkgrey
                                        : FsColor.lightgrey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              place["isavailable"]
                                  ? Container(
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    child: FlatButton(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, 0),
                                      child: place["cancelled"]
                                          ? Icon(FlutterIcon.plus,
                                          color: FsColor.green,
                                          size: FSTextStyle.h6size)
                                          : Icon(FlutterIcon.cancel_1,
                                          color: FsColor.red,
                                          size: FSTextStyle.h6size),
                                      onPressed: () {
                                        itemAction(place);
                                      },
                                    ),
                                  ))
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  if (!isShown) if (!place["isavailable"]) {
                    isShown = true;
                  }
                  return w;
                },
              ),
              SizedBox(height: 150),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
              child: Column(
                children: <Widget>[
                  reviewDetails(),
                  Container(
                    decoration: BoxDecoration(
                      color: FsColor.primarygroceryop,
                    ),
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            child: RaisedButton(
                              padding:
                              EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              child: Text('Reject',
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold')),
                              onPressed: () {
                                acceptOrder(isReject: true);
                              },
                              color: FsColor.red,
                              textColor: FsColor.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            child: RaisedButton(
                              padding:
                              EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              child: Text('Accept',
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold')),
                              onPressed: () {
                                acceptOrder();
                              },
                              color: FsColor.green,
                              textColor: FsColor.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )

          )
        ],
      ),
    );
  }

  Container reviewDetails() {
    return Container(

      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
          color:
          FsColor.primarygroceryop,
          border: Border(

              top: BorderSide(
                width: 1.0,
                color: FsColor.lightgrey.withOpacity(0.5),
              ))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sub Total'.toLowerCase(),
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.darkgrey,
                ),
              ),
              Text(
                "₹" + AppUtils.convertStringToDouble(
                    orderDetails["subtotal"].toLowerCase()),
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.darkgrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Delivery Charges (+)'.toLowerCase(),
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.darkgrey,
                ),
              ),
              Text(
                "₹" + AppUtils.convertStringToDouble(
                    orderDetails["delivery_charges"]
                        .toLowerCase()),
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.darkgrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                "₹" + AppUtils.convertStringToDouble(
                    orderDetails["net_amount"].toLowerCase()),
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h5size,
                  color: FsColor.basicprimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void mapData() {
    List items = orderDetails["items"];
    revieworder.clear();
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
        "totalamount": AppUtils.convertStringToDouble(
            itemDetails["net_amount"].toString()),
        "isavailable": true,
        "cancelled": false
      };
      revieworder.add(item);
    }
    setState(() {});
  }

  void itemAction(item) {
    if (!item["cancelled"]) {
      _rejectOrderDialog(itemCancel: true, item: item);
    }
//    item["cancelled"] = !item["cancelled"];
//    setState(() {});
  }

  void acceptOrder({bool isReject = false}) {
    if (!isReject) {
      bool canPlace = false;
      for (int i = 0; i < revieworder.length; i++) {
        if (revieworder[i]["isavailable"] && !revieworder[i]["cancelled"]) {
          canPlace = true;
          break;
        }
      }
      if (canPlace) {
        orderDetails["reviewed_order"] = revieworder;
        Navigator.of(context).pop({'reviewed_order': orderDetails});
      } else {
        Toasly.error(context, "Please add atleast one item to accept order");
      }
    } else {
      _rejectOrderDialog();
    }
  }


  void _rejectOrderDialog({bool itemCancel = false, item}) {
    this.selected = item;
    this.itemCancelled = itemCancel;
    customDialog.content =
    itemCancel && revieworder.length != 1
        ? "Are you sure want to remove this item".toLowerCase()
        : "Are you sure want to reject this order".toLowerCase();
//    customDialog.setState();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return customDialog;
      },
    );


  }

  void cancelItem(item) {
//    Navigator.of(context).pop();
    print(item);
//    isCancelling = true;
//    setState(() {});
    onlineOrderPresenter.deleteItem(item, DELETE_ITEM, userProfile);
  }

  void cancelAction(itemCancel, item) {
    if (itemCancel) {
      print("caksndksnkdnsinnd");
      Navigator.of(context).pop();
      cancelItem(item);
    } else {
//      Navigator.of(context).pop();
      Navigator.of(context).pop({'cancelled_order': orderDetails});
    }
  }

  void backPressed() {
    Navigator.of(context).pop({'back_called': 'back'});
  }

  @override
  error(error, {callingType}) {
    print("error-------- $error ------- callingtype--------$callingType");
    if (callingType == DELETE_ITEM) {
      print(error);
    }
    Toasly.error(context, error.toString());
    notifyUi();
  }

  @override
  failure(failed, {callingType}) {
    print("failed-------- $failed ------- callingtype--------$callingType");
    Toasly.error(context, failed.toString());

    notifyUi();
  }

  @override
  success(success, {callingType}) {
    print("success-------- $success ------- callingtype--------$callingType");

    if (callingType == DELETE_ITEM) {
      print(orderDetails);

      onlineOrderPresenter.getOrderSummary(
          userProfile, orderDetails["id"].toString(), SUMMARY_STATUS);
//      onlineOrderPresenter.get
    }
    if (callingType == SUMMARY_STATUS) {
      orderDetails = success["data"];

      mapData();
      notifyUi();
    }
  }

  void notifyUi() {
    isCancelling = false;
    customDialog.dismiss();
    setState(() {});
  }

  @override
  void onClick() {
    print("itemCancelled ---------- $itemCancelled ");
    print("revieworder ---------- $revieworder ");
    if ((itemCancelled && revieworder != null && revieworder.length == 1) ||
        !itemCancelled) {
      customDialog.dismiss();
//      Navigator.of(context).pop();
      Navigator.of(context).pop({'cancelled_order': orderDetails});
    } else {
      cancelItem(selected);
    }
    // TODO: implement onClick
  }
}
