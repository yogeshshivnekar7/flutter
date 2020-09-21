import 'package:common_config/utils/fs_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/utils/storage/restaurnunt_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'cart_orders.dart';

class CartIcon extends StatefulWidget {
  var updateView;

  CartIcon(this.businessAppMode, {this.updateView}) {}

  BusinessAppMode businessAppMode;
  CartIconState a;

  @override
  CartIconState createState() =>
      a = new CartIconState(businessAppMode, updateView: updateView);

  void updateValue() {
    print("dsfdsgdfhgfdghsfghnsfg");
    print(a);
    a.getOldOrder();
  }

  void changeBuniessMOde(BusinessAppMode businessAppMode1) {
    print("dsfdsgdfhgfdghsfghnsfg");
    print(a);
    a.changeColor(businessAppMode = businessAppMode1);
  }
}

class CartIconState extends State<CartIcon>
    with WidgetsBindingObserver
    implements OnlineOrderView {
  CartIconState(this.businessAppMode, {this.updateView});

  BusinessAppMode businessAppMode;
  var onlineOrderPresenter;
  var userProfile;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
    onlineOrderPresenter = new OnlineOrderPresenter(this);
    getOldOrder();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      getOldOrder();
    }
  }

  void getOldOrder() {
    if (userProfile == null) {
      SsoStorage.getUserProfile().then((userProfile) {
        this.userProfile = userProfile;
        getOrders(userProfile);
      });
    } else {
      getOrders(userProfile);
    }
    if (cartList != null) {
      print("Cart List343444");
      cartList.updateOrderList();
    }
  }

  void getOrders(userProfile) {
    onlineOrderPresenter.getAllCartOrders(userProfile, "OldOnline");
  }

  CartOrders cartList;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        IconButton(
          onPressed: () {
            clickOnCount(context, businessAppMode);
          },
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          icon: Icon(
            Icons.shopping_cart,
            color: businessAppMode == BusinessAppMode.APP_THEME
                ? FsColor.basicprimary
                : FsColor.white,
            size: FSTextStyle.h2size,
          ),
        ),
        count == null || count == "0" || count == "null"
            ? Container()
            : new Positioned(
                top: 10.0,
                right: 8.0,
                child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 1,
                  ),
                  child: new Text(
                    '$count',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
      ],
    );
  }

  void clickOnCount(BuildContext context, BusinessAppMode businessAppMode) {
    FsNavigator.push(context, cartList = CartOrders(null, businessAppMode));
  }

  @override
  error(error, {callingType}) {
    // TODO: implement error
    throw UnimplementedError();
  }

  @override
  failure(error, {callingType}) {
    // TODO: implement failure
    throw UnimplementedError();
  }

  String count = "0";
  Function updateView;

  @override
  success(error, {callingType}) {
    GroceryStorage.setGroceryCartProducts(error["items"]);
    if (error['total_items_quantity'] == null) {
      count = "0";
    } else {
      count = error['total_items_quantity'].toString();
    }
    if (widget.updateView != null) {
      widget.updateView();
    }
    setState(() {});
  }

  void changeColor(BusinessAppMode businessAppMode1) {
    businessAppMode = businessAppMode1;
    /*setState(() {

    });*/
  }
}
