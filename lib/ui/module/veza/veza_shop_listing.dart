import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/restaurant/restaurant_presenter.dart';
import 'package:sso_futurescape/presentor/module/restaurant/restaurant_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_storedetail.dart';
import 'package:sso_futurescape/ui/module/orders/store_detail_helper.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/searchresults/searchresult.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/request_resto.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/sso/profile/add_new_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/address_list_widget.dart';
import 'package:sso_futurescape/ui/module/sso/profile/select_current_location.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget_search.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/logger.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

enum BusinessAppMode {
  RESTAURANT,
  TIFFIN,
  GROCERY,
  WINESHOP,
  DAILY_ESSENTIALS,
  ORDERTRACKING,
  APP_THEME,
  LISTNOW
}

class VezaShopList extends StatefulWidget {
  final BusinessAppMode businessAppMode;

  VezaShopList({this.businessAppMode}) {
    print("App mode");
    print(businessAppMode);
  }

  @override
  VezaShopListState createState() => VezaShopListState(this.businessAppMode);

  static void list_resto(BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      String con = Environment().getCurrentConfig().account_url;
      var url2 = con +
          "?session_token=$sessionToken&username=$userName&source=cubeone&accountType=business";
      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                //print(Platform.isAndroid);

                return OnlineOrderWebView(
                    /*businessAppMode,
                    "list now"
                    url2);
                    */
                    BusinessAppMode.LISTNOW /* 'resto'*/,
                    "list now",
                    url2,
                    restrodata: null);
              },
            ),
          );
        } else {
          print("1");
          // html.window.open(url2, "Resto");
        }
      } catch (e) {
        print("2");
      }
    });
  }
}

class VezaShopListState extends State<VezaShopList>
    implements RestaurantView, PageLoadSearchListener {
  var _userProfie;
  final TextEditingController _searchControl = new TextEditingController();
  RestaurantPresenter _restaurantPresenter;
  List restaurants;
  bool isLoading = true;
  Map address;
  BusinessAppMode businessAppMode;
  FsListWithSearchState listListner;

  Color appBarColor;

  VezaShopListState(this.businessAppMode);

  /*launchURL() {
    launch('https://flutter.dev');
  }*/
  List addresses;

  @override
  lastPage(int page) {
    print("Last page");
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    // TODO: implement loadNextPage
    isListLoading = true;
    setState(() {});
    getRestoList(page: page);
  }

  @override
  void initState() {
    super.initState();
    _restaurantPresenter = new RestaurantPresenter(this);
    setState(() {});
    SsoStorage.getPreferredAddress().then((address1) {
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        addresses = _userProfie["addresses"];
        addresses = addresses
            .where((element) =>
                element["latitude"] != null && element["latitude"] != "null")
            .toList();
        if (address1 == null) {
          if (addresses != null) {
            if (addresses.length > 0) {
              setAddress(addresses[0]);
            }
          }
          if (address != null) {
            getRestoList();
          }
          hasAtLeastOneAddress();
        } else {
          setAddress(address1);
          getRestoList();
        }
      });
    });
    //MainDashboardState.cart_icon.changeColor(businessAppMode);
  }

  void setAddress(address1) {
    SsoStorage.setPreferredAddress(address1);
    address = address1;
  }

//Order tiffin
  /*void logListWithAgain() {
    //_restaurantPresenter.getRestaurant(isLastRequest: true);
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      _restaurantPresenter.getRestaurant(isLastRequest: true);
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      _restaurantPresenter.getTiffin(
          industry_type: */ /*"Subscription"*/ /* 'food', isLastRequest: true);
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      */ /*_restaurantPresenter.getGrocery();*/ /*
      _restaurantPresenter.getGrocery(isLastRequest: true);
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      _restaurantPresenter.getGrocery(isLastRequest: true);
    } else {
      throw 1 / 0;
    }
  }*/
  bool eventAddedd = false;

  void getRestoList({String searchText, String page = "1"}) {
    if (!eventAddedd && page == "1") {
      FsFacebookUtils.callCartClick(
          'find_location', FsFacebookUtils.getType(businessAppMode));
      if (address['tag'] == null) {
        FsFacebookUtils.callCartClick(
            'use_current_location', FsFacebookUtils.getType(businessAppMode));
      } else {
        FsFacebookUtils.callCartClick(
            'address_click', FsFacebookUtils.getType(businessAppMode));
      }
      eventAddedd = true;
    }
    print("My Search");
    print(searchText);

    if (page == "1") {
      setTitleFalse();
    }
    String industry_type;
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      industry_type = "resto";
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      industry_type = "tiffin";
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      industry_type = "retails";
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      industry_type = "retails";
    } else if (businessAppMode == BusinessAppMode.WINESHOP) {
      industry_type = "wines";
    }

    if (address != null && address["latitude"] != null) {
      _restaurantPresenter.getRestaurant(
          search: searchText,
          industry_type: industry_type,
          lat: address["latitude"],
          long: address["longitude"],
          isPaginationRequired: true,
          page: page);
    } else {
      _restaurantPresenter.getRestaurant(
          search: searchText,
          industry_type: industry_type,
          isLastRequest: true,
          isPaginationRequired: true,
          page: page);
    }
    /*if (businessAppMode == BusinessAppMode.RESTAURANT) {
      if (address != null && address["latitude"] != null) {
        _restaurantPresenter.getRestaurant(
            search: searchText,
            industry_type: "resto",
            lat: address["latitude"],
            long: address["longitude"],
            isPaginationRequired: true,
            page: page);
      } else {
        _restaurantPresenter.getRestaurant(
            search: searchText,
            industry_type: "resto",
            isLastRequest: true,
            isPaginationRequired: true,
            page: page);
      }
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      if (address != null && address["latitude"] != null) {
        _restaurantPresenter.getRestaurant(
            search: searchText,
            industry_type: 'tiffin',
            lat: address["latitude"],
            long: address["longitude"],
            isPaginationRequired: true,
            page: page);
      } else {
        _restaurantPresenter.getRestaurant(
            search: searchText,
            industry_type: 'tiffin',
            isLastRequest: true,
            isPaginationRequired: true,
            page: page);
      }
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      if (address != null && address["latitude"] != null) {
        _restaurantPresenter.getRestaurant(
            search: searchText,
            industry_type: 'retails',
            lat: address["latitude"],
            long: address["longitude"],
            isPaginationRequired: true,
            page: page);
      } else {
        _restaurantPresenter.getRestaurant(
            industry_type: 'retails',
            search: searchText,
            isLastRequest: true,
            isPaginationRequired: true,
            page: page);
      }
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      if (address != null && address["latitude"] != null) {
        _restaurantPresenter.getRestaurant(
            search: searchText,
            industry_type: 'retails',
            lat: address["latitude"],
            long: address["longitude"],
            isPaginationRequired: true,
            page: page);
      } else {
        _restaurantPresenter.getRestaurant(
            search: searchText,
            industry_type: 'retails',
            isLastRequest: true,
            isPaginationRequired: true,
            page: page);
      }
    } else {
      throw 1 / 0;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    MainDashboardState.cart_icon.changeBuniessMOde(businessAppMode);
    return WillPopScope(
      onWillPop: () {
        /*       MainDashboardState.cart_icon
            .changeBuniessMOde(BusinessAppMode.APP_THEME);
 */
        onBackPress(context);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                OnlineOrderWebViewState.backgroundColor(businessAppMode),
            elevation: 0.0,
            leading: FsBackButtonlight(
              backEvent: (context) {
                /*MainDashboardState.cart_icon
                    .changeBuniessMOde(BusinessAppMode.APP_THEME);*/
                /*Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MainDashboard()),
                    (Route<dynamic> route) => false);*/
                onBackPress(context);
              },
            ),
            title: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(0.0),
              child: new FlatButton(
                key: null,
                onPressed: () {
                  locationModalBottomSheet(context);
                  /*if (addresses != null && addresses.length > 0) {
                  locationModalBottomSheet(context);
                } else {
                  selectCurrentLocation(context, isPop: false);
                }*/
                },
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        titlegetter(),
                        style: new TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: FSTextStyle.h5size,
                            color: FsColor.white,
                          ),
                          new Text(
                            StoreDetailHelper.getSubHeader(address),
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
            actions: <Widget>[
              businessAppMode == BusinessAppMode.TIFFIN
                  ? Container()
                  : MainDashboardState.cart_icon,
            ],
          ),
          /*appBar: new AppBar(
          backgroundColor:
              OnlineOrderWebViewState.backgroundColor(businessAppMode),
          elevation: 0.0,
          title: Expanded(
              child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: FlatButton(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        titlegetter(),
                        style: FSTextStyle.appbartextlight,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        */ /* getSubHeader()*/ /*
                        "sdvbsduhvbsadhvbsdvhbasdvisdbvisdhbvsidvbsduivbsdvibsdvusbvisbvsiuvbdvuisbvvhdsbvivbivhbsdvibsdvisdbviusdvvsdv",
                        // "lorem ipsum dolor sit amet is imply dummy text used for typesetting",
                        style: TextStyle(
                          fontSize: FSTextStyle.h7size,
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.white,
                        ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: () {
                locationModalBottomSheet(context);
              },
            ),
          )),
          leading: FsBackButtonlight(),
        ),*/
          body: /*isLoading
            ? PageLoader()
            : */
              Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  address == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: TextField(
                              onTap: businessAppMode == BusinessAppMode.TIFFIN
                                  ? null
                                  : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchResult(
                                                "".trim(),
                                                businessAppMode,
                                                address)));
                              },
                              readOnly:
                              businessAppMode != BusinessAppMode.TIFFIN,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontFamily: 'Gilroy-Regular',
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                hintText: getSearchTitle(businessAppMode),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.blueGrey[300],
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.blueGrey[300],
                                  fontFamily: 'Gilroy-Regular',
                                ),
                              ),
                              maxLines: 1,
                              controller: _searchControl,
                              onChanged:
                              businessAppMode != BusinessAppMode.TIFFIN
                                  ? (text) {
                                //setTitleFalse();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchResult(
                                                text.trim(),
                                                businessAppMode,
                                                address)));
                              }
                                  : null,
                            ),
                          ),
                        ),
                  Expanded(
                    child: FsListWithSearchWidget(
                      pageLoadListner: this,
                      title: false,
                      message: null,
                      itemBuilder: (BuildContext context, int index, var item) {
                        if (index == (metadata["total"] - 1)) {
                          print(metadata["total"] - 1);
                          return Column(
                            children: <Widget>[
                              buildListItem(item, context, index),
                              buildColumnRequestListing(context)
                            ],
                          );
                        } else {
                          return buildListItem(item, context, index);
                        }
                      },
                      afterView: (FsListWithSearchState v) {
                        listListner = v;
                      },
                      showError: false,
                      errorWidget: errorWidget(),
                    ),
                  )
                  /*Expanded(
              child: ListView(
                children: <Widget>[
                  restaurants == null || restaurants.isEmpty
                      ? address == null
                      ? selectLocationUI()
                      : _searchControl.text.isEmpty
                      ? editLocationUI()
                      : FsNoData()
                      : Padding(
                    padding: EdgeInsets.all(12),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                      restaurants == null ? 0 : restaurants.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = restaurants[index];
                        return buildListItem(place, context);
                      },
                    ),
                  ),
                  */ /*Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: Text(
                  "Far from location",
                  // "lorem ipsum long restaurant name comes here",
                  style: TextStyle(
                      fontSize: FSTextStyle.h7size,
                      color: FsColor.basicprimary,
                      fontFamily: 'Gilroy-Regular'),
                  maxLines: 2, textAlign: TextAlign.left,
                ),
              ),
              restaurants == null || restaurants.isEmpty
                  ? FsNoData()
                  : Padding(
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  restaurants == null ? 0 : restaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map place = restaurants[index];
                    return buildListItem(place, context, false);
                  },
                ),
              ),*/ /*

                  address == null
                      ? Container()
                      : Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Text("request listing now",
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.lightgrey,
                            fontFamily: 'Gilroy-SemiBold')),
                  ),
                  address == null
                      ? Container()
                      : Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        child: Text('Click Here',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: OnlineOrderWebViewState.backgroundColor(
                            businessAppMode),
                        textColor: FsColor.white,
                        onPressed: () {
                          requestForDemo(context);

                          */ /*    if (businessAppMode == BusinessAppMode.TIFFIN) {
                            requestForDemo(context);
                          } else {
                            VezaShopList.list_resto(context);
                          }*/ /*
                          */ /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                */ /* */ /*RequestListingPage('Resto', 'business')*/ /* */ /*
                                OnlineOrderWebView("resto", "list now", Environment()
                                    .getCurrentConfig()
                                    .account_url)),
                          );*/ /*
                          //VezaShopList.list_resto(context);
                        },
                      ),
                    ),
                  ),
                  address == null
                      ? Container()
                      : Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        side: BorderSide(
                            color: FsColor.lightgrey.withOpacity(0.2),
                            width: 1.0),
                      ),
                      elevation: 0.0,
                      child: Container(
                        width: double.infinity,
                        padding:
                        EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                    "recommend your favourite place",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.lightgrey,
                                        fontFamily: 'Gilroy-SemiBold'))),
                            GestureDetector(
                              child: RaisedButton(
                                child: Text('Click Now',
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold')),
                                shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(4.0),
                                ),
                                color: OnlineOrderWebViewState
                                    .backgroundColor(businessAppMode),
                                textColor: FsColor.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RequestListingPage(
                                                businessAppMode,
                                                'favourite place')),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )*/
                ],
              ),
              _loader()
            ],
          )),
    );
  }

  void onBackPress(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                MainDashboard(
                  isDirectToNotification: false,
                )),
            (Route<dynamic> route) => false);
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
                        OnlineOrderWebViewState.backgroundColor(
                            businessAppMode)),
                  ))),
            ),
            alignment: FractionalOffset.bottomCenter,
          )
        : new SizedBox(
            width: 0.0,
            height: 0.0,
          );
  }

  Column buildColumnRequestListing(BuildContext context) {
    return Column(
      children: <Widget>[
        address == null
            ? Container()
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Text("request listing now",
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.lightgrey,
                        fontFamily: 'Gilroy-SemiBold')),
              ),
        address == null
            ? Container()
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                child: GestureDetector(
                  child: RaisedButton(
                    child: Text('Click Here',
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold')),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    color: OnlineOrderWebViewState.backgroundColor(
                        businessAppMode),
                    textColor: FsColor.white,
                    onPressed: () {
                      requestForDemo(context);

                      /* if (businessAppMode == BusinessAppMode.TIFFIN) {
                              requestForDemo(context);
                            } else {
                              VezaShopList.list_resto(context);
                            }*/
                      /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RequestListingPage(
                                            'Resto', 'business')
                                    OnlineOrderWebView("resto", "list now",
                                    Environment()
                                        .getCurrentConfig()
                                        .account_url)),);*/
                      //VezaShopList.list_resto(context);
                    },
                  ),
                ),
              ),
        address == null
            ? Container()
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    side: BorderSide(
                        color: FsColor.lightgrey.withOpacity(0.2), width: 1.0),
                  ),
                  elevation: 0.0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Text("recommend your favourite place",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.lightgrey,
                                    fontFamily: 'Gilroy-SemiBold'))),
                        GestureDetector(
                          child: RaisedButton(
                            child: Text('Click Now',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold')),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),
                            ),
                            color: OnlineOrderWebViewState.backgroundColor(
                                businessAppMode),
                            textColor: FsColor.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestListingPage(
                                        businessAppMode, 'favourite place')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  errorWidget() {
    return restaurants == null || restaurants.isEmpty || restaurants.length == 0
        ? (address == null
            ? selectLocationUI()
            : _searchControl.text.isEmpty
                ? editLocationUI()
                : Column(
                    children: <Widget>[
                      FsNoData(),
                      buildColumnRequestListing(context)
                    ],
                  ))
        : Container();
  }

  String getTypeNameFound({int size = 20}) {
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      if (size == 0) {
        return 'No RESTAURANT NEARBY'.toLowerCase();
      } else if (size == 1) {
        return 'NEARBY RESTAURANT'.toLowerCase();
      } else {
        return 'NEARBY RESTAURANTS'.toLowerCase();
      }
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      if (size == 0) {
        return 'No NEARBY meal services'.toLowerCase();
      } else if (size == 1) {
        return 'NEARBY meal services'.toLowerCase();
      } else {
        return 'NEARBY meal services'.toLowerCase();
      }
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS ||
        businessAppMode == BusinessAppMode.GROCERY ||
        businessAppMode == BusinessAppMode.WINESHOP) {
      /*_restaurantPresenter.getGrocery();*/
      if (size == 0) {
        return 'No nearby stores'.toLowerCase();
      } else if (size == 1) {
        return 'nearby store'.toLowerCase();
      } else {
        return 'nearby stores'.toLowerCase();
      }
    }
    /*else if (businessAppMode == BusinessAppMode.GROCERY) {
      return 'STORES NEARBY'.toLowerCase();
    }*/
    else {
      return "search..";
    }
  }

  static String getSearchTitle(BusinessAppMode businessAppMode) {
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      return 'search for food or restaurant'.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      return "search with your homely food".toLowerCase();
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      /*_restaurantPresenter.getGrocery();*/
      // return 'search with your pincode or grocery store name '.toLowerCase();
      return 'search for product or grocery store '.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      // return 'search with your pincode or grocery store name'.toLowerCase();
      return 'search for product or grocery store '.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.WINESHOP) {
      // return 'search with your pincode or grocery store name'.toLowerCase();
      return 'search with your liquor Shops '.toLowerCase();
    } else {
      return "search..";
    }
  }

  String getDefultImage() {
    return AppUtils.getDefultImage(businessAppMode);
  }

  String titlegetter() {
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      return 'Find Restaurants'.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      return 'Find Tiffin Services'.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      /*_restaurantPresenter.getGrocery();*/
      return 'order daily essentials'.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      return 'Find Kirana Stores'.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.WINESHOP) {
      return 'Find Liquor Shops'.toLowerCase();
    } else {
      throw 1 / 0;
    }
  }

  void requestForDemo(BuildContext context) {
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RequestListingPage(businessAppMode, 'business')),
      );
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RequestListingPage(businessAppMode, 'business')),
      );
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RequestListingPage(businessAppMode, 'business')),
      );
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RequestListingPage(businessAppMode, 'business')),
      );
    } else if (businessAppMode == BusinessAppMode.WINESHOP) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RequestListingPage(businessAppMode, 'business')),
      );
    }
  }

/*/*locality: Thane, zipcode: 400703, city: Navi Mumbai*/*/

  bool isTitleForEnable = false;
  bool isTitleForDisable = false;

  Padding buildListItem(Map place, BuildContext context, int index) {
    if (index == 0) {
      isTitleForEnable = false;
    } else {
      isTitleForEnable = true;
    }
    List list = metadata["sub_total"];
    int count = 0;
    try {
      Map a = list.firstWhere((element) => element["in_range"] == "1");
      count = a["count"];
    } catch (e) {}
    if (index == count) {
      isTitleForDisable = false;
    } else {
      isTitleForDisable = true;
    }

    bool enable = true;
    //print("place in_range");
    var range_count = place["in_range"];
    if (range_count != null && range_count == "0") {
      enable = false;
    }
    var length2 = 0;
    //print(metadata);
    List sub_total = metadata["sub_total"];
    // print(sub_total);
    if (sub_total != null) {
      for (int i = 0; i < sub_total.length; i++) {
        var s = sub_total[i];
        if (s["in_range"] == "1") {
          length2 = s["count"];
          break;
        }
      }
    }
    String distance = getLocationDistance(place);
    var cuisine = place['cuisine'];
    Widget wight = Padding(
        padding: EdgeInsets.all(12),
        //padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                isTitleForEnable || length2 == 0
                    ? Container()
                    : Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: Text(
                          restaurants == null ||
                                  restaurants.isEmpty ||
                                  length2 == 0
                              ? " ${getTypeNameFound(size: 0)}"
                              : "${length2} " +
                                  "${getTypeNameFound(size: length2)}",
                          // "lorem ipsum long restaurant name comes here",
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.basicprimary,
                              fontFamily: 'Gilroy-Regular'),
                          maxLines: 2, textAlign: TextAlign.left,
                        ),
                      ),
                isTitleForDisable || enable
                    ? Container()
                    : Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: Text(
                          "currently not delivering to your location."
                              .toLowerCase(),
                          // "lorem ipsum long restaurant name comes here",
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.basicprimary,
                              fontFamily: 'Gilroy-Regular'),
                          maxLines: 2, textAlign: TextAlign.left,
                        ),
                      ),
                InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: !enable
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.white,
                            border:
                                Border.all(width: 1, color: FsColor.lightgrey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Container(
                                /*decoration: BoxDecoration(
                                  color: !enable
                                      ? Colors.grey.withOpacity(0.5)
                                      : Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          FsColor.lightgrey.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(4),
                                ),*/
                                child: getRestoImage(place) == null
                                    ? ClipRRect(
                                        // borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          getDefultImage(),
                                          height: 75,
                                          width: 75,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : !enable
                                        ? ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                FsColor.darkgrey
                                                    .withOpacity(0.3),
                                                BlendMode.dstATop),
                                            child: FadeInImage(
                                                image: NetworkImage(
                                                    getRestoImage(place)),
                                                placeholder: AssetImage(
                                                    getDefultImage()),
                                                height: 75,
                                                width: 75,
                                                fit: BoxFit.cover),
                                          )
                                        : FadeInImage(
                                            image: NetworkImage(
                                                getRestoImage(place)),
                                            placeholder:
                                                AssetImage(getDefultImage()),
                                            height: 75,
                                            width: 75,
                                            fit: BoxFit.cover),
                              ),
                              AppUtils.getViewMenuOrderOnlineStatus(
                                          place, address) &&
                                      enable
                                  ? Container(
                                      width: 75,
                                      color: FsColor.primarygrocery,
                                      child: Text(
                                        'Online'.toLowerCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h7size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.white),
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
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${AppUtils.capitalize(getBrandCompanyName(place))}",
                                    // "lorem ipsum long restaurant name comes here",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.basicprimary,
                                        fontFamily: 'Gilroy-SemiBold'),
                                    maxLines: 2, textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 5),
                                cuisine != null
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          cuisine,
                                          style: TextStyle(
                                            fontSize: FSTextStyle.h7size,
                                            color: FsColor.brown,
                                            fontFamily: 'Gilroy-SemiBold',
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    : Container(),
                                SizedBox(height: 4),
                                getLocation(place) == null
                                    ? Container()
                                    : Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: FSTextStyle.h7size,
                                            color: FsColor.lightgrey,
                                          ),
                                          SizedBox(width: 2),
                                          distance != null
                                              ? Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${distance}",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-SemiBold',
                                                        fontSize:
                                                            FSTextStyle.h7size,
                                                        color:
                                                            FsColor.lightgrey,
                                                      ),
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    SizedBox(width: 2),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy-SemiBold',
                                                        fontSize:
                                                            FSTextStyle.h7size,
                                                        color:
                                                            FsColor.lightgrey,
                                                      ),
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    SizedBox(width: 2),
                                                  ],
                                                )
                                              : Container(),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${getLocation(place)}",
                                              style: TextStyle(
                                                fontFamily: 'Gilroy-SemiBold',
                                                fontSize: FSTextStyle.h7size,
                                                color: FsColor.lightgrey,
                                              ),
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                            ),
                                          )),
                                        ],
                                      ),

                                /* getLocationDistance(place) == null
                                  ? Container()
                                  : Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: FSTextStyle.h7size,
                                          color: FsColor.lightgrey,
                                        ),
                                        SizedBox(width: 2),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${getLocationDistance(place)}",
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-SemiBold',
                                              fontSize: FSTextStyle.h7size,
                                              color: FsColor.lightgrey,
                                            ),
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                          ),
                                        )),
                                      ],
                                    ),*/
                                SizedBox(height: 4),
                                businessAppMode == BusinessAppMode.GROCERY ||
                                        businessAppMode ==
                                            BusinessAppMode.DAILY_ESSENTIALS ||
                                        businessAppMode ==
                                            BusinessAppMode.WINESHOP
                                    ? Container(
                                        child: Row(
                                          children: <Widget>[
                                            /*place['min_delivery_time'] != null
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    place['min_delivery_time']
                                                            .toString() +
                                                        ' min'.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h7size,
                                                      color: FsColor.lightgrey,
                                                      fontFamily:
                                                          'Gilroy-Regular',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                )
                                              : Container(),
                                          place['min_delivery_time'] != null
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    " | ",
                                                    style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h7size,
                                                      color: FsColor.lightgrey,
                                                      fontFamily:
                                                          'Gilroy-Regular',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                )
                                              : Container(),*/
                                            getViewMenuOrderOnline(
                                                place, enable)
                                          ],
                                        ),
                                      )
                                    : Row(
                                        children: <Widget>[
                                          place['cost_for_two'] != null
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Rs.' +
                                                        place['cost_for_two']
                                                            .toString() +
                                                        ' for two'.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h7size,
                                                      color: FsColor.brown,
                                                      fontFamily:
                                                          'Gilroy-Regular',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                )
                                              : Container(),
                                          place['min_delivery_time'] != null &&
                                                  place['cost_for_two'] != null
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    " | ",
                                                    style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h7size,
                                                      color: FsColor.brown,
                                                      fontFamily:
                                                          'Gilroy-Regular',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                )
                                              : Container(),
                                          place['min_delivery_time'] != null
                                              ? Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    place['min_delivery_time']
                                                            .toString() +
                                                        ' min'.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h7size,
                                                      color: FsColor.brown,
                                                      fontFamily:
                                                          'Gilroy-Regular',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                businessAppMode == BusinessAppMode.GROCERY ||
                                        businessAppMode ==
                                            BusinessAppMode.DAILY_ESSENTIALS ||
                                        businessAppMode ==
                                            BusinessAppMode.WINESHOP
                                    ? Container()
                                    : getViewMenuOrderOnline(place, enable),
                                AppUtils.isDeliveryOpionAvaile(
                                            place, "delivery") &&
                                        enable
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text('home delivery available',
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.green)),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),

//                        AppUtils.getCallNumber(place) != null
//                            ? Container(
//                          height: 55.0,
//                          width: 55.0,
//                          alignment: Alignment.center,
//                          child: GestureDetector(
//                            child: RaisedButton(
//                              elevation: 0,
//                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                              shape: CircleBorder(),
//                              onPressed: enable
//                                  ? () {
//                                if (enable)
//                                  callIntent(context, place);
//                                /*setTitleFalse();
//                                    setState(() {});*/
//                              }
//                                  : null,
//                              color: enable ? FsColor.green : Colors.grey,
//                              child: Icon(FlutterIcon.phone_1,
//                                  color: FsColor.white,
//                                  size: FSTextStyle.h5size),
//                            ),
//                          ),
//                        )
//                            : Container(),
                      ],
                    ),
                    onTap:
                        /*(enable &&
                      getViewMenuOrderOnlineStatus(place, enable)) ||
                      (AppUtils.getCallNumber(place) != null && enable) ||
                      (businessAppMode == BusinessAppMode.TIFFIN && enable)
                      ? () {
                    (enable &&
                        getViewMenuOrderOnlineStatus(place, enable) ||
                        (businessAppMode == BusinessAppMode.TIFFIN && enable))
                        ? openRestaurants(place, context)
                        : (AppUtils.getCallNumber(place) != null &&
                        enable)
                        ? callIntent(context, place)
                        : null;
                  } : null,*/
                        enable
                            ? () {
                                openRestaurants(place, context);
                              }
                            : null),
              ],
            )
          ],
        ));
    /*if (enable) {
      isTitleForEnable = true;
    } else {
      isTitleForDisable = true;
    }
    if (length2 == 0) {
      isTitleForEnable = true;
      isTitleForDisable = true;
    }*/
    return wight;
  }

  static Future<void> callIntent(BuildContext context, Map place) async {
    List number = AppUtils.getCallNumber(place);
    if (number.length == 1) {
      var number2 = number[0];
      String url = "tel:${number2}";
      if (await AppUtils.canLaunchUrl(url)) {
        await AppUtils.launchUrl(url);
      } else {
        Toasly.error(context, 'calling not supported.');
      }
    } else {
      Toasly.error(context, 'Could not launch $number');
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
        print(false);

        return false;
      }
    }
  }

  void openRestaurants(Map place, BuildContext context) {
    if (businessAppMode == BusinessAppMode.RESTAURANT ||
        businessAppMode == BusinessAppMode.GROCERY ||
        businessAppMode == BusinessAppMode.WINESHOP ||
        businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      /*if (place["is_wizard_setup"] == null ||
          place["is_wizard_setup"].toString() == 'no') {
        return;
      }
      if (place['online_ordering_enabled'].toString() != null &&
          place['online_ordering_enabled'] == 'yes') {
        if (businessAppMode == BusinessAppMode.RESTAURANT) {
          resto_click(place, context);
        } else {
          grocery_click(place, context);
        }
      } else {
        if (place['LISTING_VIEWMENU_ENABLED'].toString() != null &&
            place['LISTING_VIEWMENU_ENABLED'] == 'yes') {
          if (businessAppMode == BusinessAppMode.RESTAURANT) {
            resto_click(place, context);
          } else {
            grocery_click(place, context);
          }
        } // Toasly.error(context, 'Currently not accepting order from CubeOne App portal!');
      }*/
      SsoStorage.getUserProfile().then((profile) {
        var resto_any_details = place['company_id'].toString();
        var userName = profile['username'];
        var sessionToken = profile['session_token'];
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              print(Platform.isAndroid);
              return GroceryStoreDetails(businessAppMode, place, address);
            },
          ),
        );
      });
      return;
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      _restaurantPresenter.getRestaurantURL(
          getBrandCompanyName(place), place['company_id'].toString());
    }
    /*else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      if (place['pos_enabled'].toString() != null ||
          place['pos_enabled'] == 'yes') {
        grocery_click(place, context);
      } else {
        Toasly.error(
            context, 'Currently not accepting order from CubeOne App portal!');
      }
    }*/
    /*else if (businessAppMode == BusinessAppMode.GROCERY) {
      if (place['pos_enabled'].toString() != null ||
          place['pos_enabled'] == 'yes') {
        grocery_click(place, context);
      } else {
        Toasly.error(
            context, 'Currently not accepting order from CubeOne App portal!');
      }
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      if (place['pos_enabled'].toString() != null ||
          place['pos_enabled'] == 'yes') {
        grocery_click(place, context);
      } else {
        Toasly.error(
            context, 'Currently not accepting order from CubeOne App portal!');
      }
    }*/
  }

  String getBrandCompanyName(Map place) {
    // print(place);
    String company_name;
    if (place['brand_name'] == null || place['brand_name'].toString().isEmpty) {
      company_name = place['company_name'];
    } else {
      company_name = place['brand_name'];
    }
    return company_name;
  }

  String getLocation(Map place) {
    if (place['locality'] == null ||
        place['locality']
            .toString()
            .trim()
            .isEmpty) {
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
          place['city']
              .toString()
              .trim()
              .isNotEmpty &&
          place['locality']
              .toString()
              .trim()
              .isNotEmpty) {
        return AppUtils.capitalize(place['locality'],
            requiredNextAllLowerCase: false) +
            ", " +
            AppUtils.capitalize(place['city'], requiredNextAllLowerCase: true);
      } else {
        return null;
      }
    }
  }

  String getRestoImage(Map place) {
    return AppUtils.getCompanyImage(place);
  }

  @override
  clearList() {
    if (restaurants != null) restaurants.clear();
  }

  @override
  onError(error) async {
    setFalseLoading();
    isListLoading = false;
    setState(() {});
    print(error);
    var result = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    if (result != null && result["connection"]) {
      getRestoList();
    }
    //Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  onFailure(failure) {
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {
      setFalseLoading();
      isListLoading = false;
      if (restaurants != null) {
        restaurants.clear();
      }
    });
  }

  var metadata;

  @override
  onRestaurantFound(success, {bool isLastRequest}) {
    print("onRestaurantFound");
    isListLoading = false;
    if (success["data"]["metadata"]["current_page"] == 1) {
      try {
        restaurants.clear();
        listListner.setErrorWidget(errorWidget());
        listListner.addListList(null, null);
      } catch (e) {}
      setTitleFalse();
    } else if (restaurants == null || restaurants.length == 0) {
      setTitleFalse();
    }
    print("onRestaurantFound");
    print(success);
    if (restaurants == null || restaurants.length == 0) {
      restaurants = success["data"]["results"];
    } else {
      restaurants.addAll(success["data"]["results"]);
    }
    print(restaurants);
    listListner.addListList(
        metadata = success["data"]["metadata"], success["data"]["results"]);
    /*if (isLastRequest != true &&
        (restaurants == null || restaurants.length == 0)) {
      logListWithAgain();
    } else {
      setState(() {
        isLoading = false;
      });
    }*/
    //setTitleFalse();
    setState(() {
      setFalseLoading();
      isListLoading = false;
    });
  }

  searchRestaurant(String text) {
    Logger.log("Change Text --" + text);
    //setTitleFalse();

    restaurants.clear();
    //  print(errorWidget());
    listListner.setErrorWidget(errorWidget());
    listListner.addListList(null, null);
    getRestoList(searchText: text);

    /*if(address!=null&&address[]){
      _restaurantPresenter.getRestaurant(search: text);
    }else {
      _restaurantPresenter.getRestaurant(search: text);
    }*/
  }

  @override
  onRestaurantURLFound(restaurant, {String company_name}) {
    // setTitleFalse();
    if (businessAppMode == BusinessAppMode.TIFFIN) {
      List list = restaurant['data'];
      bool status = false;
      for (var a in list) {
        if (a['product_code'] == 'QUICKSERVE') {
          callTiffinList(company_name, a['ui_end_point']);
          status = true;
          break;
        }
      }
      ;
      if (!status) {
        //Toasly.error(context, "No url found!");
      }
    } else {
      throw FormatException();
    }

    return null;
  }

  bool getMenuForResto(Map place) {
    if (place['online_ordering_enabled'].toString() != null &&
        place['online_ordering_enabled'] == 'yes') {
      return true;
    } else {
      return false;
    }
  }

  void locationModalBottomSheet(context, {cancelable = true}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        isDismissible: cancelable ? false : true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.75,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: FSTextStyle.h5size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.darkgrey,
                        ),
                      ),
                      address == null
                          ? Container(
                              width: 50,
                              height: 40,
                            )
                          : Container(
                              width: 50,
                              child: FlatButton(
                                  onPressed: () {
                                    if (cancelable == false &&
                                        address == null) {
                                      Toasly.warning(
                                          context, "add at least one address");
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Icon(
                                    FlutterIcon.cancel_1,
                                    size: FSTextStyle.h6size,
                                    color: FsColor.basicprimary,
                                  )),
                            ),
                    ],
                  ),
                ),
                true != true
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontFamily: 'Gilroy-Regular',
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "Search for your location....",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.blueGrey[300],
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blueGrey[300],
                                fontFamily: 'Gilroy-Regular',
                              ),
                            ),
                            maxLines: 1,
                            controller: _searchControl,
                            onChanged: (text) {
                              //setTitleFalse();
                              searchRestaurant(text.trim());
                            },
                          ),
                        ),
                      )
                    : Container(),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 1, color: FsColor.lightgrey.withOpacity(0.2)),
                    )),
                    // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    height: 40,
                    child: FlatButton(
                      onPressed: () {
                        selectCurrentLocation(context, isPop: true);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.my_location,
                            size: FSTextStyle.h4size,
                            color: FsColor.primaryvisitor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Use Current Location'.toLowerCase(),
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.primaryvisitor),
                          ),
                        ],
                      ),
                    )),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 1, color: FsColor.lightgrey.withOpacity(0.2)),
                    )),
                    // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    height: 40,
                    child: FlatButton(
                      onPressed: () {
                        addAddress(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: FSTextStyle.h3size,
                            color: FsColor.primaryvisitor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'add address'.toLowerCase(),
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.primaryvisitor),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: <Widget>[
                    AddresList(addresses, _userProfie,
                        onAddressClick: (address1) {
                      isLoading = true;
                      setState(() {
                        setAddress(address1);
                      });
                      if (restaurants != null) {
                        restaurants.clear();
                      }
                      getRestoList();
                      Navigator.pop(context);
                    },
                        /*onDeleteClick: (tag) {
                _restaurantPresenter.deleteAddress(tag);
              },*/
                        noAddressText:
                            "add address to search ${getTypeNameFound()} you"),
                  ],
                )))
              ],
            ),
          );
        });
  }

  Future<void> selectCurrentLocation(BuildContext context,
      {bool isPop = true}) async {
    setFalseLoading();
    isListLoading = false;
    setState(() {});
    var location = new Location();
    var hasPer = await location.hasPermission();
    print("hasPer");
    print(hasPer);
    if (hasPer == PermissionStatus.denied ||
        hasPer == PermissionStatus.deniedForever) {
      setFalseLoading();
      isListLoading = false;
      setState(() {});
      bool a = await PermissionsService1().isForverLocationPermission();
      if (a) {
        PermissionsService1().showDeleteAlertDialog(context);
        return;
      }
      var reqPer = await PermissionsService1().requestLocationPermission();
      if (reqPer) {
        bool a = await location.serviceEnabled();
        if (!a) {
          setFalseLoading();
          isListLoading = false;

          setState(() {});
          bool b = await location.requestService();
          print("Permission for Location");
          print(b);
          if (b) {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectCurrentLocation(
                      OnlineOrderWebViewState.backgroundColor(
                          businessAppMode))),
            );
            if (result != null && result.containsKey('selection')) {
              setAddress(result['selection']);
              //setTitleFalse();
              listListner.addListList(null, null);
              setState(() {});
              if (isPop) {
                Navigator.pop(context);
              }
              //  setTitleFalse();

              getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
            } else {
              //  setTitleFalse();
              setFalseLoading();
              isListLoading = false;

              setState(() {});
            }
          } else {
            setFalseLoading();
            isListLoading = false;

            setState(() {});
          }
        } else {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectCurrentLocation(
                    OnlineOrderWebViewState.backgroundColor(businessAppMode))),
          );
          if (result != null && result.containsKey('selection')) {
            setAddress(result['selection']);
            //setTitleFalse();
            setState(() {});
            if (isPop) {
              Navigator.pop(context);
            }
            //setTitleFalse();
            getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
          } else {
            // setTitleFalse();
            setFalseLoading();
            isListLoading = false;

            setState(() {});
          }
        }
      }
      return;
    }
    bool a = await location.serviceEnabled();
    if (!a) {
      setFalseLoading();
      isListLoading = false;

      setState(() {});
      bool b = await location.requestService();
      print("Permission for Location");
      print(b);
      if (b) {
        var result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectCurrentLocation(
                  OnlineOrderWebViewState.backgroundColor(businessAppMode))),
        );
        if (result != null && result.containsKey('selection')) {
          setAddress(result['selection']);
          // setTitleFalse();
          setState(() {});
          if (isPop) {
            Navigator.pop(context);
          }
          // setTitleFalse();
          getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
        } else {
          //setTitleFalse();
          setFalseLoading();
          isListLoading = false;

          setState(() {});
        }
      } else {
        setFalseLoading();
        isListLoading = false;

        setState(() {});
      }
    } else {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectCurrentLocation(
                OnlineOrderWebViewState.backgroundColor(businessAppMode))),
      );
      if (result != null && result.containsKey('selection')) {
        setAddress(result['selection']);
        //setTitleFalse();
        setState(() {});
        if (isPop) {
          Navigator.pop(context);
        }
        // setTitleFalse();
        getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
      } else {
        /*setTitleFalse();
        isLoading = false;
        setState(() {});*/
      }
    }
    /* location.getLocation().then((currentLocation) async {
      if (currentLocation == null) {
        isLoading = false;
        setState(() {});
        return;
      }
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectCurrentLocation(
                OnlineOrderWebViewState.backgroundColor(businessAppMode))),
      );
      if (result != null && result.containsKey('selection')) {
        setAddress(result['selection']);
        isTitleForEnable = false;
        isTitleForDisable = false;
        setState(() {});
        if (isPop) {
          Navigator.pop(context);
        }
        isTitleForEnable = false;
        isTitleForDisable = false;
        getRestoList();

*/ /*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/ /*
      } else {
        isTitleForEnable = false;
        isTitleForDisable = false;
        isLoading = false;
        setState(() {});
      }
    });*/
  }

  void setTitleFalse() {
    isTitleForEnable = false;
    isTitleForDisable = false;
  }

  Future<void> hasAtLeastOneAddress() async {
    await Future.delayed(Duration(seconds: 1));
    if (address == null) {
      setFalseLoading();
      setState(() {});
      /* locationModalBottomSheet(context, cancelable: false);*/
      selectCurrentLocation(context, isPop: false);
    }
  }

  void setFalseLoading() {
    listListner.setErrorWidget(errorWidget());
    isLoading = false;
    listListner.setLoading(isLoading);
  }

  void callTiffinList(String companyName, String url) {
    print(url);
    print("ddddhhhhhhhhhhhhhhh");
    SsoStorage.getUserProfile().then((profile) {
      var user_name = profile['username'];
      var session_token = profile['session_token'];
      //var url2 = "http://stage.sellmore.co.in/callback?
      // sessi  on_token=$session_token&
      // username=$user_name&
      // method=sess";
      var url2 =
          "$url/callback?session_token=$session_token&username=$user_name&method=sess&source=cubeone&lat=${address['latitude']}&long=${address['longitude']}";
      try {
        print(url2);
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                print(Platform.isAndroid);
                return OnlineOrderWebView(
                    /*'tiffin'*/
                    BusinessAppMode.TIFFIN,
                    companyName,
                    url2);
              },
            ),
          );
        } else {
          print("1");
          // html.window.open(url2, "Resto");
        }
      } catch (e) {
        print("2");
      }
    });
  }

  void resto_click(Map place, BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      print(resto_any_details);
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      String con = Environment().getCurrentConfig().vezaPlugInUrl;
      var url2 = con +
          "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone&lat=${address['latitude']}&long=${address['longitude']}";
      print(url2);
      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return OnlineOrderWebView(
                    BusinessAppMode.RESTAURANT /* 'resto'*/,
                    getBrandCompanyName(place),
                    url2,
                    restrodata: place);
              },
            ),
          );
        } else {
          print("1");
          // html.window.open(url2, "Resto");
        }
      } catch (e) {
        print("2");
      }
    });
  }

  void grocery_click(Map place, BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            print(Platform.isAndroid);
            return GroceryStoreDetails(businessAppMode, place, address);
          },
        ),
      );
      /*var url2;

      if (businessAppMode == BusinessAppMode.GROCERY ||
          businessAppMode == BusinessAppMode.WINESHOP) {
        String con = Environment().getCurrentConfig().vezaGroceryPlugInUrl;
        url2 = con +
            "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone&lat=${address['latitude']}&long=${address['longitude']}";
      } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
        String con = Environment().getCurrentConfig().subscriptionPlugInUrl;
        url2 = con +
            "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone&lat=${address['latitude']}&long=${address['longitude']}";
      }
      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                print(Platform.isAndroid);
                return OnlineOrderWebView(businessAppMode */ /*'grocery'*/ /*,
                    getBrandCompanyName(place), url2);
              },
            ),
          );
        } else {
          print("1");
          // html.window.open(url2, "Resto");
        }
      } catch (e) {
        print("2");
      }*/
    });
  }

  @override
  addressDeleted(success) {
    Toasly.success(context, success["message"].toString());
    ProfileUtil.loadNewProfile((msg) {
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        address = null;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            setAddress(addresses[addresses.length - 1]);
          }
          setState(() {});
          getRestoList();
        }
      });
      Navigator.pop(context);
    }, (error) {
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        address = null;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            setAddress(addresses[addresses.length - 1]);
          }
          setState(() {});
          getRestoList();
        }
      });
    });
  }

  @override
  addressDeletionFailed(failed) {
    Toasly.error(context, AppUtils.errorDecoder(failed));
    setState(() {});
  }

  selectLocationUI() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please pick location to search ${getTypeNameFound()}  you'
                  .toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  letterSpacing: 1.0,
                  height: 1.5,
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey),
            ),
            new Location().hasPermission() != PermissionStatus.deniedForever
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        child: Text('Pick Location',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: OnlineOrderWebViewState.backgroundColor(
                            businessAppMode),
                        textColor: FsColor.white,
                        onPressed: () {
                          selectCurrentLocation(context, isPop: false);
                        },
                      ),
                    ),
                  )
                : Container(),
            new Location().hasPermission() == PermissionStatus.deniedForever
                ? Container(
                    child: Text(
                      'Note: Looks like Location permission for cubeone app is dined forever \n please flow instruction and change setting \n Go to Phone Setting -> Appl Setting -> Select One App -> Click on Permission Section ->Allow Location Permission '
                          .toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          letterSpacing: 1.0,
                          height: 1.5,
                          fontSize: FSTextStyle.h5size,
                          color: FsColor.darkgrey),
                    ),
                  )
                : Container()
          ],
        ));
  }

  editLocationUI() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
/*
             Image.asset('images/empty-list.png',
               fit: BoxFit.contain,
               width: 150.0, height: 150.0,
             ),
*/
            Text(
              "WE ARE REACHING THIS LOCATION SOON!\nWould you prefer trying a different location until then?"
                  .toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  letterSpacing: 1.0,
                  height: 1.5,
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey),
            ),
            new Location().hasPermission() != PermissionStatus.deniedForever
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        child: Text('Edit Location',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: OnlineOrderWebViewState.backgroundColor(
                            businessAppMode),
                        textColor: FsColor.white,
                        onPressed: () {
                          locationModalBottomSheet(context);
                          //selectCurrentLocation(context, isPop: false);
                        },
                      ),
                    ),
                  )
                : Container(),
            buildColumnRequestListing(context),
          ],
        ));
  }

  Future<void> addAddress(BuildContext context) async {
    var location = new Location();
    var hasPer = await location.hasPermission();
    print("hasPer");
    print(hasPer);
    if (hasPer == PermissionStatus.denied ||
        hasPer == PermissionStatus.deniedForever) {
      //Toasly.error(context, "Location permission is denied for forever \n Please enable location from settings!");
      /* print("hasPer");
      print(hasPer);*/
      setFalseLoading();
      isListLoading = false;
      setState(() {});
      bool a = await PermissionsService1().isForverLocationPermission();
      if (a) {
        /*Toasly.error(context,
            "Sorry. We are unable to proceed further as access to detect your location is denied.");*/
        PermissionsService1().showDeleteAlertDialog(context);
        return;
      }
      var reqPer = await PermissionsService1().requestLocationPermission();
      if (reqPer /* == PermissionStatus.granted*/) {
        bool a = await location.serviceEnabled();
        if (!a) {
          setFalseLoading();
          isListLoading = false;

          setState(() {});
          bool b = await location.requestService();
          print("Permission for Location");
          print(b);
          if (b) {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddNewAddress(_userProfie["addresses"])),
            );
            if (result != null) {
              SsoStorage.getUserProfile().then((onValue) {
                _userProfie = onValue;
                if (_userProfie["addresses"] != null) {
                  addresses = _userProfie["addresses"]
                      .where((element) =>
                          element["latitude"] != null &&
                          element["latitude"] != "null")
                      .toList();
                  if (addresses.length > 0) {
                    setAddress(addresses[addresses.length - 1]);
                  }

                  setState(() {});
                  Navigator.pop(context);
                  getRestoList();
                }
              });
            }
          }
        }
      }
    } else {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNewAddress(_userProfie["addresses"])),
      );
      if (result != null) {
        SsoStorage.getUserProfile().then((onValue) {
          _userProfie = onValue;
          if (_userProfie["addresses"] != null) {
            addresses = _userProfie["addresses"]
                .where((element) =>
                    element["latitude"] != null &&
                    element["latitude"] != "null")
                .toList();
            if (addresses.length > 0) {
              setAddress(addresses[addresses.length - 1]);
            }

            setState(() {});
            Navigator.pop(context);
            getRestoList();
          }
        });
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
      return null;
    }
  }
}

class ProfileUtil {
  static void loadNewProfile(successCallBack, failedCallback) {
    void success(String response) {
      var profileResponseJson = json.decode(response);
      var profile = profileResponseJson["data"];
      SsoStorage.setUserProfile(profile);
      UserUtils.pushUserData(profile);
      successCallBack(response);
      print("response - " + response);
    }

    void error(String error) {
      failedCallback(error);
      print("error" + error);
    }

    void failure(String failure) {
      print("failure" + failure);
      failedCallback(failure);
    }

    NetworkHandler handler = new NetworkHandler(
        (response) => {success(response)},
        (response) => {failure(response)},
        (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      var access = jsonDecode(token);
      tokensss = access["access_token"];
      print(tokensss);
      HashMap<String, String> param = new HashMap();
      param["access_token"] = tokensss;
      Network network = SSOAPIHandler.getUserProfile(handler, param);
      network.excute();
    }).catchError((e) {
      print(e);
    });
  }
}
