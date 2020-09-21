import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/intro/intro_restaurant.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/storage/restaurnunt_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'main_dashboard.dart';

class RestaurantCard extends StatefulWidget {
  @override
  RestaurantCardState createState() => new RestaurantCardState();
}

class RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: new Container(
          child: Column(
        children: <Widget>[
          new Container(
            child: new Card(
              key: null,
              child: Container(
                /*decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/dash-bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),*/
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "restaurants",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.dashtitlesize,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.primaryrestaurant),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  child: RaisedButton(
                                    elevation: 1.0,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(4.0),
                                    ),
                                    onPressed: () {
                                      restaurnatInfo(context);
                                      //openRestaurantList(),
                                    },
                                    color: FsColor.primaryrestaurant,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    child: Text(
                                      "Find Restaurants",
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-Bold',
                                          color: FsColor.white),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Image.asset("images/dash3.png",
                                height: 100, width: 100, fit: BoxFit.fitHeight),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.0,
                      child: Divider(
                          color: FsColor.darkgrey.withOpacity(0.2),
                          height: 2.0),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child: Text(
                                  "Order food | comfort of home | quick delivery | pay online | trusted food joints | easy repeat orders"
                                      .toLowerCase(),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: FSTextStyle.dashsubtitlesize,
                                      fontFamily: FSTextStyle.dashsubtitlefont,
                                      color: FsColor.dashsubtitlecolor)))
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Text(
                    //             "3",
                    //             style: TextStyle(fontSize: FSTextStyle.h4size, fontFamily: 'Gilroy-Bold', color:  FsColor.darkgrey),
                    //           ),
                    //           Container(
                    //             height: 3,
                    //           ),
                    //           Text("Past Orders",
                    //             style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color:  FsColor.darkgrey),
                    //          ),
                    //           SizedBox(height: 4.0),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           GestureDetector(
                    //             child: FlatButton(
                    //               onPressed: () {},
                    //               child: Row(
                    //                 children: <Widget>[
                    //                   Text("View & Re-Order",
                    //                     style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color:  FsColor.darkgrey),
                    //                   ),
                    //                   SizedBox(width: 10.0),
                    //                   Icon(FlutterIcon.right_big, color: FsColor.darkgrey, size: FSTextStyle.h6size),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 5.0),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            alignment: Alignment.center,
          ),
        ],
      )),
      onTap: () {
        restaurnatInfo(context);
      },
    );
  }

  static void _checkForProfile(BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var _userProfiew = profile;
      // if (!isSocietyAdded) {
      bool isUnNotSet = false;
      if (_userProfiew["first_name"] == null ||
          _userProfiew["first_name"].toString().isEmpty) {
        isUnNotSet = true;
      }

      if (isUnNotSet) {
        UpdateProfileDialog(context, onUpdateProfile,
            name: isUnNotSet, email: false);
      } else {
        openRestaurantList(context);
      }
    });
  }

 static onUpdateProfile() {
    /*print(
        "--------------------------------onUpdateProfile---------------------------");
    setState(() {
      SsoStorage.getUserProfile().then((profile) {});
    });*/
  }

static  openRestaurantList(BuildContext context) {
    AppUtils.checkInternetConnection().then((onValue) {
      // getLocation();
      if (onValue) {
        FsFacebookUtils.callCartClick(FsString.Restaurants, "card");
        MainDashboardState.cart_icon.changeBuniessMOde(BusinessAppMode.GROCERY);
        MainDashboardState.cart_icon.updateValue();
        //setState(() {});
        var result = Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  VezaShopList(businessAppMode: BusinessAppMode.RESTAURANT)),
        );
        MainDashboardState.cart_icon
            .changeBuniessMOde(BusinessAppMode.APP_THEME);

       // setState(() {});
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }

  void getLocation() {
    var location = new Location();
    location.getLocation().then((currentLocation) {
      try {
        print(currentLocation.latitude);
        print(currentLocation.longitude);
      } catch (e) {
        print(e);
      }
    });
  }

 static Future<void> restaurnatInfo(BuildContext context) async {
    bool value = await RestaurantStorage.getRestaurantProductInfoStatus();
    if (!value) {
      var a = await Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => IntroRestaurant()),
      );
      RestaurantStorage.setRestaurantProductInfoStatus(true);
    } else {}
    _checkForProfile(context);
  }
}
