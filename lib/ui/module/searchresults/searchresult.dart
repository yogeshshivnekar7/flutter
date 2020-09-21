import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/searchresults/searchresult_presenter.dart';
import 'package:sso_futurescape/presentor/module/searchresults/searchresult_view.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_storedetail.dart';
import 'package:sso_futurescape/ui/module/orders/store_detail_helper.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/restaurnunt_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class SearchResult extends StatefulWidget {
  String searchText;

  BusinessAppMode businessAppMode;
  Map address;

  SearchResult(this.searchText, this.businessAppMode, this.address) {
    // print("Search Results Page");
    // print(this.searchText);
  }

  @override
  _SearchResultState createState() => new _SearchResultState(
      this.searchText, this.businessAppMode, this.address);
}

String searchText;
List searchresultstore = [];
List searchresultprod = [];
// List searchresultstore = [
//   {
//     "name": "Lorem Ipsum Kirana Store", //company_name
//     "img":
//         "https://im.whatshot.in/img/2020/May/fcm-big-bazaar-f-1588569945.jpg", // logo ?
//     "distance": "0.2km",
//     "location": "Seawoods, Navi Mumbai", //address_line_1,address_line_2
//     "homedelivery": "home delivery available", //?
//     "type": "Grocery Store", //business_category
//   },
//   {
//     "name": "Lorem Ipsum Kirana Store",
//     "img":
//         "https://im.whatshot.in/img/2020/May/fcm-big-bazaar-f-1588569945.jpg",
//     "distance": "0.2km",
//     "location": "Seawoods, Navi Mumbai",
//     "homedelivery": "home delivery available",
//     "type": "Grocery Store",
//   },
//   {
//     "name": "Lorem Ipsum Kirana Store",
//     "img":
//         "https://im.whatshot.in/img/2020/May/fcm-big-bazaar-f-1588569945.jpg",
//     "distance": "0.2km",
//     "location": "Seawoods, Navi Mumbai",
//     "homedelivery": "home delivery available",
//     "type": "Grocery Store",
//   },
//   {
//     "name": "Lorem Ipsum Kirana Store",
//     "img":
//         "https://im.whatshot.in/img/2020/May/fcm-big-bazaar-f-1588569945.jpg",
//     "distance": "0.2km",
//     "location": "Seawoods, Navi Mumbai",
//     "homedelivery": "home delivery available",
//     "type": "Grocery Store",
//   },
// ];

// List searchresultprod = [
//   {
//     "name": "Lorem Ipsum Basmati Rice",
//     "img":
//         "https://w0.pngwave.com/png/303/813/kabsa-gunny-sack-rice-bag-bags-png-clip-art.png",
//     "type": "Product",
//     "price": "250",
//   },
//   {
//     "name": "Lorem Ipsum Basmati Rice",
//     "img":
//         "https://w0.pngwave.com/png/303/813/kabsa-gunny-sack-rice-bag-bags-png-clip-art.png",
//     "type": "Product",
//     "price": "250",
//   },
//   {
//     "name": "Lorem Ipsum Basmati Rice",
//     "img":
//         "https://w0.pngwave.com/png/303/813/kabsa-gunny-sack-rice-bag-bags-png-clip-art.png",
//     "type": "Product",
//     "price": "250",
//   },
//   {
//     "name": "Lorem Ipsum Basmati Rice",
//     "img":
//         "https://w0.pngwave.com/png/303/813/kabsa-gunny-sack-rice-bag-bags-png-clip-art.png",
//     "type": "Product",
//     "price": "250",
//   },
//   {
//     "name": "Lorem Ipsum Basmati Rice",
//     "img":
//         "https://w0.pngwave.com/png/303/813/kabsa-gunny-sack-rice-bag-bags-png-clip-art.png",
//     "type": "Product",
//     "price": "250",
//   },
// ];

class _SearchResultState extends ResumableState<SearchResult>
    implements PageLoadListener, SearchResultView {
  var searchText;
  List searchresultstore = [];
  List searchresultprod = [];
  Map address;
  bool isLoading = false;
  BusinessAppMode businessAppMode;
  SearchResultPresenter presenter;
  FsListState listListner;
  final TextEditingController _searchControl = new TextEditingController();
  var cartProducts = [];
  var userProfile;
  var moneyApiData;
  ProgressDialog pr;

  _SearchResultState(this.searchText, this.businessAppMode, this.address);

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

    _searchControl.text = this.searchText;
    SsoStorage.getUserProfile().then((result) {
      userProfile = result;
    });

    presenter = new SearchResultPresenter(this);
    searchresultprod = [];
    searchresultstore = [];
    this.searchText = '';
    MainDashboardState.cart_icon.updateView = updatedView;
    getCartProductsFromStorage();
  }

  Future<void> getCartProductsFromStorage() async {
    if (cartProducts != null) {
      cartProducts.clear();
    }
    var value = await GroceryStorage.getGroceryCartProducts();
    print("my value");
    print(value);
    if (value != null) {
      var cartList = value;
      var cartListDecoded = jsonDecode(cartList);
      if (cartListDecoded != null && cartListDecoded.length > 0) {
        for (int i = 0; i < cartListDecoded.length; i++) {
          for (int j = 0; j < cartListDecoded[i]["value"].length; j++) {
            cartListDecoded[i]["value"][j]["company_id"] =
                cartListDecoded[i]["company_id"];
            cartProducts.add(cartListDecoded[i]["value"][j]);
          }
        }
      }
    }
    setState(() {});
  }

  @override
  void onResume() {
    MainDashboardState.cart_icon.updateValue();
  }

  void updatedView() {
    print("updatedView");
    getCartProductsFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        try {
          MainDashboardState.cart_icon.updateValue();
        } catch (e) {
          print(e);
        }
        Navigator.pop(context, {"result": true});
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          actions: <Widget>[
            businessAppMode == BusinessAppMode.TIFFIN
                ? Container()
                : MainDashboardState.cart_icon
          ],
          title: Container(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              child: new Container(
                //key: null,
                /*onPressed: () {
                  locationModalBottomSheet(context);
                  */ /*if (addresses != null && addresses.length > 0) {
                      locationModalBottomSheet(context);
                    } else {
                      selectCurrentLocation(context, isPop: false);
                    }*/ /*
                }*/
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Search        ".toLowerCase(),
                        style: new TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          new Text(
                            "Order by Nearby first".toLowerCase(),
                            style: new TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w200,
                                fontSize: FSTextStyle.h7size,
                                fontFamily: 'Gilroy-Regular'),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          elevation: 1.0,
          backgroundColor:
              OnlineOrderWebViewState.backgroundColor(businessAppMode),
          leading: FsBackButtonlight(
            backEvent: (context) {
              try {
                MainDashboardState.cart_icon.updateValue();
              } catch (e) {
                print(e);
              }
              Navigator.pop(context, {"result": true});
            },
          ),
        ),
        body: (isLoading)
            ? PageLoader()
            : ListView(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: TextField(
                          autofocus: action == null,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: FsColor.darkgrey,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: OnlineOrderWebViewState.backgroundColor(
                                    businessAppMode),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: VezaShopListState.getSearchTitle(
                                businessAppMode),
                            // prefixIcon: Icon(
                            //   FlutterIcon.shopping_basket,
                            //   color: OnlineOrderWebViewState.backgroundColor(
                            //       businessAppMode)
                            //       .withOpacity(0.3),
                            // ),
                            suffixIcon: (_searchControl.text != "")
                                ? IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _searchControl.text = "";
                                      setState(() {
                                        searchresultstore = [];
                                        searchresultprod = [];
                                      });
                                    },
                                  )
                                : null,
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: OnlineOrderWebViewState.backgroundColor(
                                      businessAppMode)
                                  .withOpacity(0.7),
                            ),
                          ),
                          maxLines: 1,
                          controller: _searchControl,
                          onChanged: (text) {
                            searchText = text;
                            if (searchText == "" ||
                                searchText.trim().length < 2) {
                              setState(() {
                                searchresultstore = [];
                                searchresultprod = [];
                              });
                            } else {
                              _getSearchResults();
                            }
                          }),
                    ),
                  ),
                  ((searchresultstore == null ||
                              searchresultstore.length == 0) &&
                          (searchresultprod == null ||
                              searchresultprod.length == 0))
                      ? _searchControl.text.isNotEmpty
                          ? FsNoData(
                              message:
                                  "Neither any product nor any store found with this name")
                          : FsNoData(message: " ")
                      : Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              searchresultprod == null ||
                                      searchresultprod.length == 0
                                  ? Container()
                                  : Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Products".toLowerCase(),
                                        // "lorem ipsum long restaurant name comes here",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h3size,
                                            color: FsColor.basicprimary,
                                            fontFamily: 'Gilroy-SemiBold'),
                                        maxLines: 2, textAlign: TextAlign.left,
                                      ),
                                    ),
                              ListView.builder(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchresultprod == null
                                    ? 0
                                    : searchresultprod.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map place =
                                      searchresultprod[index]['_source'];
                                  int count = 0;
                                  return (place != null)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 30.0),
                                          child: InkWell(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            FsColor.lightgrey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          child: ClipRRect(
                                                              // borderRadius: BorderRadius.circular(5),
                                                              child: (place["images"] !=
                                                                          null &&
                                                                      place["images"]
                                                                              .length !=
                                                                          0)
                                                                  ? Image
                                                                      .network(
                                                                      "${place["images"][0]}",
                                                                      height:
                                                                          52,
                                                                      width: 52,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image.asset(
                                                                      'assets/images/shopping_basket.png',
                                                                      height:
                                                                          75,
                                                                      width: 75,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ))),
                                                      Container(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            // "Restaurant Name Comes Here",
                                                            (place["product_name"] !=
                                                                    null)
                                                                ? '${place["product_name"]}'
                                                                : "",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    FSTextStyle
                                                                        .h5size,
                                                                color: FsColor
                                                                    .basicprimary,
                                                                fontFamily:
                                                                    'Gilroy-SemiBold'),
                                                            textAlign:
                                                                TextAlign.left,
                                                            softWrap: true,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text('Product',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h6size,
                                                                  fontFamily:
                                                                      'Gilroy-SemiBold',
                                                                  color: FsColor
                                                                      .brown)),
                                                        ),
                                                        SizedBox(height: 2),
                                                        SizedBox(height: 2),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "₹" +
                                                                  ((place["price"] !=
                                                                          null)
                                                                      ? "${place["price"]}"
                                                                          .toLowerCase()
                                                                      : ""),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h6size,
                                                                  fontFamily:
                                                                      'Gilroy-SemiBold',
                                                                  color: FsColor
                                                                      .darkgrey)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                (count = getproductCount(
                                                            cartProducts,
                                                            place)) ==
                                                        0
                                                    ? Container(
                                                        height: 32,
                                                        child: RaisedButton(
                                                            color: OnlineOrderWebViewState
                                                                .backgroundColor(
                                                                    businessAppMode),
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    8, 5, 8, 5),
                                                            // shape: Border.all(width: 1, color: FsColor.darkgrey),
                                                            elevation: 2,
                                                            onPressed: () {
                                                              // StoreDetailHelper
                                                              //     .callOnlineOrderWebviewPage(
                                                              //         context,
                                                              //         place[
                                                              //             "company"],
                                                              //         businessAppMode);

                                                              onAddToCart(place,
                                                                  "plus");
                                                            },
                                                            child: Text(
                                                              'Add',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h6size,
                                                                  fontFamily:
                                                                      'Gilroy-SemiBold',
                                                                  color: FsColor
                                                                      .white),
                                                            )),
                                                      )
                                                    : Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              height: 24,
                                                              width: 24,
                                                              child: FlatButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Icon(
                                                                    FlutterIcon
                                                                        .minus,
                                                                    color: FsColor
                                                                        .primarygrocery,
                                                                    size: FSTextStyle
                                                                        .h6size),
                                                                onPressed: () {
                                                                  onAddToCart(
                                                                      place,
                                                                      "sub");
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              '${count}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h6size,
                                                                  color: FsColor
                                                                      .basicprimary,
                                                                  fontFamily:
                                                                      'Gilroy-SemiBold'),
                                                            ),
                                                            SizedBox(width: 5),
                                                            Container(
                                                              height: 24,
                                                              width: 24,
                                                              child: FlatButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Icon(
                                                                    FlutterIcon
                                                                        .plus,
                                                                    color: FsColor
                                                                        .primarygrocery,
                                                                    size: FSTextStyle
                                                                        .h6size),
                                                                onPressed: () {
                                                                  onAddToCart(
                                                                      place,
                                                                      "plus");
                                                                  ;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            onTap: () {
                                              /*Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                //return GroceryStoreDetails();
                                              },
                                            ),
                                          );*/
                                              StoreDetailHelper
                                                  .callOnlineOrderWebviewPage(
                                                      context,
                                                      place["company"],
                                                      businessAppMode);
                                            },
                                          ),
                                        )
                                      : Container();
                                },
                              ),
                            ],
                          ),
                        ),
                  searchresultstore == null || searchresultstore.length == 0
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              searchresultprod.length == 0
                                  ? Container()
                                  : Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                                      child: Text(
                                        businessAppMode ==
                                                BusinessAppMode.GROCERY
                                            ? "Stores".toLowerCase()
                                            : "restaurants".toLowerCase(),
                                        // "lorem ipsum long restaurant name comes here",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h3size,
                                            color: FsColor.basicprimary,
                                            fontFamily: 'Gilroy-SemiBold'),
                                        maxLines: 2, textAlign: TextAlign.left,
                                      ),
                                    ),
                              ListView.builder(
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchresultstore == null
                                    ? 0
                                    : searchresultstore.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map place = searchresultstore[index];
                                  var deliverytype = AppUtils.getValueFromKey(
                                      "DELIVERY_TYPE", place);
                                  var location = getLocation(place);
                                  var path = AppUtils.getCompanyImage(place);

                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30.0),
                                        child: InkWell(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: FsColor.lightgrey),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                padding: EdgeInsets.all(0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        child: ClipRRect(
                                                      // borderRadius: BorderRadius.circular(5),
                                                      child: (path != null)
                                                          ? Image.network(
                                                              "${path}",
                                                              height: 52,
                                                              width: 52,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.asset(
                                                              AppUtils.getDefultImage(
                                                                  businessAppMode),
                                                              height: 75,
                                                              width: 75,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    )),
                                                    (place['online_ordering_enabled'] ==
                                                            "yes")
                                                        ? Container(
                                                            width: 52,
                                                            color: OnlineOrderWebViewState
                                                                .backgroundColor(
                                                                    businessAppMode),
                                                            child: Text(
                                                              'Online'
                                                                  .toLowerCase(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      FSTextStyle
                                                                          .h7size,
                                                                  fontFamily:
                                                                      'Gilroy-SemiBold',
                                                                  color: FsColor
                                                                      .white),
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          // "Restaurant Name Comes Here",
                                                          (place["company_name"] !=
                                                                  null)
                                                              ? '${place["company_name"]}'
                                                              : "",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  FSTextStyle
                                                                      .h5size,
                                                              color: FsColor
                                                                  .basicprimary,
                                                              fontFamily:
                                                                  'Gilroy-SemiBold'),
                                                          textAlign:
                                                              TextAlign.left,
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            (place["business_category"] !=
                                                                    null)
                                                                ? '${place["business_category"]}'
                                                                : "",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    FSTextStyle
                                                                        .h6size,
                                                                fontFamily:
                                                                    'Gilroy-SemiBold',
                                                                color: FsColor
                                                                    .brown)),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: RichText(
                                                          text: TextSpan(
                                                              children: <
                                                                  InlineSpan>[
                                                                TextSpan(
                                                                  text:
                                                                      '${getLocationDistance(place)}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-SemiBold',
                                                                    fontSize:
                                                                        FSTextStyle
                                                                            .h6size,
                                                                    color: FsColor
                                                                        .lightgrey,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: ' | ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        FSTextStyle
                                                                            .h7size,
                                                                    color: FsColor
                                                                        .darkgrey,
                                                                    letterSpacing:
                                                                        2,
                                                                    fontFamily:
                                                                        'Gilroy-Regular',
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: (location !=
                                                                          null)
                                                                      ? '${location}'
                                                                      : "",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gilroy-SemiBold',
                                                                    fontSize:
                                                                        FSTextStyle
                                                                            .h6size,
                                                                    color: FsColor
                                                                        .lightgrey,
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      businessAppMode ==
                                                                  BusinessAppMode
                                                                      .GROCERY ||
                                                              businessAppMode ==
                                                                  BusinessAppMode
                                                                      .DAILY_ESSENTIALS ||
                                                              businessAppMode ==
                                                                  BusinessAppMode
                                                                      .WINESHOP
                                                          ? Container(
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  getViewMenuOrderOnline(
                                                                      place,
                                                                      true)
                                                                ],
                                                              ),
                                                            )
                                                          : Row(
                                                              children: <
                                                                  Widget>[
                                                                place['cost_for_two'] !=
                                                                        null
                                                                    ? Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          'Rs.' +
                                                                              place['cost_for_two'].toString() +
                                                                              ' for two'.toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                FSTextStyle.h7size,
                                                                            color:
                                                                                FsColor.brown,
                                                                            fontFamily:
                                                                                'Gilroy-Regular',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                                place['min_delivery_time'] !=
                                                                            null &&
                                                                        place['cost_for_two'] !=
                                                                            null
                                                                    ? Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          " | ",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                FSTextStyle.h7size,
                                                                            color:
                                                                                FsColor.brown,
                                                                            fontFamily:
                                                                                'Gilroy-Regular',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                                place['min_delivery_time'] !=
                                                                        null
                                                                    ? Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          place['min_delivery_time'].toString() +
                                                                              ' min'.toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                FSTextStyle.h7size,
                                                                            color:
                                                                                FsColor.brown,
                                                                            fontFamily:
                                                                                'Gilroy-Regular',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                      businessAppMode ==
                                                                  BusinessAppMode
                                                                      .GROCERY ||
                                                              businessAppMode ==
                                                                  BusinessAppMode
                                                                      .DAILY_ESSENTIALS ||
                                                              businessAppMode ==
                                                                  BusinessAppMode
                                                                      .WINESHOP
                                                          ? Container()
                                                          : getViewMenuOrderOnline(
                                                              place, true),
                                                      AppUtils.isDeliveryOpionAvaile(
                                                                  place,
                                                                  "delivery") &&
                                                              true
                                                          ? Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  'home delivery available',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          FSTextStyle
                                                                              .h6size,
                                                                      fontFamily:
                                                                          'Gilroy-SemiBold',
                                                                      color: FsColor
                                                                          .green)),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  //return GroceryStoreDetails();
                                                  return GroceryStoreDetails(
                                                      businessAppMode,
                                                      null,
                                                      address,
                                                      compnay_id:
                                                          place["company_id"]
                                                              .toString());
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                ],
              ),
      ),
    );
  }

  String getLocation(Map place) {
    if (place['locality'] == null ||
        place['locality'].toString().trim().isEmpty) {
      if (place['city'] != null && place['state'] != null) {
        return AppUtils.capitalize(place['city'],
                requiredNextAllLowerCase: false) +
            ", " +
            AppUtils.capitalize(place['state'], requiredNextAllLowerCase: true);
      } else {
        return null;
      }
    } else {
      if (place['city'] != null &&
          place['locality'] != null &&
          place['city'].toString().trim().isNotEmpty &&
          place['locality'].toString().trim().isNotEmpty) {
        return AppUtils.capitalize(place['locality'],
                requiredNextAllLowerCase: false) +
            ", " +
            AppUtils.capitalize(place['city'], requiredNextAllLowerCase: true);
      } else {
        return null;
      }
    }
  }

  Container getViewMenuOrderOnline(Map place, bool enable) {
    if (place["is_wizard_setup"] == null ||
        place["is_wizard_setup"].toString() == 'no') {
      return Container(
          alignment: Alignment.topLeft,
          child: businessAppMode != BusinessAppMode.TIFFIN &&
                  AppUtils.getCallNumber(place) != null
              ? /*Text('Call now to place orders.'.toLowerCase(),
                  style: TextStyle(
                      fontSize: FSTextStyle.h7size,
                      fontFamily: 'Gilroy-SemiBold',
                      color: enable ? FsColor.green : Colors.grey)*/
              Container()
              : Container());
    }
    if (place['online_ordering_enabled'].toString() != null &&
        place['online_ordering_enabled'] == 'yes' &&
        enable) {
      return Container(
          /*alignment: Alignment.centerLeft,
          child: Text('Order Now'.toLowerCase(),
              style: TextStyle(
                  fontSize: FSTextStyle.h7size,
                  fontFamily: 'Gilroy-SemiBold',
                  color: enable
                      ? OnlineOrderWebViewState.backgroundColor(businessAppMode)
                      : Colors.grey))*/
          );
    } else {
      if (place['LISTING_VIEWMENU_ENABLED'].toString() != null &&
          place['LISTING_VIEWMENU_ENABLED'] == 'yes' &&
          enable) {
        return Container(
            /*alignment: Alignment.centerLeft,
            child: Text('View Menu'.toLowerCase(),
                style: TextStyle(
                    fontSize: FSTextStyle.h7size,
                    fontFamily: 'Gilroy-SemiBold',
                    color: enable
                        ? OnlineOrderWebViewState.backgroundColor(
                            businessAppMode)
                        : Colors.grey))*/
            );
      } else {
        return Container(
            alignment: Alignment.topLeft,
            child: businessAppMode != BusinessAppMode.TIFFIN &&
                    AppUtils.getCallNumber(place) != null
                ? /*Text('Call now to place orders.'.toLowerCase(),
                    style: TextStyle(
                        fontSize: FSTextStyle.h7size,
                        fontFamily: 'Gilroy-SemiBold',
                        color: enable ? FsColor.green : Colors.grey))*/
                Container()
                : Container());
        ;
      }
      ;
    }
  }

  bool getViewMenuOrderOnlineStatus(Map place, bool enable) {
    if (place["is_wizard_setup"] == null ||
        place["is_wizard_setup"].toString() == 'no') {
      //  print(false);
      return false;
    }
    if (place['online_ordering_enabled'].toString() != null &&
        place['online_ordering_enabled'] == 'yes' &&
        enable) {
      //  print(true);
      return true;
    } else {
      if (place['LISTING_VIEWMENU_ENABLED'].toString() != null &&
          place['LISTING_VIEWMENU_ENABLED'] == 'yes' &&
          enable) {
        // print(true);

        return true;
      } else {
        // print(false);

        return false;
      }
    }
  }

  String getLocationDistance(Map place) {
    if (place["distance"] != null) {
      var dis = place["distance"];
      if (dis >= 1) {
        if (dis == 1) {
          return dis.toStringAsFixed(1) + " km";
        } else {
          return dis.toStringAsFixed(1) + " km";
        }
      } else {
        return (dis).toStringAsFixed(1) + " km";
      }
    } else {
      return " ";
    }
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    // TODO: implement loadNextPage
    _getSearchResults(page: page);
  }

  @override
  error(error) {
    print(error);
    isLoading = false;
    setState(() {});
  }

  @override
  failure(failed) {
    print(failed);
    isLoading = false;
    setState(() {});
  }

  @override
  success(success) {
    searchresultstore = success['companies'];
    if (success['products']['hits']['hits'] != null &&
        (searchText != "" && searchText.trim().length >= 2)) {
      searchresultprod = success['products']['hits']['hits'];
    } else {
      searchresultprod = [];
    }
    if (success['companies'] != null &&
        (searchText != "" && searchText.trim().length >= 2)) {
      searchresultstore = success['companies'];
    } else {
      searchresultstore = [];
    }
    //  print(searchresultprod);
    // print(searchresultstore);
    isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    MainDashboardState.cart_icon.updateView = null;
  }

  void _getSearchResults({page}) {
    try {
      //print("in presenter");
      //isLoading = true;
      presenter.getSearchResults(searchText, businessAppMode, address,
          page: page);
    } catch (e) {
      print(e);
    }
  }

  String action;

  void onAddToCart(place, String action) {
    /* try{
      my_cart_wight.setUdatedView(updatedView);
    }catch(e){
      print(e);
    }*/
    this.action = action;
    pr.show();

    List products = getcartProducts(place, action);

    print("products legnth ${products.length}");
    /* List getCurrentCompanyProducts = List();
    for (int i = 0; i < products.length; i++) {
      print("${products[i]['company_id']} = ${place['company_id']}");
      if (products[i]['company_id'].toString() ==
          place['company_id'].toString()) {
        getCurrentCompanyProducts.add(products[i]);
        print("products[i]" + products[i]);
      }
    }*/
    List getCurrentCompanyProducts = products
        .where(
            (f) => f['company_id'].toString() == place['company_id'].toString())
        .toList();
    print("getCurrentCompanyProducts");
    print(
        "getCurrentCompanyProducts legnth ${getCurrentCompanyProducts.length}");
    // getCurrentCompanyProducts.forEach((value) => print(value));
    // print(getCurrentCompanyProducts);
    presenter.addProductToCart(
        cartProducts: getCurrentCompanyProducts,
        userProfile: userProfile,
        company_id: place['company_id']);
  }

  @override
  addToCartSuccess(success) {
    pr.hide();
    /*if (action == "plus") {
      Toasly.success(context, "Item added to cart.");
    } else {
      Toasly.error(context, "Item remove from cart.");
    }*/
    MainDashboardState.cart_icon.updateValue();
    setState(() {});
    FocusScope.of(context).requestFocus(new FocusNode()); //remove focus
    // MainDashboardState.cart_icon.updateValue();
  }

  mapProductDetails(src) {
    var product = {
      'id': src.containsKey('product_id') ? src['product_id'] : src['item_id'],
      'company_id': src['company_id'],
      'name':
          src.containsKey('product_name') ? src['product_name'] : src['item'],
      'description': src.containsKey('description')
          ? src['description']
          : src['item_description'],
      'price': src['price'],
      'sku': src['sku'],
      'images': src['images'],
      'stock': src['stock'],
      'quantity': src['quantity'],
      'food_type': src['food_type'],
      'product_type': src['product_type'],
      'attribute_sort_order': src['attribute_sort_order'],
      'measure_unit': src['measure_unit'],
      'has_addons': (src['has_addons'] == 'yes') ? true : false,
      'delivery_date': src['delivery_date'],
      'track_inventory': src['track_inventory'],
      'categoryName': src['categoryName'],
      'previousPrice': src['previousPrice'],
      'count': src['count'],
      'tax_method': src['tax_method'],
    };
    return product;
  }

  getcartProducts(product, action) {
    var mappedProduct = mapProductDetails(product);
    print("cartProducts");
    print(cartProducts);
    if (action == "plus") {
      if (cartProducts.length == 0) {
        mappedProduct['count'] = 1;
        cartProducts.add(mappedProduct);
        return cartProducts;
      } else {
        for (var i = 0; i < cartProducts.length; i++) {
          if (cartProducts[i]['id'].toString() ==
                  product['product_id'].toString() &&
              cartProducts[i]['company_id'].toString() ==
                  product['company_id'].toString() &&
              cartProducts[i]['count'] != null) {
            cartProducts[i]['count'] = ++cartProducts[i]['count'];
            cartProducts[i] = cartProducts[i];
            return cartProducts;
          }
        }
        mappedProduct['count'] = 1;
        cartProducts.add(mappedProduct);
        return cartProducts;
      }
    } else {
      if (cartProducts.length == 0) {
        throw Exception();
      } else {
        bool found = true;
        for (var i = 0; i < cartProducts.length; i++) {
          if (cartProducts[i]['id'].toString() ==
                  product['product_id'].toString() &&
              cartProducts[i]['company_id'].toString() ==
                  product['company_id'].toString() &&
              cartProducts[i]['count'] != null) {
            if (cartProducts[i]['count'] == 1) {
              cartProducts.removeAt(i);
            } else {
              cartProducts[i]['count'] = --cartProducts[i]['count'];
            }
            found = true;
            return cartProducts;
          }
        }
      }
    }
  }

  static getproductCount(cartProducts, product) {
    for (var i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i]['id'].toString() ==
              product['product_id'].toString() &&
          cartProducts[i]['company_id'].toString() ==
              product['company_id'].toString() &&
          cartProducts[i]['count'] != null) {
        return cartProducts[i]['count'];
      }
    }
    return 0;
  }
}
