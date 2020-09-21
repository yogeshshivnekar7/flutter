import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:common_config/utils/firebase/firebase_dynamiclink.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_storedetail.dart';
import 'package:sso_futurescape/ui/module/orders/store_detail_helper.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/number_masking_alertbox.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/fsshare.dart';

class PynaStoreDetails extends StatefulWidget {
  @override
  _PynaStoreDetailsState createState() => new _PynaStoreDetailsState();
}

class _PynaStoreDetailsState extends State<PynaStoreDetails>
    implements OnlineOrderView {
  bool close_popup = false;
  TextEditingController userNameController = new TextEditingController();
  Map place;
  OnlineOrderPresenter onlineOrderPresenter;

/*  get galleryItems => [
        "assets/images/pyna_1.png",
        "assets/images/pyna_2.png",
        "assets/images/pyna_3.png",
        "assets/images/pyna_4.png",
        "assets/images/pyna_5.png",
        "assets/images/pyna_6.png",
        "assets/images/pyna_7.png"
      ];*/

  void mapData() {
    place = {
      /* "com_latitude": place["latitude"],
      "com_longitude": place["longitude"],
      "company_id": place["company_id"],*/
      "company_name": /*'Pyna Wines'*/ og_company["company_name"],
      "address": GroceryStoreDetailsState.getAddress(og_company),
      "minimum_order": og_company["minimum_order_value"].toString(),
      "locality":
          GroceryStoreDetailsState.getAddress(og_company, onlyLocality: true),
      "details": og_company['details']
      /*"details": [
        {"company_key": "SUPPORT_CONTACT_NO", "company_value": "+919323773411"},
        {
          "company_key": "Offers",
          "company_value": [
            {
              "offer_code": "pyna11",
              "order_name": "Buy 1 Get 1 Free on all alchohol",
            },
            {
              "offer_code": "PYNA50",
              "order_name":
                  "50% off on all alchohol, \n applicable only for pickup order",
            },
            {
              "offer_code": "PYNAFREE",
              "order_name": "Buy any alchohol & Get any alchohol Free.",
            },
            {
              "offer_code": "pyna11",
              "order_name": "buy 1 get 1 free",
            },
          ]
        },
        {
          "company_key": "STORE_TIMINGS_MONDAY",
          "company_value": "10:30am 10:30pm"
        },
        {
          "company_key": "STORE_TIMINGS_TUESDAY",
          "company_value": "10:30am 10:30pm"
        },
        {
          "company_key": "STORE_TIMINGS_WEDNESDAY",
          "company_value": "10:30am 10:30pm"
        },
        {
          "company_key": "STORE_TIMINGS_THURSDAY",
          "company_value": "10:30am 10:30pm"
        },
        {
          "company_key": "STORE_TIMINGS_FRIDAY",
          "company_value": "10:30am 10:30pm"
        },
        {
          "company_key": "STORE_TIMINGS_SATURDAY",
          "company_value": "10:30am 10:30pm"
        },
        {
          "company_key": "STORE_TIMINGS_SUNDAY",
          "company_value": "10:30am 10:30pm"
        }
      ]*/
    };
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isButtonDisabled;

  @override
  void initState() {
    //mapData();
    if (Platform.isIOS) {
      checkWhatsApp();
    }
    _isButtonDisabled = false;
    getCompanyDetail();
    FsFacebookUtils.storeDetailEvent(BusinessAppMode.WINESHOP, shop_name_event);
  }

  bool whatsapp = true;

  Future checkWhatsApp() async {
    whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");
    setState(() {});
  }

  bool isExpanded = false;
  bool isLoading = true;
  var shop_name_event = "pyna_wine_shop";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: FsColor.primarypyna,
        elevation: 0.0,
        title: new Text(
          place != null ? place["company_name"] : "Store details".toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      body: isLoading
          ? PageLoader()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: FsColor.lightgrey.withOpacity(0.5),
                      ),
                    )),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: FsColor.lightgrey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          "images/pyna.png",
                                          height: 55,
                                          width: 100,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   width: 76,
                                    //   color: FsColor.primarypyna,
                                    //   child: Text('Offline'.toLowerCase(),
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',color: FsColor.white),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        place["company_name"],
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h5size,
                                            color: FsColor.basicprimary,
                                            fontFamily: 'Gilroy-SemiBold'),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Exclusive Wine store',
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h7size,
                                            color: FsColor.lightgrey,
                                            fontFamily: 'Gilroy-SemiBold'),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "$delivery_detail",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.darkgrey,
                                            fontFamily: 'Gilroy-SemiBold'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: FsColor.lightgrey.withOpacity(0.5),
                      ),
                    )),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Expanded(
                            //   child: FlatButton(
                            //     padding: EdgeInsets.all(0),
                            //       onPressed: (){},
                            //       child: Column(
                            //         children: [

                            //           Container(
                            //             width: 40,
                            //             height: 40,
                            //             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            //             decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.circular(35),
                            //               border: Border.all(width: 1.0, color: FsColor.lightgrey.withOpacity(0.5),),
                            //             ),
                            //             child: Icon(FlutterIcon.phone_1,
                            //             color: _isButtonDisabled ? FsColor.darkgrey.withOpacity(0.5) : FsColor.darkgrey,
                            //             size: FSTextStyle.h4size),
                            //           ),

                            //           SizedBox(height: 10),
                            //           Text('Call Now',
                            //             style: TextStyle(fontSize: FSTextStyle.h7size,
                            //             // color: FsColor.basicprimary,
                            //             color: _isButtonDisabled ? FsColor.basicprimary.withOpacity(0.5) : FsColor.basicprimary,
                            //             fontFamily: 'Gilroy-SemiBold'),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            // ),

//                             Expanded(
//                               child: FlatButton(
//                                 padding: EdgeInsets.all(0),
//                                 onPressed: AppUtils.getCallNumber(place) != null
//                                     ? () async {
//                                         try {
//                                           var whatsAppNumber =
//                                               GroceryStoreDetailsState
//                                                   .getWhatsAppNumber(place);
//                                           if (!FsPlatform.isAndroid()) {
//                                             if (whatsapp) {
//                                               FsFacebookUtils
//                                                   .whatsAppSubmitEvent(
//                                                       BusinessAppMode.WINESHOP,
//                                                       shop_name_event);
//                                               whatsAppNumber = whatsAppNumber
//                                                   .replaceAll("+", " ")
//                                                   .trim();
//                                               await FlutterLaunch.launchWathsApp(
//                                                   phone: whatsAppNumber,
//                                                   message:
//                                                       "Hi. I found your business on OneApp.");
//                                             } else {
// /*
//                                         Toasly.error(context,
//                                             "WhatsApp application not found in your phone!");
// */
//                                               showErrorAlertDialog(
//                                                   context,
//                                                   "Install WhatsApp!",
//                                                   "Looks like WhatsApp is not installed in your device. You may either install WhatsApp or Call to place your order.");
//                                             }
//                                           } else {
//                                             FsFacebookUtils.whatsAppSubmitEvent(
//                                                 BusinessAppMode.WINESHOP,
//                                                 shop_name_event);
//                                             FlutterOpenWhatsapp.sendSingleMessage(
//                                                 whatsAppNumber,
//                                                 "Hi. I found your business on OneApp.");
//                                           }
//                                         } catch (e) {
//                                           Toasly.error(context,
//                                               "Sorry unable to open whatsApp");
//                                         }
//                                       }
//                                     : null,
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                       width: 40,
//                                       height: 40,
//                                       padding:
//                                           EdgeInsets.fromLTRB(0, 10, 0, 10),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(35),
//                                         border: Border.all(
//                                           width: 1.0,
//                                           color: FsColor.lightgrey
//                                               .withOpacity(0.5),
//                                         ),
//                                       ),
//                                       child: Icon(FlutterIcon.whatsapp,
//                                           color: _isButtonDisabled
//                                               ? FsColor.darkgrey
//                                                   .withOpacity(0.5)
//                                               : FsColor.darkgrey,
//                                           size: FSTextStyle.h4size),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       'Whatsapp',
//                                       style: TextStyle(
//                                           fontSize: FSTextStyle.h7size,
//                                           color: _isButtonDisabled
//                                               ? FsColor.basicprimary
//                                                   .withOpacity(0.5)
//                                               : FsColor.basicprimary,
//                                           fontFamily: 'Gilroy-SemiBold'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  buildPynaWineMenu(context);
                                  //Toasly.error(context, "No menu available");
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        border: Border.all(
                                          width: 1.0,
                                          color: FsColor.lightgrey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      child: Icon(FlutterIcon.doc_text,
                                          color: FsColor.darkgrey,
                                          size: FSTextStyle.h4size),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Menu',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h7size,
                                          color: FsColor.basicprimary,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  shareMsg(context, place);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        border: Border.all(
                                          width: 1.0,
                                          color: FsColor.lightgrey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      child: Icon(FlutterIcon.share_1,
                                          color: FsColor.darkgrey,
                                          size: FSTextStyle.h4size),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h7size,
                                          color: FsColor.basicprimary,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 32,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: RaisedButton(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              onPressed: () {
                                _showDialog();

                                // // AppUtils.callIntent(
                                // //     AppUtils.getCallNumber(place)[0]);
                              },
                              child: Text(
                                'Call to Order',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                              color: FsColor.primarypyna,
                              textColor: FsColor.white,
                            )),
                      ],
                    ),
                  ),

                  /////call at code section start////////
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //   padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  //   decoration: BoxDecoration(
                  //       border: Border(
                  //           bottom: BorderSide(
                  //     width: 1.0,
                  //     color: FsColor.lightgrey.withOpacity(0.5),
                  //   ))),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       SizedBox(
                  //         width: 36,
                  //         height: 36,
                  //         child: Icon(FlutterIcon.phone_1,
                  //             color: FsColor.primarypyna,
                  //             size: FSTextStyle.h4size),
                  //       ),
                  //       SizedBox(width: 5),
                  //       Expanded(
                  //         child: Container(
                  //           margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  //           alignment: Alignment.topLeft,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: <Widget>[
                  //               Text(
                  //                 'Call at : '.toLowerCase(),
                  //                 style: TextStyle(
                  //                     fontSize: FSTextStyle.h6size,
                  //                     color: FsColor.lightgrey,
                  //                     fontFamily: 'Gilroy-SemiBold'),
                  //               ),
                  //               SizedBox(height: 5),
                  //               Text(
                  //                 AppUtils.getCallNumber(place)[0]
                  //                     .toLowerCase(),
                  //                 style: TextStyle(
                  //                     fontSize: FSTextStyle.h6size,
                  //                     color: FsColor.darkgrey,
                  //                     fontFamily: 'Gilroy-SemiBold'),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
///////call at code end/////////////

                  /*Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.lightgrey.withOpacity(0.5),
                    ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: Icon(FlutterIcon.doc_text,
                              color: FsColor.primarypyna,
                              size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Catalogue : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 90,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: galleryItems.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            child: GestureDetector(
                                          onTap: () {
                                            buildPynaWineMenu(context,position: index);
                                          },
                                          child: Card(
                                            color: Colors.black,
                                            child: Container(
                                              child: Center(
                                                child: Image.asset(
                                                  galleryItems[index],
                                                  height: 80.0,
                                                  width: 80.0,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  place["minimum_order"] != null &&
                          place["minimum_order"] != 'null'
                      ? Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 1.0,
                            color: FsColor.lightgrey.withOpacity(0.5),
                          ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: 36,
                                height: 36,
                                child: SizedBox(
                                  width: 36,
                                  height: 36,
                                  child: Icon(FlutterIcon.money,
                                      color: FsColor.primarypyna,
                                      size: FSTextStyle.h4size),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'minimum order : '.toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.lightgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "₹ " +
                                          place["minimum_order"].toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                  ],
                                ),
                              ),
                              /*SizedBox(width: 5),
                  Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Image.asset(
                        "images/googlemaps.png",
                        height: 35,
                        width: 35,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () {
                        callMap(context);
                      },
                    ),
                  ),*/
                            ],
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.lightgrey.withOpacity(0.5),
                    ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 36,
                          height: 36,
                          child: Icon(FlutterIcon.map_pin,
                              color: FsColor.primarypyna,
                              size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address : '.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.lightgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    place["address"].toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.lightgrey.withOpacity(0.5),
                    ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: Icon(FlutterIcon.clock_1,
                              color: FsColor.primarypyna,
                              size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Store Timings : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),
                                getStoreTimeing()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(width: 1.0, color: FsColor.lightgrey.withOpacity(0.5),)
                    //   )
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: Icon(Icons.local_offer,
                              color: FsColor.primarypyna,
                              size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Offer : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),

                                buildContainer111(),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //       alignment: Alignment.centerLeft,
                                //       width: 24,
                                //       height: 24,
                                //       child: Icon(FlutterIcon.ok_circled2, color: FsColor.green, size: FSTextStyle.h5size),
                                //     ),
                                //     Text("Parking".toLowerCase(),
                                //     style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey , fontFamily: 'Gilroy-SemiBold'),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //       alignment: Alignment.centerLeft,
                                //       width: 24,
                                //       height: 24,
                                //       child: Icon(FlutterIcon.ok_circled2, color: FsColor.green, size: FSTextStyle.h5size),
                                //     ),
                                //     Text("Serve Alchohol".toLowerCase(),
                                //     style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey , fontFamily: 'Gilroy-SemiBold'),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //       alignment: Alignment.centerLeft,
                                //       width: 24,
                                //       height: 24,
                                //       child: Icon(FlutterIcon.cancel_circled2, color: FsColor.red, size: FSTextStyle.h5size),
                                //     ),
                                //     Text("Indoor Seating".toLowerCase(),
                                //     style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey , fontFamily: 'Gilroy-SemiBold'),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //       alignment: Alignment.centerLeft,
                                //       width: 24,
                                //       height: 24,
                                //       child: Icon(FlutterIcon.cancel_circled2, color: FsColor.red, size: FSTextStyle.h5size),
                                //     ),
                                //     Text("Pickup".toLowerCase(),
                                //     style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey , fontFamily: 'Gilroy-SemiBold'),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  buildPynaWineMenu(BuildContext context, {int position = 0}) {
    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PynaWineMenu(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: position,
          scrollDirection:   verticalGallery ? Axis.vertical :  Axis.horizontal,
        ),
      ),
    );*/
    place['company_id'] = Environment.config.pyna_wine_company_Id;
    StoreDetailHelper.callOnlineOrderWebviewPage(
        context, place, BusinessAppMode.WINESHOP);
  }

  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

  Widget buildContainer111() {
    List list = place["details"];
    List listOffers;
    if (list != null && list.length > 0) {
      for (int i = 0; i < list.length; i++) {
        print(list[i]['company_key'].toString());
        if (list[i]['company_key'].toString().toLowerCase() ==
            "Offers".toLowerCase()) {
          print(list[i]["company_value"]);
          listOffers = json.decode(list[i]["company_value"]);
          print(listOffers);
          break;
        }
      }
    }
    if (listOffers == null || listOffers.length == 0) {
      return Text(
        "No offers available!",
        style: TextStyle(
            fontSize: FSTextStyle.h6size,
            color: FsColor.darkgrey,
            fontFamily: 'Gilroy-SemiBold'),
      );
    }
    return Column(
      children: List.generate(listOffers.length, (index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: FsColor.lightgrey.withOpacity(0.5),
            ),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: FsColor.primarypyna.withOpacity(0.2),
                ),
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                  listOffers[index]["offer_code"].toString().toUpperCase(),
                  style: TextStyle(
                      fontSize: FSTextStyle.h7size,
                      color: FsColor.primarypyna,
                      fontFamily: 'Gilroy-SemiBold'),
                ),
              ),
              Text(
                listOffers[index]["order_name"].toLowerCase(),
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-Regular'),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 250.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: multiple_location.length,
        itemBuilder: (BuildContext context, int index) {
          // print(detail['company_value'].toString());
          return Container(
            decoration:
                new BoxDecoration(border: new Border(bottom: new BorderSide())),
            child: ListTile(
              leading: Icon(
                Icons.call,
                color: FsColor.primarypyna,
              ),
              onTap: () {
                Navigator.pop(context);
                Map place = new Map();
                place["company_id"] = Environment.config.pyna_wine_company_Id;
                print("company id====" + place["company_id"].toString());
                FsFacebookUtils.callSubmitEvent(
                    BusinessAppMode.WINESHOP, shop_name_event);
                showDialogForNumberMasking(context, place, onlineOrderPresenter,
                    pynaNUmber: multiple_location[index]["number"],
                    companyId: place["company_id"].toString(),
                    color: FsColor.primarypyna);
                print(multiple_location[index]["number"]);
              },
              title: Text(multiple_location[index]["location"]),
            ),
          );
        },
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Select your nearest store ",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.primarypyna)),
          content: setupAlertDialoadContainer(),
        );
      },
    );
  }

  Widget getStoreTimeing() {
    bool isHaveValue = true;
    isHaveValue = GroceryStoreDetailsState.getDayTimingSatus(
        place, "STORE_TIMINGS_MONDAY");
    if (!isHaveValue) {
      isHaveValue = GroceryStoreDetailsState.getDayTimingSatus(
          place, "STORE_TIMINGS_Tuesday");
      if (!isHaveValue) {
        isHaveValue = GroceryStoreDetailsState.getDayTimingSatus(
            place, "STORE_TIMINGS_Wednesday");
        if (!isHaveValue) {
          isHaveValue = GroceryStoreDetailsState.getDayTimingSatus(
              place, "STORE_TIMINGS_Thursday");
          if (!isHaveValue) {
            isHaveValue = GroceryStoreDetailsState.getDayTimingSatus(
                place, "STORE_TIMINGS_Friday");
            if (!isHaveValue) {
              isHaveValue = GroceryStoreDetailsState.getDayTimingSatus(
                  place, "STORE_TIMINGS_Saturday");
              if (!isHaveValue) {
                isHaveValue = GroceryStoreDetailsState.getDayTimingSatus(
                    place, "STORE_TIMINGS_Sunday");
              }
            }
          }
        }
      }
    }
    if (isHaveValue) {
      return GestureDetector(
        onTap: () {
          showStoreTimingAlertDialog(context);
        },
        child: Row(
          children: <Widget>[
            getOpeningTime(
                DateFormat('EEEE').format(DateTime.now()).toString(), place),
            Icon(
              Icons.arrow_drop_down,
              size: FSTextStyle.h2size,
              color: FsColor.basicprimary,
            ),
            /*getOpeningTime("Monday", place),
            getOpeningTime("Tuesday", place),
            getOpeningTime("Wednesday", place),
            getOpeningTime("Thursday", place),
            getOpeningTime("Friday", place),
            getOpeningTime("Saturday", place),
            getOpeningTime("Sunday", place),*/
          ],
        ),
      );
    } else {
      return Text(
        'hours and Services may differ'.toLowerCase(),
        style: TextStyle(
            fontSize: FSTextStyle.h6size,
            color: FsColor.darkgrey,
            fontFamily: 'Gilroy-SemiBold'),
      );
    }
  }

  bool isEnableForTodayAccordingToTime = true;

  Widget getOpeningTime(String day, Map s) {
    String value;
    if (day.toLowerCase() == "Monday".toLowerCase()) {
      var dayTiming =
          GroceryStoreDetailsState.getDayTiming(place, "STORE_TIMINGS_MONDAY");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Tuesday".toLowerCase()) {
      var dayTiming =
          GroceryStoreDetailsState.getDayTiming(place, "STORE_TIMINGS_TUESDAY");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Wednesday".toLowerCase()) {
      var dayTiming = GroceryStoreDetailsState.getDayTiming(
          place, "STORE_TIMINGS_Wednesday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Thursday".toLowerCase()) {
      var dayTiming = GroceryStoreDetailsState.getDayTiming(
          place, "STORE_TIMINGS_Thursday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Friday".toLowerCase()) {
      var dayTiming =
          GroceryStoreDetailsState.getDayTiming(place, "STORE_TIMINGS_Friday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Saturday".toLowerCase()) {
      var dayTiming = GroceryStoreDetailsState.getDayTiming(
          place, "STORE_TIMINGS_Saturday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Sunday".toLowerCase()) {
      var dayTiming =
          GroceryStoreDetailsState.getDayTiming(place, "STORE_TIMINGS_SUNDAY");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    }
    if (value != null) {
      var date = DateTime.now();
      bool isToday = false;
      String value2 = "";
      if (DateFormat('EEEE').format(date).toString() == day) {
        try {
          isToday = true;
          List timing = value.trim().split(" ");
          print(timing);
          DateTime open = DateTime.now();
          DateTime close = DateTime.now();
          DateFormat dateFormat = new DateFormat("dd-MM-yyyy hh:mma");
          String s = new DateFormat("dd-MM-yyyy").format(open);
          print(timing[0]);
          print(timing[1]);
          open = dateFormat.parse("${s} ${timing[0].toString().toUpperCase()}");
          close =
              dateFormat.parse("${s} ${timing[1].toString().toUpperCase()}");
          print(open);
          print(close);
          DateTime currentTime = DateTime.now();
          if (currentTime.isAfter(open) && currentTime.isBefore(close)) {
            value2 = " now open";
            isEnableForTodayAccordingToTime = true;
            setState(() {});
          } else {
            value2 = " closed";
            //isEnableForTodayAccordingToTime = false;
            isEnableForTodayAccordingToTime = true;
            setState(() {
              isEnableForTodayAccordingToTime = true;
            });
          }
        } catch (e) {
          print(e);
        }
      }
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              child: Text(
                '${GroceryStoreDetailsState.getWeekDayInSmall(day)} :'
                    .toLowerCase(),
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-SemiBold'),
              ),
            ),
            /*Container(
              child: Text(
                ': '.toLowerCase(),
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-SemiBold'),
              ),
            ),*/
            Container(
              child: Text(
                "${value.trim().replaceAll(" ", "-")}".toLowerCase(),
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-SemiBold'),
              ),
            ),
            /*Container(
              width: 50,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${getWeekDayInSmall(day)} : ${value.trim().replaceAll(" ", "-")}'
                      .toLowerCase(),
                  style: TextStyle(
                      fontSize: FSTextStyle.h6size,
                      color: isToday ? FsColor.black : FsColor.darkgrey,
                      fontFamily: 'Gilroy-SemiBold'),
                ),
              ),
            ),*/
            isToday
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${value2}'.toLowerCase(),
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          color:
                              value2 == " closed" ? FsColor.red : FsColor.green,
                          fontFamily: 'Gilroy-SemiBold'),
                    ),
                  )
                : Container(),
          ],
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topLeft,
        child: Text(
          '${GroceryStoreDetailsState.getWeekDayInSmall(day)} : close'
              .toLowerCase(),
          style: TextStyle(
              fontSize: FSTextStyle.h6size,
              color: FsColor.red,
              fontFamily: 'Gilroy-SemiBold'),
        ),
      );
    }
  }

  String getWhatsAppNumber() {
    var string = AppUtils.getCallNumber(place)[0].toString();
    if (string.length == 10) {
      return "91" + string;
    } else {
      return string;
    }
  }

  void showErrorAlertDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text(title,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text(msg,
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
                  "Ok",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              )
            ],
          );
        });
  }

  void showStoreTimingAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Opening Hours",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                getOpeningTime("Monday", place),
                getOpeningTime("Tuesday", place),
                getOpeningTime("Wednesday", place),
                getOpeningTime("Thursday", place),
                getOpeningTime("Friday", place),
                getOpeningTime("Saturday", place),
                getOpeningTime("Sunday", place),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              )
            ],
          );
        });
  }

  void shareMsg(BuildContext context, Map place) {
    // final RenderBox box = context.findRenderObject();
    /*Share.share(getStoreDetail(place),
        subject: "",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    */
    Map my_data = {
      "c_id": Environment.config.pyna_wine_company_Id,
      "s_ty": "W"
    };
    FirebaseDynamicLink.getLink(
            place["company_name"], place["address"], "share_pyna_wine",
            data: my_data)
        .then((uri) async {
      print(uri);
      String s =
          "Hey, I found Pyna Wines on oneapp! \nFree Home Delivery \nDigital Payments"
          "\nOrder now \nDownload oneapp now and order online easily.\n${uri}";
      final RenderBox box = context.findRenderObject();
      FsFacebookUtils.shareSubmitEvent(
          BusinessAppMode.WINESHOP, shop_name_event);
      FsShare().myShare(context, s);
    });
  }

  void getCompanyDetail() {
    onlineOrderPresenter = new OnlineOrderPresenter(this);
    onlineOrderPresenter.getCompanyDetail(
        Environment()
            .getCurrentConfig()
            .pyna_wine_company_Id,
        callingType: "company_details");
  }

  @override
  error(error, {callingType}) async {
    isLoading = false;
    setState(() {});
    print(error);
    var result = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    if (result != null && result["connection"]) {
      getCompanyDetail();
    }
  }

  @override
  failure(error, {callingType}) {
    print(error);
    isLoading = false;
    Toasly.error(context, AppUtils.errorDecoder(error));
    setState(() {});
  }

  Map og_company;
  var detail;
  String delivery_detail;
  List multiple_location = [];

  /*List item = [];
  List number = [];*/

  Future<void> callIntent(BuildContext context, Map place) async {
    String url = "";
    print("..................................::::::::::::" +
        Environment.config.name);

    if (Environment.config.name == "production") {
      url = "tel:0${02248966550}";
      print("production env ${url.toString()}");
    } else {
      url = "tel:${09513886363}";
    }

//url for call on fix number

    await AppUtils.launchUrl(url);
  }

  @override
  success(success, {callingType}) async {
    print("SussssssPynaWines");
    if (callingType == "number_masking") {
      callIntent(context, place);
      return;
    }
    print(
        "og company else part....................................${
            og_company = success['data']}");
    print(
        "::::::::::::::::::::::::::::::::::::::::::::${og_company["details"]}");
    for (int i = 0; i < og_company["details"].length; i++) {
      print(og_company["details"][i]['company_key'].toString());
      if (og_company["details"][i]['company_key'].toString().toLowerCase() ==
          "delivery_msg".toLowerCase()) {
        delivery_detail = og_company["details"][i]["company_value"];
        print(og_company["details"][i]["company_value"]);
        break;
      }
    }
    for (var item in og_company["details"]) {
      detail = item["company_value"];
    }
    var location_data = json.decode(detail);
    for (int i = 0; i < location_data["locations"].length; i++) {
      Map locationWithNumber = new Map();
      locationWithNumber["location"] =
      (location_data["locations"][i]["location"]);
      locationWithNumber["number"] = (location_data["locations"][i]["number"]);
      multiple_location.add(locationWithNumber);
    }

    mapData();
    isLoading = false;
    setState(() {});
  }
}
