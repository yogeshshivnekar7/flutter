/*
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
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/logger.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class TiffinList extends StatefulWidget {
  @override
  _TiffinListState createState() => _TiffinListState();
}

class _TiffinListState extends State<TiffinList> implements RestaurantView {
  final TextEditingController _searchControl = new TextEditingController();

  launchURL() {
    // launch('https://flutter.dev');
    Toasly.success(context, 'coming soon', duration: DurationToast.LONG);
  }

  var _userProfie;
  RestaurantPresenter _restaurantPresenter;
  List tiffins;
  bool isLoading = true;

  @override
  void initState() {
    SsoStorage.getUserProfile().then((onValue) => _userProfie = onValue);
    _restaurantPresenter = new RestaurantPresenter(this);
    _restaurantPresenter.getTiffin(industry_type: */
/*"Subscription"*/ /*
 'food');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: FsColor.primarytiffin,
        elevation: 0.0,
        title: new Text(
          'homestyle food',
          style: FSTextStyle.appbartextlight,
        ),
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
                  hintText: "search homely food",
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
                onChanged: (text) => {searchTiffin(text)},
              ),
            ),
          ),
          tiffins == null || tiffins.isEmpty
              ? FsNoData()
              : Padding(
            padding: EdgeInsets.all(12),
            child: ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tiffins == null ? 0 : tiffins.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = tiffins[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: InkWell(
                    child: Container(
                      // height: 90,
                      child: Row(
                        children: <Widget>[
                          getRestoImage(place) == null
                              ? ClipRRect(
                            borderRadius:
                            BorderRadius.circular(5),
                            child: Image.asset(
                              "images/default_tiffin.jpg",
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          )
                              : ClipRRect(
                            borderRadius:
                            BorderRadius.circular(5),
                            child: FadeInImage(
                                image: NetworkImage(
                                    getRestoImage(place)),
                                placeholder: AssetImage(
                                    "images/default_tiffin.jpg"),
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover),
                          ),
                          SizedBox(width: 15),
                          Container(
                            // height: 85,
                            width:
                            MediaQuery
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
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${AppUtils.capitalize(
                                        getBrandCompanyName(place))}",
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
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
                                      color:
                                      FsColor.lightgrey,
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
                                        TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2),
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
                                        TextAlign.left,
                                      ),
                                    )
                                        : Container(),
                                  ],
                                ),
                                */
/*SizedBox(height: 8),
                                place['cuisine']!=null ? Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "30% off on order above ₹99 | Use code VEZA123",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color:
                                      const Color(0xFF663300),
                                      fontFamily: 'Gilroy-Regular',
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ):Container(),*/ /*

                                SizedBox(height: 8),
                                place['cost_for_two'] != null
                                    ? Container(
                                  alignment:
                                  Alignment.centerLeft,
                                  child: Text(
                                    (' meal starts at Rs.' +
                                        place['cost_for_two']
                                            .toString() +
                                        ' (approx)')
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: const Color(
                                          0xFF6c757d),
                                      fontFamily:
                                      'Gilroy-Regular',
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                                    : Container(),

                                */
/*place['min_delivery_time'] != null
                                    ? Container(
                                  alignment:
                                  Alignment.centerLeft,
                                  child: Text(
                                    place['min_delivery_time']
                                        .toString() +
                                        ' min'
                                            .toString()
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: const Color(
                                          0xFF6c757d),
                                      fontFamily:
                                      'Gilroy-Regular',
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                                    : Container(),*/ /*



                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    onTap: () {
                      _restaurantPresenter.getRestaurantURL(
                          getBrandCompanyName(place),
                          place['company_id'].toString());
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
                color: FsColor.primarytiffin,
                textColor: FsColor.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RequestListingPage('Tiffin', 'business')),
                  );
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
                        color: FsColor.primarytiffin,
                        textColor: FsColor.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RequestListingPage(
                                        'Tiffin', 'favourite place')),
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

  String getLocation(Map place) {
    if (place['city'] != null && place['state'] != null) {
      return place['city'] + "," + place['state'];
    } else {
      return null;
    }
  }

  String getBrandCompanyName(Map place) {
    if (place['brand_name'] == null || place['brand_name']
        .toString()
        .isEmpty) {
      return place['company_name'];
    } else {
      return place['brand_name'];
    }
  }

  void callTiffinList(String companyName, String url) {
    print(url);
    SsoStorage.getUserProfile().then((profile) {
      var user_name = profile['username'];
      var session_token = profile['session_token'];
      //var url2 = "http://stage.sellmore.co.in/callback?session_token=$session_token&username=$user_name&method=sess";
      var url2 =
          "$url/callback?session_token=$session_token&username=$user_name&method=sess&source=cubeone";
      try {
        print(url2);
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                print(Platform.isAndroid);
                return OnlineOrderWebView(BusinessAppMode.TIFFIN, companyName, url2);
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
    if (place == null || place['company_code'] == null) {
      return null;
    } else {
      String code = place['company_code'];
      return Environment()
          .getCurrentConfig()
          .tiffin_image_logo +
          '/$code/images/logo.png';
    }
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
    @override
    onFailure(failure) {
      print(failure);
      Toasly.error(context, AppUtils.errorDecoder(failure));
      setState(() {
        isLoading = false;
        if (tiffins != null) {
          tiffins.clear();
        }
      });
    }
  }

  @override
  onRestaurantFound(restaurant, {bool isLastRequest}) {
    print(restaurant);
    setState(() {
      isLoading = false;
      tiffins = restaurant["data"] */
/*["results"]*/ /*
;
    });
  }

  searchTiffin(String text) {
    Logger.log("Change Text --" + text);
    _restaurantPresenter.getTiffin(industry_type: "food", search: text);
  }

  @override
  clearList() {
    print("clearList");
    if (tiffins != null) tiffins.clear();
  }

  @override
  onRestaurantURLFound(restaurant, {String company_name}) {
    List list = restaurant['data'];
    bool status = false;
    for (var a in list) {
      if (a['product_code'] == 'QUICKSERVE') {
        callTiffinList(company_name, a['ui_end_point']);
        status = true;
        break;
      }
    }
    if (!status) {
    }
    return null;
  }

  @override
  void addressDeleted(success) {
    // TODO: implement addressDeleted
  }

  @override
  void addressDeletionFailed(failed) {
    // TODO: implement addressDeletionFailed
  }
}
*/
