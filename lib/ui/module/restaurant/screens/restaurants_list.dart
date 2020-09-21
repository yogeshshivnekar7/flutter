import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/restaurant/restaurant_presenter.dart';
import 'package:sso_futurescape/presentor/module/restaurant/restaurant_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/request_resto.dart';
import 'package:sso_futurescape/ui/module/sso/profile/add_new_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/address_list_widget.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/logger.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class RestaurantsList extends StatefulWidget {
  @override
  _RestaurantsListState createState() => _RestaurantsListState();

  static void list_resto(BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      String con = Environment()
          .getCurrentConfig()
          .account_url;
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
                    BusinessAppMode.RESTAURANT, "list now", url2);
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

class _RestaurantsListState extends State<RestaurantsList>
    implements RestaurantView {
  var _userProfie;
  final TextEditingController _searchControl = new TextEditingController();
  RestaurantPresenter _restaurantPresenter;
  List restaurants;
  bool isLoading = true;
  Map address;

  /*launchURL() {
    launch('https://flutter.dev');
  }*/

  @override
  void initState() {
    SsoStorage.getUserProfile().then((onValue) {
      _userProfie = onValue;
      if (_userProfie["addresses"] != null) {
        List addresses = _userProfie["addresses"];
        if (addresses.length > 0) {
          address = addresses[0];
          print("ddddddddddddddddd");
          print(address);
        }
      }
      _restaurantPresenter = new RestaurantPresenter(this);
      getRestoList();
      hasAtLeastOneAddress();
    });

    super.initState();
  }

  void getRestoList() {
    if (address != null && address["latitude"] != null) {
      _restaurantPresenter.getRestaurant(
          lat: address["latitude"], long: address["longitude"]);
    } else {
      _restaurantPresenter.getRestaurant(isLastRequest: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: FsColor.primaryrestaurant,
        elevation: 0.0,
        title:
        /*Expanded(
          child: FlatButton(
            onPressed: () {
              locationModalBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.all(0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Order Food',
                        style: FSTextStyle.appbartextlight,
                      ),
                      address == null ? Container() : Container(
                        width: 200,
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          text: TextSpan(
                            text:
                            '${address != null
                                ? address['address_tag']
                                : 'restaurants'} - '
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: FSTextStyle.h7size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ManageAddress.getFullAddress(address),
                                style: TextStyle(
                                  fontSize: FSTextStyle.h7size,
                                  fontFamily: 'Gilroy-Regular',
                                  color: FsColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 5),
                  Icon(
                    FlutterIcon.angle_down,
                    size: FSTextStyle.h6size,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),*/
        /* new Text(
          'order food'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),*/
        Container(
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
                      'order food'.toLowerCase(),
                      style: FSTextStyle.appbartextlight,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      getSubHeader(),
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
        ),
        /* title: Expanded(
          child: FlatButton(
           */
        /* onPressed: () {
              locationModalBottomSheet(context);
            },*/
        /*
            child: Container(
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Icon(FlutterIcon.location_1, size: FSTextStyle.h4size, color: Colors.white,),
                  // SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Order Food',
                        style: FSTextStyle.appbartextlight,
                      ),
                      Container(
                        width: 200,
                        // child: Text(
                        //   'lorem ipsum streetlorem ipsum streetlorem ipsum streetlorem ipsum street',
                        //   style: TextStyle(fontSize: FSTextStyle.h7size, fontFamily: 'Gilroy-Regular', color: Colors.white,),
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          text: TextSpan(
                            text: 'Home - '.toUpperCase(),
                            style: TextStyle(fontSize: FSTextStyle.h7size, fontFamily: 'Gilroy-SemiBold', color: FsColor.white,),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'lorem ipsum streetlorem ipsum streetlorem ipsum streetlorem ipsum street',
                                style: TextStyle(fontSize: FSTextStyle.h7size, fontFamily: 'Gilroy-Regular', color: FsColor.white,),
                              ),
                            ],
                          ),
                        ),
                      ),



                    ],
                  ),
                  SizedBox(width: 5),
                  Icon(FlutterIcon.angle_down, size: FSTextStyle.h6size, color: Colors.white,)
                ],
              ),
            ),
          ),
        ),*/
        leading: FsBackButtonlight(),
      ),
      body: isLoading
          ? PageLoader()
          : ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
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
                  hintText: "search restaurant",
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
                onChanged: (text) => {searchRestaurant(text)},
              ),
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
                return buildListItem(place, context);
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 30.0),
//                   child: InkWell(
//                     child: Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: Row(
//                             children: <Widget>[
//                               getRestoImage(place) == null
//                                   ? ClipRRect(
//                                 borderRadius:
//                                 BorderRadius.circular(5),
//                                 child: Image.asset(
//                                   "images/default_restaurant.png",
//                                   height: 90,
//                                   width: 90,
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                                   : FadeInImage(
//                                   image: NetworkImage(
//                                       getRestoImage(place)),
//                                   placeholder: AssetImage(
//                                       "images/default_restaurant.png"),
//                                   height: 90,
//                                   width: 90,
//                                   fit: BoxFit.cover),
//                               SizedBox(width: 15),
//                               Container(
//                                 // height: 85,
//                                 width: MediaQuery
//                                     .of(context)
//                                     .size
//                                     .width -
//                                     160,
//                                 child: ListView(
//                                   primary: false,
//                                   physics:
//                                   NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   children: <Widget>[
//                                     Container(
//                                       alignment:
//                                       Alignment.centerLeft,
//                                       child: Text(
//                                         "${AppUtils.capitalize(
//                                             getBrandCompanyName(place))}",
//                                         style: TextStyle(
//                                           fontSize:
//                                           FSTextStyle.h6size,
//                                           fontFamily: 'Gilroy-bold',
//                                         ),
//                                         maxLines: 2,
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                     SizedBox(height: 2),
//                                     getLocation(place) == null
//                                         ? Container()
//                                         : Row(
//                                       children: <Widget>[
//                                         Icon(
//                                           Icons.location_on,
//                                           size: 13,
//                                           color: FsColor
//                                               .lightgrey,
//                                         ),
//                                         SizedBox(width: 2),
//                                         Container(
//                                           alignment: Alignment
//                                               .centerLeft,
//                                           child: Text(
//                                             "${getLocation(place)}",
//                                             style: TextStyle(
//                                               fontFamily:
//                                               'Gilroy-SemiBold',
//                                               fontSize: 13,
//                                               color: FsColor
//                                                   .lightgrey,
//                                             ),
//                                             maxLines: 1,
//                                             textAlign:
//                                             TextAlign
//                                                 .left,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: <Widget>[
//                                         place['cuisine'] != null
//                                             ? Container(
//                                           alignment: Alignment
//                                               .centerLeft,
//                                           child: Text(
//                                             place['cuisine'],
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: FsColor
//                                                   .lightgrey,
//                                               fontFamily:
//                                               'Gilroy-SemiBold',
//                                             ),
//                                             maxLines: 1,
//                                             textAlign:
//                                             TextAlign
//                                                 .left,
//                                           ),
//                                         )
//                                             : Container(),
//                                       ],
//                                     ),
//                                     SizedBox(height: 4),
//                                     Row(
//                                       children: <Widget>[
//                                         place['cost_for_two'] !=
//                                             null
//                                             ? Container(
//                                           alignment: Alignment
//                                               .centerLeft,
//                                           child: Text(
//                                             'Rs.' +
//                                                 place['cost_for_two']
//                                                     .toString() +
//                                                 ' for two'
//                                                     .toString(),
//                                             style: TextStyle(
//                                               fontSize: 11,
//                                               color: const Color(
//                                                   0xFF6c757d),
//                                               fontFamily:
//                                               'Gilroy-Regular',
//                                             ),
//                                             maxLines: 1,
//                                             textAlign:
//                                             TextAlign
//                                                 .left,
//                                           ),
//                                         )
//                                             : Container(),
//                                         place['min_delivery_time'] !=
//                                             null &&
//                                             place['cost_for_two'] !=
//                                                 null
//                                             ? Container(
//                                           alignment: Alignment
//                                               .centerLeft,
//                                           child: Text(
//                                             " | ",
//                                             style: TextStyle(
//                                               fontSize: 11,
//                                               color: const Color(
//                                                   0xFF663300),
//                                               fontFamily:
//                                               'Gilroy-Regular',
//                                             ),
//                                             maxLines: 1,
//                                             textAlign:
//                                             TextAlign
//                                                 .left,
//                                           ),
//                                         )
//                                             : Container(),
//                                         place['min_delivery_time'] !=
//                                             null
//                                             ? Container(
//                                           alignment: Alignment
//                                               .centerLeft,
//                                           child: Text(
//                                             place['min_delivery_time']
//                                                 .toString() +
//                                                 ' min'
//                                                     .toString(),
//                                             style: TextStyle(
//                                               fontSize: 11,
//                                               color: const Color(
//                                                   0xFF6c757d),
//                                               fontFamily:
//                                               'Gilroy-Regular',
//                                             ),
//                                             maxLines: 1,
//                                             textAlign:
//                                             TextAlign
//                                                 .left,
//                                           ),
//                                         )
//                                             : Container(),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Container(
//                                       child: Row(
//                                         children: <Widget>[
//                                           Container(
//                                             padding:
//                                             EdgeInsets.fromLTRB(
//                                                 0.0,
//                                                 0.0,
//                                                 0.0,
//                                                 0),
//                                             child: Row(
//                                               children: <Widget>[
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .start,
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .start,
//                                                   children: <
//                                                       Widget>[
//                                                     getCallNumber(
//                                                         place) !=
//                                                         null
//                                                         ? Container(
//                                                       width:
//                                                       50,
//                                                       child:
//                                                       GestureDetector(
//                                                         child:
//                                                         RaisedButton(
//                                                           elevation:
//                                                           0,
//                                                           padding: EdgeInsets
//                                                               .fromLTRB(
//                                                               0,
//                                                               0,
//                                                               0,
//                                                               0),
//                                                           shape:
//                                                           new CircleBorder(),
//                                                           onPressed:
//                                                               () {
//                                                             callIntent(place);
//                                                           },
//                                                           color:
//                                                           FsColor.green,
//                                                           child: Icon(
//                                                               FlutterIcon
//                                                                   .phone_1,
//                                                               color: FsColor
//                                                                   .white,
//                                                               size: FSTextStyle
//                                                                   .h5size),
//                                                         ),
//                                                       ),
//                                                     )
//                                                         : Container(),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     (!getMenuForResto(place))
//                                                         ? GestureDetector(
//                                                       child:
//                                                       FlatButton(
//                                                         onPressed:
//                                                             () {
//                                                           resto_click(place,
//                                                               context);
//                                                         },
//                                                         child:
//                                                         Row(
//                                                           children: <Widget>[
//                                                             Icon(FlutterIcon
//                                                                 .eye_1,
//                                                                 size: FSTextStyle
//                                                                     .h6size),
//                                                             SizedBox(
//                                                               height: 5.0,
//                                                             ),
//                                                             Text("View Menu"),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     )
//                                                         : Container(),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       if (place['online_ordering_enabled']
//                           .toString() !=
//                           null &&
//                           place['online_ordering_enabled'] ==
//                               'yes') {
//                         resto_click(place, context);
//                       } else {
// //                                    Toasly.error(context, 'Currently not accepting order from CubeOne App portal!');
//                       }
//                     },
//                   ),
//                 );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              getRestoImage(place) == null
                                  ? ClipRRect(
                                borderRadius:
                                BorderRadius.circular(5),
                                child: Image.asset(
                                  "images/default_restaurant.jpg",
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : FadeInImage(
                                  image: NetworkImage(
                                      getRestoImage(place)),
                                  placeholder: AssetImage(
                                      "images/default_restaurant.jpg"),
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover),
                              SizedBox(width: 15),
                              Container(
                                // height: 85,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width -
                                    160,
                                child: ListView(
                                  primary: false,
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Container(
                                      alignment:
                                      Alignment.centerLeft,
                                      child: Text(
                                        "${AppUtils.capitalize(
                                            getBrandCompanyName(place))}",
                                        style: TextStyle(
                                          fontSize:
                                          FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-bold',
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    getLocation(place) == null
                                        ? Container()
                                        : Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 13,
                                          color: FsColor
                                              .lightgrey,
                                        ),
                                        SizedBox(width: 2),
                                        Container(
                                          alignment: Alignment
                                              .centerLeft,
                                          child: Text(
                                            "${getLocation(place)}",
                                            style: TextStyle(
                                              fontFamily:
                                              'Gilroy-SemiBold',
                                              fontSize: 13,
                                              color: FsColor
                                                  .lightgrey,
                                            ),
                                            maxLines: 1,
                                            textAlign:
                                            TextAlign
                                                .left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        place['cuisine'] != null
                                            ? Container(
                                          alignment: Alignment
                                              .centerLeft,
                                          child: Text(
                                            place['cuisine'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: FsColor
                                                  .lightgrey,
                                              fontFamily:
                                              'Gilroy-SemiBold',
                                            ),
                                            maxLines: 1,
                                            textAlign:
                                            TextAlign
                                                .left,
                                          ),
                                        )
                                            : Container(),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: <Widget>[
                                        place['cost_for_two'] !=
                                            null
                                            ? Container(
                                          alignment: Alignment
                                              .centerLeft,
                                          child: Text(
                                            'Rs.' +
                                                place['cost_for_two']
                                                    .toString() +
                                                ' for two'
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: const Color(
                                                  0xFF6c757d),
                                              fontFamily:
                                              'Gilroy-Regular',
                                            ),
                                            maxLines: 1,
                                            textAlign:
                                            TextAlign
                                                .left,
                                          ),
                                        )
                                            : Container(),
                                        place['min_delivery_time'] !=
                                            null &&
                                            place['cost_for_two'] !=
                                                null
                                            ? Container(
                                          alignment: Alignment
                                              .centerLeft,
                                          child: Text(
                                            " | ",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: const Color(
                                                  0xFF663300),
                                              fontFamily:
                                              'Gilroy-Regular',
                                            ),
                                            maxLines: 1,
                                            textAlign:
                                            TextAlign
                                                .left,
                                          ),
                                        )
                                            : Container(),
                                        place['min_delivery_time'] !=
                                            null
                                            ? Container(
                                          alignment: Alignment
                                              .centerLeft,
                                          child: Text(
                                            place['min_delivery_time']
                                                .toString() +
                                                ' min'
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: const Color(
                                                  0xFF6c757d),
                                              fontFamily:
                                              'Gilroy-Regular',
                                            ),
                                            maxLines: 1,
                                            textAlign:
                                            TextAlign
                                                .left,
                                          ),
                                        )
                                            : Container(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                            EdgeInsets.fromLTRB(
                                                0.0,
                                                0.0,
                                                0.0,
                                                0),
                                            child: Row(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <
                                                      Widget>[
                                                    getCallNumber(
                                                        place) !=
                                                        null
                                                        ? Container(
                                                      width:
                                                      50,
                                                      child:
                                                      GestureDetector(
                                                        child:
                                                        RaisedButton(
                                                          elevation:
                                                          0,
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                              0,
                                                              0,
                                                              0,
                                                              0),
                                                          shape:
                                                          new CircleBorder(),
                                                          onPressed:
                                                              () {
                                                            callIntent(place);
                                                          },
                                                          color:
                                                          FsColor.green,
                                                          child: Icon(
                                                              FlutterIcon
                                                                  .phone_1,
                                                              color: FsColor
                                                                  .white,
                                                              size: FSTextStyle
                                                                  .h5size),
                                                        ),
                                                      ),
                                                    )
                                                        : Container(),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    getMenuForResto(
                                                        place) !=
                                                        null
                                                        ? GestureDetector(
                                                      child:
                                                      FlatButton(
                                                        color:
                                                        Colors.green,
                                                        onPressed:
                                                            () {},
                                                        child:
                                                        Row(
                                                          children: <Widget>[
                                                            Icon(FlutterIcon
                                                                .eye_1,
                                                                size: FSTextStyle
                                                                    .h6size),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            Text("View Menu"),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                        : Container(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (place['online_ordering_enabled']
                          .toString() !=
                          null &&
                          place['online_ordering_enabled'] ==
                              'yes') {
                        resto_click(place, context);
                      } else {
//                                    Toasly.error(context, 'Currently not accepting order from CubeOne App portal!');
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Text("request listing now",
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.lightgrey,
                    fontFamily: 'Gilroy-SemiBold')),
          ),
          Container(
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
                color: FsColor.primaryrestaurant,
                textColor: FsColor.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RequestListingPage(
                                BusinessAppMode.RESTAURANT, 'business')),
                  );
                  /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              */ /*RequestListingPage('Resto', 'business')*/ /*
                              OnlineOrderWebView("resto", "list now", Environment()
                                  .getCurrentConfig()
                                  .account_url)),
                        );*/
                  //    RestaurantsList.list_resto(context);
                },
              ),
            ),
          ),
          Container(
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
                                fontFamily: 'Gilroy-SemiBold'))
                    ),

                    GestureDetector(
                      child: RaisedButton(
                        child: Text('Click Now',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: FsColor.primaryrestaurant,
                        textColor: FsColor.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RequestListingPage(
                                        BusinessAppMode.RESTAURANT,
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
    );
  }

/*/*locality: Thane, zipcode: 400703, city: Navi Mumbai*/*/
  getSubHeader() {
    if (address == null) {
      return 'restaurants';
    } else {
      String addressTitle = "";
      if (!isEmptyORNULL(address["locality"])) {
        if (!isEmptyORNULL(address["city"])) {
          return "${address['address_tag']} (${address["locality"]} ${address["city"]})";
        } else {
          return "${address['address_tag']} (${address["locality"]})";
        }
      } else {
        if (!isEmptyORNULL(address["city"])) {
          return "${address['address_tag']} (${address["city"]})";
        } else {
          return "${address['address_tag']})";
        }
      }


      if (!isEmptyORNULL(address["city"])) {
        if (addressTitle.isEmpty) {
          addressTitle = address["city"];
        } else {
          addressTitle = addressTitle + " " + address["city"];
        }
      }
      return "${address['address_tag']} ${addressTitle}";
    }
  }

  bool isEmptyORNULL(addres) {
    return (addres == null || addres
        .toString()
        .trim()
        .isEmpty);
  }

  Padding buildListItem(Map place, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(5),
            //   child: Image.asset("images/default_restaurant.png",
            //   height: 48, width: 48, fit: BoxFit.cover,
            //   ),
            // ),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: FsColor.lightgrey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: getRestoImage(place) == null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  "images/default_restaurant.png",
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              )
                  : FadeInImage(
                  image: NetworkImage(getRestoImage(place)),
                  placeholder: AssetImage("images/default_restaurant.png"),
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover),
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
                        Container(
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
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    place['cuisine'] != null
                        ? Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        place['cuisine'],
                        style: TextStyle(
                          fontSize: FSTextStyle.h7size,
                          color: FsColor.lightgrey,
                          fontFamily: 'Gilroy-SemiBold',
                        ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                        : Container(),
                    SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        place['cost_for_two'] != null
                            ? Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rs.' +
                                place['cost_for_two'].toString() +
                                ' for two'.toString(),
                            style: TextStyle(
                              fontSize: FSTextStyle.h7size,
                              color: FsColor.brown,
                              fontFamily: 'Gilroy-Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                            : Container(),
                        place['min_delivery_time'] != null &&
                            place['cost_for_two'] != null
                            ? Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " | ",
                            style: TextStyle(
                              fontSize: FSTextStyle.h7size,
                              color: FsColor.brown,
                              fontFamily: 'Gilroy-Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                            : Container(),
                        place['min_delivery_time'] != null
                            ? Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            place['min_delivery_time'].toString() +
                                ' min'.toString(),
                            style: TextStyle(
                              fontSize: FSTextStyle.h7size,
                              color: FsColor.brown,
                              fontFamily: 'Gilroy-Regular',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            getCallNumber(place) != null
                ? Container(
              height: 55.0,
              width: 55.0,
              alignment: Alignment.center,
              child: GestureDetector(
                child: RaisedButton(
                  elevation: 0,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  shape: CircleBorder(),
                  onPressed: () {
                    callIntent(place);
                  },
                  color: FsColor.green,
                  child: Icon(FlutterIcon.phone_1,
                      color: FsColor.white, size: FSTextStyle.h5size),
                ),
              ),
            )
                : Container(),
          ],
        ),
        onTap: () {
          print(place);
          // print(place['online_ordering_enabled']);
          //print("fffffffff");
          if (place['online_ordering_enabled'].toString() != null &&
              place['online_ordering_enabled'] == 'yes') {
            resto_click(place, context);
          } else {
            resto_click(place, context);
            // Toasly.error(context, 'Currently not accepting order from CubeOne App portal!');
          }
        },
      ),
    );
  }

  String getBrandCompanyName(Map place) {
    // print(place);
    String company_name;
    if (place['brand_name'] == null || place['brand_name']
        .toString()
        .isEmpty) {
      company_name = place['company_name'];
    } else {
      company_name = place['brand_name'];
    }
    return company_name;
  }

  String getLocation(Map place) {
    if (place['city'] != null && place['state'] != null) {
      return place['city'] + "," + place['state'];
    } else {
      return null;
    }
  }

  void resto_click(Map place, BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      String con = Environment()
          .getCurrentConfig()
          .vezaPlugInUrl;
      var url2 = con +
          "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone";
      print(url2);
      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return OnlineOrderWebView(
                    BusinessAppMode.RESTAURANT, getBrandCompanyName(place),
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

  String getRestoImage(Map place) {
    /*if (place == null || place['details'] == null) {
      return null;
    } else {
      List list = place['details'];
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'] == 'Restaurant_Logo_Url') {
            return list[i]['company_value'];
          }
        }
      } else {
        return null;
      }
    }*/
    if (place == null || place['company_code'] == null) {
      return null;
    } else {
      String code = place['company_code'];
      return Environment()
          .getCurrentConfig()
          .tiffin_image_logo +
          '/$code/images/logo.png';
      /*List list = place['details'];
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'] == 'Restaurant_Logo_Url') {
            return list[i]['company_value'];
          }
        }
      } else {
        return null;
      }*/
    }
  }

  @override
  clearList() {
    if (restaurants != null) restaurants.clear();
  }

  @override
  onError(error) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  onFailure(failure) {
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {
      isLoading = false;
      if (restaurants != null) {
        restaurants.clear();
      }
    });
  }

  @override
  onRestaurantFound(restaurant, {bool isLastRequest}) {
    restaurants = restaurant["data"];
    if (isLastRequest != true &&
        (restaurants == null || restaurants.length == 0)) {
      _restaurantPresenter.getRestaurant(isLastRequest: true);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  searchRestaurant(String text) {
    Logger.log("Change Text --" + text);
    _restaurantPresenter.getRestaurant(search: text);
  }

  @override
  onRestaurantURLFound(restaurant, {String company_name}) {
    // TODO: implement onRestaurantURLFound
    return null;
  }

  Future<void> callIntent(Map place) async {
    List number = getCallNumber(place);
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

  List getCallNumber(Map place) {
    if (place == null || place['details'] == null) {
      return null;
    } else {
      List list = place['details'];
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'] == 'SUPPORT_CONTACT_NO') {
            var split = list[i]['company_value'].toString().split(',');
            return split;
          }
        }
      } else {
        return null;
      }
    }
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
        context: context,
        isDismissible: cancelable ? false : true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
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
                    Container(
                          width: 50,
                          child: FlatButton(
                              onPressed: () {
                                if (cancelable == false && address == null) {
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
                  Container(
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
                              Icons.my_location,
                              size: FSTextStyle.h4size,
                              color: FsColor.primaryrestaurant,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Use Current Location'.toLowerCase(),
                              style: TextStyle(
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontSize: FSTextStyle.h5size,
                                  color: FsColor.primaryrestaurant),
                            ),
                          ],
                        ),
                      )),
                  AddresList(null, _userProfie, onAddressClick: (address1) {
                    isLoading = true;
                    setState(() {
                      address = address1;
                    });
                    if (restaurants != null) {
                      restaurants.clear();
                    }
                    getRestoList();
                    Navigator.pop(context);
                  }, onDeleteClick: (tag) {
                    Toasly.error(context, tag);
                    _restaurantPresenter.deleteAddress(tag);
                  },
                      noAddressText: "add address to search restaurants near you"),
                ],
              ));
        });
  }

  Future<void> addAddress(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewAddress(_userProfie["addresses"])),
    );
    if (result != null) {
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          setState(() {});
          Navigator.pop(context);
          getRestoList();
        }
      });
    }
  }

  Future<void> hasAtLeastOneAddress() async {
    await Future.delayed(Duration(seconds: 1));
    if (address == null) {
      locationModalBottomSheet(context, cancelable: false);
    }
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
            address = addresses[addresses.length - 1];
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
            address = addresses[addresses.length - 1];
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
    setState(() {

    });
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
