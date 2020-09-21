import 'dart:io';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_storedetail.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/grocery_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/pyna_storedetail.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/recipe_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/restaurant_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/tiffin_card.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'grocery_buyanything.dart';

class StoreDetailHelper {
  BuildContext context;

  StoreDetailHelper(this.context) {}

  Future<void> handleDynamicLink(Map map, String link) async {
    print(map);
    if (map["campaign"] != null) {
      FsFacebookUtils.callCartClick(map["campaign"], link);
    }
    if (map["card"] != null) {
      var string = map["card"].toString();
      if (string == "grocery") {
        GroceryCardState.introGrocery(context);
      } else if (string == "wine") {
        if (MainDashboardState.isWineShow) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PynaStoreDetails(),
            ),
          );
        }
      } else if (string == "recipe") {
        RecipeCardState.introGrocery(context);
      } else if (string == "resto") {
        RestaurantCardState.restaurnatInfo(context);
      } else if (string == "tiffin") {
        TiffinCardState.tifinIntro(context);
      }
    }
    if (map["c_id"] == null) {
      if (map['r_id'] != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              id: map['r_id'],
              type: "notification",
            ),
          ),
        );
      }
      return;
    }
    if (map['s_ty'].toString().toLowerCase() == 'W'.toLowerCase()) {
      if (MainDashboardState.isWineShow) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PynaStoreDetails(),
          ),
        );
      }
    } else {
      BusinessAppMode businessAppMode = BusinessAppMode.GROCERY;
      if (map['s_ty'].toString().toLowerCase() == 'R'.toLowerCase()) {
        businessAppMode = BusinessAppMode.RESTAURANT;
      } else if (map['s_ty'].toString().toLowerCase() == 'T'.toLowerCase()) {
        businessAppMode = BusinessAppMode.TIFFIN;
      } else if (map['s_ty'].toString().toLowerCase() == 'D'.toLowerCase()) {
        businessAppMode = BusinessAppMode.DAILY_ESSENTIALS;
      }
      print(businessAppMode);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroceryStoreDetails(businessAppMode, null, null,
              compnay_id: map['c_id'].toString()),
        ),
      );
    }
  }

  static getSubHeader(Map address) {
    if (address == null) {
      return 'select location';
    } else {
      String addressTitle = "";
      if (!isEmptyORNULL(address["locality"])) {
        if (!isEmptyORNULL(address['address_tag'])) {
          if (address['address_tag'] != address['locality']) {
            return "${address['address_tag']} (${address["locality"]})";
          } else {
            return "${address['address_tag']}";
          }
        } else {
          return "${address["locality"]}";
        }
        /*
        if (!isEmptyORNULL(address["city"])) {
          return "${address['address_tag']} (${address["locality"]} ${address["city"]})";
        } else {
          return "${address['address_tag']} (${address["locality"]})";
        }
        */
      } else {
        if (!isEmptyORNULL(address["city"])) {
          return "${address['address_tag']} (${address["city"]})";
        } else {
          return "${address['address_tag']}";
        }
      }
    }
  }

  static bool isEmptyORNULL(addres) {
    return (addres == null || addres.toString().trim().isEmpty);
  }

  static BusinessAppMode getAccordingToIndustryType(String industryType) {
    if (industryType.contains('retail')) {
      return BusinessAppMode.GROCERY;
    } else if (industryType.contains('food')) {
      return BusinessAppMode.RESTAURANT;
    }
  }

  void termsDialog(
      BuildContext context, BusinessAppMode businessAppMode, Map store_detail,
      {shoeBottom = false}) {
    // flutter defined function
    SsoStorage.getTermsAndCondition().then((value) {
      if (value == "yes") {
        callOnlineOrderPage(context, businessAppMode, store_detail,
            showBottom: shoeBottom);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              scrollable: true,
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              content: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      // color: getColor.withOpacity(0.1),
                      child: Image.asset(
                        'images/terms.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'we are now connecting you to the shop/restaurant!'
                            .toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: FSTextStyle.h5size,
                            color: FsColor.basicprimary,
                            fontFamily: 'Gilroy-Bold'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 24,
                            height: 24,
                            child: Icon(FlutterIcon.right_open,
                                color: getPrimaryColor(businessAppMode),
                                size: FSTextStyle.h6size),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'we only help you to find your nearest shops & restaurants'
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 24,
                            height: 24,
                            child: Icon(FlutterIcon.right_open,
                                color: getPrimaryColor(businessAppMode),
                                size: FSTextStyle.h6size),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'we facilitate direct communication between buyer and seller'
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 24,
                            height: 24,
                            child: Icon(FlutterIcon.right_open,
                                color: getPrimaryColor(businessAppMode),
                                size: FSTextStyle.h6size),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'we do not mediate in any nature of dispute between buyer and seller'
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 24,
                            height: 24,
                            child: Icon(FlutterIcon.right_open,
                                color: getPrimaryColor(businessAppMode),
                                size: FSTextStyle.h6size),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'right delivery of right order is sole responsibility of the shops & restaurants'
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 24,
                            height: 24,
                            child: Icon(FlutterIcon.right,
                                color: getPrimaryColor(businessAppMode),
                                size: FSTextStyle.h6size),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'monetary deals are sole affairs between buyers and sellers'
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: FlatButton(
                          child: Text('Read the T&C for further details',
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.primary)),
                          onPressed: () {
                            _launchURL(
                                'https://www.cubeoneapp.com/term&conditions.php');
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                          child: Text('I Agree',
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold')),
                          onPressed: () {
                            SsoStorage.setTermsAndCondition("yes");
                            Navigator.pop(context);
                            callOnlineOrderPage(
                                context, businessAppMode, store_detail,
                                showBottom: shoeBottom);
                          },
                          color: getPrimaryColor(businessAppMode),
                          textColor: FsColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  static Color getPrimaryColor(BusinessAppMode businessAppMode) {
    return OnlineOrderWebViewState.backgroundColor(businessAppMode);
  }

  Future<void> _launchURL(String url) async {
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  callOnlineOrderPage(
      BuildContext context, BusinessAppMode businessAppMode, Map place,
      {bool showBottom = true}) async {
    var location = new Location();
    var hasPer = await location.hasPermission();
    print("hasPer");
    print(hasPer);
    if (hasPer == PermissionStatus.denied ||
        hasPer == PermissionStatus.deniedForever) {
      //Toasly.error(context, "Location permission is denied for forever \n Please enable location from settings!");
      /* print("hasPer");
      print(hasPer);*/
      bool a = await PermissionsService1().isForverLocationPermission();
      if (a) {
        /*Toasly.error(context,
            "Sorry. We are unable to proceed further as access to detect your location is denied.");*/
        PermissionsService1().showDeleteAlertDialog(context);
        return;
      }
      var reqPer = await PermissionsService1().requestLocationPermission();
      if (reqPer /* == PermissionStatus.granted*/) {
        callOnlineOrderLink(
            businessAppMode, place, showBottom, context, location);
      }
    } else {
      callOnlineOrderLink(
          businessAppMode, place, showBottom, context, location);
    }
  }

  Future<void> callOnlineOrderLink(BusinessAppMode businessAppMode, Map place,
      bool showBottom, BuildContext context, Location location) async {
    bool a = await location.serviceEnabled();
    if (!a) {
      bool b = await location.requestService();
      if (b) {
        if (showBottom) {
          _ordernowBottomSheet(context, businessAppMode, place, showBottom);
          return;
        }
        print(businessAppMode);
        FsFacebookUtils.onlineOrderSubmitEvent(
            businessAppMode, place["company_name"]);
        if (businessAppMode == BusinessAppMode.RESTAURANT) {
          resto_click(place, context);
        } else if (businessAppMode == BusinessAppMode.GROCERY) {
          callOnlineOrderWebviewPage(context, place, businessAppMode);
        } else if (businessAppMode == BusinessAppMode.TIFFIN) {
          callTiffinList(place["company_name"], "");
        }
      }
    } else {
      if (showBottom) {
        _ordernowBottomSheet(context, businessAppMode, place, showBottom);
        return;
      }
      print(businessAppMode);
      FsFacebookUtils.onlineOrderSubmitEvent(
          businessAppMode, place["company_name"]);
      if (businessAppMode == BusinessAppMode.RESTAURANT) {
        resto_click(place, context);
      } else if (businessAppMode == BusinessAppMode.GROCERY) {
        callOnlineOrderWebviewPage(context, place, businessAppMode);
      } else if (businessAppMode == BusinessAppMode.TIFFIN) {
        callTiffinList(place["company_name"], "");
      }
    }
  }

  void _ordernowBottomSheet(BuildContext context,
      BusinessAppMode businessAppMode, Map place, showBottom) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.lightgrey.withOpacity(0.5),
                    ))),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        callOnlineOrderPage(context, businessAppMode, place,
                            showBottom: false);
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Order Online',
                              style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.basicprimary,
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: FsColor.darkgrey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                width: 1.0,
                                color: FsColor.darkgrey.withOpacity(0.5),
                              ),
                            ),
                            child: Icon(FlutterIcon.doc_text,
                                color: FsColor.darkgrey,
                                size: FSTextStyle.h4size),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.lightgrey.withOpacity(0.5),
                    ))),
                    child: FlatButton(
                      onPressed: AppUtils.getCallNumber(place) != null
                          ? () {
                              Navigator.pop(context);
                              callIntent(context, businessAppMode, place);
                            }
                          : null,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Call to Order',
                              style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.basicprimary,
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: FsColor.darkgrey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(
                                width: 1.0,
                                color: FsColor.darkgrey.withOpacity(0.5),
                              ),
                            ),
                            child: Icon(FlutterIcon.phone_1,
                                color: FsColor.darkgrey,
                                size: FSTextStyle.h4size),
                          ),
                        ],
                      ),
                    ),
                  ),
                  true != true && businessAppMode == BusinessAppMode.GROCERY
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 1.0,
                            color: FsColor.lightgrey.withOpacity(0.5),
                          ))),
                          child: FlatButton(
                            onPressed: () {
                              buyAnything(context, businessAppMode, place);
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Buy Anything',
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.basicprimary,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: FsColor.darkgrey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(
                                      width: 1.0,
                                      color: FsColor.darkgrey.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Icon(FlutterIcon.shopping_bag,
                                      color: FsColor.darkgrey,
                                      size: FSTextStyle.h4size),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }

  Future<void> callIntent(
      BuildContext context, BusinessAppMode businessAppMode, Map place) async {
    List number = AppUtils.getCallNumber(place);
    FsFacebookUtils.callSubmitEvent(businessAppMode, place["company_name"]);
    if (number.length == 1) {
      var number2 = number[0];
      String url = "tel:${number2}";
      if (await AppUtils.canLaunchUrl(url)) {
        await AppUtils.launchUrl(url);
        //_sendAnalyticsEvent(place);
      } else {
        Toasly.error(context, 'calling not supported.');
      }
    } else {
      Toasly.error(context, 'Could not launch $number');
    }
  }

  void buyAnything(
      BuildContext context, BusinessAppMode businessAppMode, Map storeDetails) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return GroceryBuyAnything(storeDetails, businessAppMode);
          //return GroceryOrderReview();
        },
      ),
    );
  }

  void resto_click(Map place, BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      print(resto_any_details);
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      String con = Environment().getCurrentConfig().vezaPlugInUrl;
      var url2 = con +
          "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone" +
          getUserLatLong(place);
      print(url2);
      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return OnlineOrderWebView(
                    BusinessAppMode.RESTAURANT /* 'resto'*/,
                    place["company_name"],
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

  static String getUserLatLong(Map place) {
    if (place['user_address'] != null) {
      return "&lat=${place['user_address']['latitude']}&long=${place['user_address']['longitude']}";
    } else {
      return "";
    }
  }

  static void callOnlineOrderWebviewPage(
      BuildContext context, Map place, BusinessAppMode businessAppMode) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      var url2;
      if (businessAppMode == BusinessAppMode.GROCERY ||
          businessAppMode == BusinessAppMode.WINESHOP) {
        String con = Environment().getCurrentConfig().vezaGroceryPlugInUrl;
        url2 = con +
            "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone" +
            getUserLatLong(place);
      } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
        String con = Environment().getCurrentConfig().subscriptionPlugInUrl;
        url2 = con +
            "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone" +
            getUserLatLong(place);
      }
      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          print(url2);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                print(Platform.isAndroid);
                return OnlineOrderWebView(
                    businessAppMode, place["company_name"], url2);
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

  void callTiffinList(Map place, String url) {
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
          "$url/callback?session_token=$session_token&username=$user_name&method=sess&source=cubeone" +
              getUserLatLong(place)
          /*"&lat=${place['user_address']['latitude']}&long=${place['user_address']['longitude']}"*/;
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
                    place['company_name'],
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
}
