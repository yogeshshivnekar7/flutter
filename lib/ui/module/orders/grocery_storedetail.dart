import 'dart:io';
import 'dart:ui';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/firebase/firebase_dynamiclink.dart';
import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:device_info/device_info.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/orders/location_selection_helper.dart';
import 'package:sso_futurescape/ui/module/orders/old_order.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/number_masking_alertbox.dart';
import 'package:sso_futurescape/ui/module/sso/profile/map/simple_map.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/fsshare.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'grocery_buyanything.dart';
import 'store_detail_helper.dart';

class GroceryStoreDetails extends StatefulWidget {
  BusinessAppMode businessAppMode;
  Map place;
  Map address;
  String compnay_id;

  GroceryStoreDetails(this.businessAppMode, this.place, this.address,
      {this.compnay_id});

  @override
  GroceryStoreDetailsState createState() =>
      new GroceryStoreDetailsState(businessAppMode, place, address,
          compnay_id: compnay_id);
}

class GroceryStoreDetailsState extends State<GroceryStoreDetails>
    implements OnlineOrderView {
  var place;
  var address;
  String compnay_id;
  var businessAppMode;
  OnlineOrderPresenter onlineOrderPresenter;

//  var deliveryRange;
  GroceryStoreDetailsState(this.businessAppMode, this.place, this.address,
      {this.compnay_id}) {}

  TextEditingController userNameController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  bool isShowShare = false;
  bool whatsapp = false;
  var userDetails;
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    if (address == null) {
      SsoStorage.getPreferredAddress().then((address1) async {
        address = address1;
        
        if (address == null) {
          Map _userProfie = await SsoStorage.getUserProfile();
          print("......................................................"+_userProfie.toString());
          List addresses = _userProfie["addresses"];
          if (addresses != null) {

            addresses = addresses

                .where((element) =>
                    element["latitude"] != null &&
                    element["latitude"] != "null")
                .toList();
            if (addresses.length > 0) {
              address = addresses[0];
            }
          }
        }
        onlineOrderPresenter = new OnlineOrderPresenter(this);
        checkShareButton();
        if (Platform.isIOS) {
          checkWhatsApp();
        }
        if (place != null) {
          isLoading = false;
          getStoreTimeing();
          mapData();
          FsFacebookUtils.storeDetailEvent(
              businessAppMode, place["company_name"]);
        } else {
          isLoading = true;
          getCompanyDetail(compnay_id);
        }
      });
    } else {
      //userdata
          var _userProfie = SsoStorage.getUserProfile().then((value) async{
            if(mounted)
            print(value);
          });
          print(".......................user..............................."+_userProfie.toString());
    
      onlineOrderPresenter = new OnlineOrderPresenter(this);
      checkShareButton();
      if (Platform.isIOS) {
        checkWhatsApp();
      }
      if (place != null) {
        isLoading = false;
        getStoreTimeing();
        mapData();
        FsFacebookUtils.storeDetailEvent(
            businessAppMode, place["company_name"]);
      } else {
        isLoading = true;
        getCompanyDetail(compnay_id);
      }
    }
  }
  
  

  void getCompanyDetail(String company_id) {
    OnlineOrderPresenter onlineOrderPresenter = new OnlineOrderPresenter(this);
    if (address != null) {
      onlineOrderPresenter.getCompanyDetail(company_id.toString(),
          callingType: "company_details",
          latitude: address["latitude"],
          longitude: address["longitude"]);
    } else
      onlineOrderPresenter.getCompanyDetail(company_id.toString(),
          callingType: "company_details");
  }

  Future checkWhatsApp() async {
    whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");
    setState(() {});
  }

  Future<void> checkShareButton() async {
    bool a = await FsShare.isIpad();
    isShowShare = !a;
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: getPrimaryColor(),
        elevation: 0.0,
        title: new Text(
          'Store details'.toLowerCase(),
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
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: FsColor.lightgrey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: storeDetails["image"] == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          storeDetails["default_image"],
                                          height: 76,
                                          width: 76,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : FadeInImage(
                                        image:
                                            NetworkImage(storeDetails["image"]),
                                        placeholder: AssetImage(
                                            storeDetails["default_image"]),
                                        height: 76,
                                        width: 76,
                                        fit: BoxFit.cover),
                              ),
                              Container(
                                width: 76,
                                color: FsColor.primarygrocery,
                                child: Text(
                                  businessAppMode != BusinessAppMode.WINESHOP &&
                                          (!storeDetails[
                                                  "enable_online_order"] ||
                                              !isEnableForTodayAccordingToTime)
                                      ? 'Offline'
                                      : "Online".toLowerCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  storeDetails["company_name"],
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h5size,
                                      color: FsColor.basicprimary,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 3),
                                storeDetails["category"] != null
                                    ? Text(
                                        storeDetails["category"],
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h7size,
                                            color: FsColor.lightgrey,
                                            fontFamily: 'Gilroy-SemiBold'),
                                      )
                                    : Container(),
                                SizedBox(height: 5),
                                Text(
                                  storeDetails["locality"],
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.darkgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                /*SizedBox(height: 3),
                          Text(
                            storeDetails["phone_no"],
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                                fontFamily: 'Gilroy-Regular'),
                          ),*/
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  businessAppMode != BusinessAppMode.WINESHOP &&
                          (!storeDetails["enable_online_order"] ||
                              !isEnableForTodayAccordingToTime)
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFf57639),
                          ),
                          child: Text(
                            'Shop offline now, call to order'.toLowerCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.white,
                                fontFamily: 'Gilroy-Regular'),
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: FsColor.lightgrey.withOpacity(0.5),
                      ),
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
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: AppUtils.getCallNumber(place) !=
                                            null &&
                                        isTodayOpen
                                    ? () {
                                      showDialogForNumberMasking(context,place,onlineOrderPresenter,color: FsColor.primarygrocery);
                                      // _showDialog();
                                      }
                                    : null,
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
                                      child: Icon(FlutterIcon.phone_1,
                                          color:
                                          AppUtils.getCallNumber(place) ==
                                              null ||
                                              !isTodayOpen
                                              ? FsColor.darkgrey
                                              .withOpacity(0.5)
                                              : FsColor.darkgrey,
                                          size: FSTextStyle.h4size),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Call Now',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h7size,
                                          color:
                                          AppUtils.getCallNumber(place) ==
                                              null ||
                                              !isTodayOpen
                                              ? FsColor.basicprimary
                                              .withOpacity(0.5)
                                              : FsColor.basicprimary,
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
                                  callMap(context);
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
                                      child: Icon(FlutterIcon.location_1,
                                          color: FsColor.darkgrey,
                                          size: FSTextStyle.h4size),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Direction',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h7size,
                                          color: FsColor.basicprimary,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // FsPlatform.isAndroid() ||
                            //         (FsPlatform.isIos() && whatsapp)
                            //     ? Expanded(
                            //         child: FlatButton(
                            //           padding: EdgeInsets.all(0),
                            //           onPressed: AppUtils.getCallNumber(
                            //                           place) !=
                            //                       null &&
                            //                   isEnableForTodayAccordingToTime
                            //               ? () async {
                            //                   try {
                            //                     /*FlutterOpenWhatsapp.sendSingleMessage(
                            //       getWhatsAppNumber(),
                            //       "Hi. I found your business on OneApp.");
                            // */

                            //                     /* String url =
                            //             "https://wa.me/${getWhatsAppNumber()}?text=Hi. I found your business on OneApp.";
                            //         if (await canLaunch(url)) {
                            //           await launch(url);
                            //         } else {

                            //           //throw 'Could not launch $url';
                            //         }*/

                            //                     var whatsAppNumber =
                            //                         getWhatsAppNumber(place);
                            //                     if (!FsPlatform.isAndroid()) {
                            //                       if (whatsapp) {
                            //                         FsFacebookUtils
                            //                             .whatsAppSubmitEvent(
                            //                                 businessAppMode,
                            //                                 place[
                            //                                     "company_name"]);
                            //                         whatsAppNumber =
                            //                             whatsAppNumber
                            //                                 .replaceAll(
                            //                                     "+", " ")
                            //                                 .trim();
                            //                         await FlutterLaunch
                            //                             .launchWathsApp(
                            //                             phone:
                            //                             whatsAppNumber,
                            //                             message:
                            //                             "Hi. I found your business on OneApp.");
                            //                       } else {
                            //                         showErrorAlertDialog(
                            //                             context,
                            //                             "Install WhatsApp!",
                            //                             "Looks like WhatsApp is not installed in your device. You may either install WhatsApp or Call to place your order.");
                            //                       }
                            //                     } else {
                            //                       FsFacebookUtils
                            //                           .whatsAppSubmitEvent(
                            //                           businessAppMode,
                            //                           place[
                            //                           "company_name"]);
                            //                       FlutterOpenWhatsapp
                            //                           .sendSingleMessage(
                            //                           whatsAppNumber,
                            //                           "Hi. I found your business on OneApp.");
                            //                     }
                            //                   } catch (e) {
                            //                     Toasly.error(context,
                            //                         "Sorry unable to open whatsApp");
                            //                   }
                            //           }
                            //               : null,
                            //           child: Column(
                            //             children: [
                            //               Container(
                            //                 width: 40,
                            //                 height: 40,
                            //                 padding: EdgeInsets.fromLTRB(
                            //                     0, 10, 0, 10),
                            //                 decoration: BoxDecoration(
                            //                   borderRadius:
                            //                   BorderRadius.circular(35),
                            //                   border: Border.all(
                            //                     width: 1.0,
                            //                     color: FsColor.lightgrey
                            //                         .withOpacity(0.5),
                            //                   ),
                            //                 ),
                            //                 child: Icon(FlutterIcon.whatsapp,
                            //                     color: AppUtils.getCallNumber(
                            //                         place) ==
                            //                         null ||
                            //                         !isEnableForTodayAccordingToTime
                            //                         ? FsColor.darkgrey
                            //                         .withOpacity(0.5)
                            //                         : FsColor.darkgrey,
                            //                     size: FSTextStyle.h4size),
                            //               ),
                            //               SizedBox(height: 10),
                            //               Text(
                            //                 'Whatsapp',
                            //                 style: TextStyle(
                            //                     fontSize: FSTextStyle.h7size,
                            //                     color: AppUtils.getCallNumber(
                            //                         place) ==
                            //                         null ||
                            //                         !isEnableForTodayAccordingToTime
                            //                         ? FsColor.basicprimary
                            //                         .withOpacity(0.5)
                            //                         : FsColor.basicprimary,
                            //                     fontFamily: 'Gilroy-SemiBold'),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            // )
                            //     : Container(),
                            true != true
                                ? Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  Toasly.error(
                                      context, "No menu available");
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(35),
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
                            )
                                : Container(),
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  showStoreTimingAlertDialog(context);
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
                                      child: Icon(FlutterIcon.clock_1,
                                          color: FsColor.darkgrey,
                                          size: FSTextStyle.h4size),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Timings',
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
                        storeDetails["enable_online_order"] &&
                            storeDetails["enable_online_order"] != null &&
                            address != null &&
                            storeDetails["in_range"] != null &&
                            storeDetails["in_range"] == '1'
                            ? Container(
                            height: 32,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: RaisedButton(
                              padding:
                              EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(4.0),
                              ),
                              onPressed: storeDetails[
                              "enable_online_order"] &&
                                  isEnableForTodayAccordingToTime
                                  ? () {
                                SsoStorage.getUserProfile()
                                    .then((profile) {
                                  var _userProfiew = profile;
                                  // if (!isSocietyAdded) {
                                  bool isUnNotSet = false;
                                  if (_userProfiew["first_name"] ==
                                      null ||
                                      _userProfiew["first_name"]
                                          .toString()
                                          .isEmpty) {
                                    isUnNotSet = true;
                                  }
                                  if (isUnNotSet) {
                                    UpdateProfileDialog(context, () {
                                      StoreDetailHelper(context)
                                          .termsDialog(
                                          context,
                                          businessAppMode,
                                          storeDetails,
                                                        shoeBottom: false);
                                                //  _termsDialog();
                                    },
                                        name: isUnNotSet,
                                        email: false);
                                  } else {
                                    StoreDetailHelper(context)
                                        .termsDialog(
                                        context,
                                        businessAppMode,
                                        storeDetails,
                                        shoeBottom: false);
                                    // _termsDialog();
                                  }
                                });
                              }
                                  : null,
                              child: Text(
                                'Order Now',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                              color: storeDetails["enable_online_order"] &&
                                  isEnableForTodayAccordingToTime
                                  ? OnlineOrderWebViewState.backgroundColor(
                                  businessAppMode)
                                  : FsColor.lightgrey,
                              textColor: FsColor.white,
                            ))
                            : Container(),
                        storeDetails["enable_online_order"] &&
                            storeDetails["enable_online_order"] != null &&
                            storeDetails["in_range"] != null &&
                            storeDetails["in_range"] == '0' &&
                            address != null
                            ? GestureDetector(
                          onTap: () {
                            selectAddress(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                          width: 1.0,
                                          color:
                                          FsColor.lightgrey.withOpacity(0.5),
                                        ))),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 10, 10, 0),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      width: 36,
                                      height: 36,
                                      child: SizedBox(
                                        width: 36,
                                        height: 36,
                                        child: Icon(
                                            Icons.remove_shopping_cart,
                                            color: FsColor.red,
                                            size: FSTextStyle.h4size),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Does not deliver to ${StoreDetailHelper
                                                .getSubHeader(address)}'
                                                .toLowerCase(),
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h6size,
                                                color: FsColor.lightgrey,
                                                fontFamily:
                                                'Gilroy-SemiBold'),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "this store doesn't deliver to your selected address"
                                                .toLowerCase(),
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h7size,
                                                color: FsColor.red,
                                                fontFamily:
                                                'Gilroy-SemiBold'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 36,
                                      height: 36,
                                      child: SizedBox(
                                        width: 36,
                                        height: 36,
                                        child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: FsColor.red,
                                            size: FSTextStyle.h4size),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                            : Container(),
                        storeDetails["enable_online_order"] &&
                            storeDetails["enable_online_order"] != null &&
                            address == null
                            ? GestureDetector(
                          onTap: () {
                            selectAddress(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                          width: 1.0,
                                          color:
                                          FsColor.lightgrey.withOpacity(0.5),
                                        ))),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 10, 10, 0),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      width: 36,
                                      height: 36,
                                      child: SizedBox(
                                        width: 36,
                                        height: 36,
                                        child: Icon(
                                            Icons.remove_shopping_cart,
                                            color: FsColor.red,
                                            size: FSTextStyle.h4size),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'No address selected'
                                                .toLowerCase(),
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h6size,
                                                color: FsColor.lightgrey,
                                                fontFamily:
                                                'Gilroy-SemiBold'),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "please select a location to see delivery status of the store"
                                                .toLowerCase(),
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h7size,
                                                color: FsColor.red,
                                                fontFamily:
                                                'Gilroy-SemiBold'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 36,
                                      height: 36,
                                      child: SizedBox(
                                        width: 36,
                                        height: 36,
                                        child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: FsColor.red,
                                            size: FSTextStyle.h4size),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                            : Container(),
                        (!storeDetails["enable_online_order"] ||
                            storeDetails["enable_online_order"] ==
                                null) &&
                            AppUtils.getCallNumber(place) != null
                            ? Container(
                            height: 32,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: RaisedButton(
                              padding:
                              EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(4.0),
                              ),
                              onPressed:
                              AppUtils.getCallNumber(place) != null &&
                                  isEnableForTodayAccordingToTime
                                  ? () {
                                // callIntent(context, place);
                                // _showDialog();
                                      showDialogForNumberMasking(context,place,onlineOrderPresenter);

                              }
                                  : null,
                              child: Text(
                                "Call to order",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                              color: isEnableForTodayAccordingToTime
                                  ? OnlineOrderWebViewState.backgroundColor(
                                  businessAppMode)
                                  : FsColor.lightgrey,
                              textColor: FsColor.white,
                            ))
                            : Container(),
                        true != true
                            ? Container(
                            height: 32,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: OutlineButton(
                              padding:
                              EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(4.0),
                              ),
                              onPressed: isMoneyKeyAvailable
                                  ? () {
                                oldOrderPage();
                              }
                                  : null,
                              child: Text(
                                'Order History',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                              borderSide: BorderSide(
                                  width: 1, color: FsColor.darkgrey),
                              // color: FsColor.darkgrey,
                              textColor: FsColor.basicprimary,
                            ))
                            : Container(),
                      ],
                    ),
                  ),
                  // !isTodayOpen
                  //     ? Container()
                  //     : Container(
                  //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //   padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  //   decoration: BoxDecoration(
                  //       border: Border(
                  //           bottom: BorderSide(
                  //             width: 1.0,
                  //             color: FsColor.lightgrey.withOpacity(0.5),
                  //           ))),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       SizedBox(
                  //         width: 36,
                  //         height: 36,
                  //         child: Icon(FlutterIcon.phone_1,
                  //             color: getPrimaryColor(),
                  //             size: FSTextStyle.h4size),
                  //       ),
                  //       SizedBox(width: 5),
                  //       Expanded(
                  //         child: Container(
                  //           margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  //           alignment: Alignment.topLeft,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment:
                  //             CrossAxisAlignment.start,
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
                  //                 AppUtils.getCallNumber(place) == null
                  //                     ? "No details available"
                  //                     .toLowerCase()
                  //                     : AppUtils.getCallNumber(place)
                  //                     .join(","),
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
                  Container(
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
                            child: Icon(FlutterIcon.map_pin,
                                color: getPrimaryColor(),
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
                                'Address : '.toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.lightgrey,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                              SizedBox(height: 5),
                              Text(
                                storeDetails["address"].toLowerCase(),
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
                  ),
                  storeDetails["minimum_order"] != null &&
                      storeDetails["minimum_order"] != 'null'
                      ? Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                        Container(
                          alignment: Alignment.center,
                          width: 36,
                          height: 36,
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: Icon(FlutterIcon.money,
                                color: getPrimaryColor(),
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
                                    storeDetails["minimum_order"]
                                        .toLowerCase(),
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
                  true == true
                      ? Container()
                      : Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                        Container(
                            alignment: Alignment.topCenter,
                            width: 36,
                            height: 36,
                            child: SizedBox(
                              width: 36,
                              height: 36,
                              child: Icon(FlutterIcon.clock_1,
                                  color: getPrimaryColor(),
                                  size: FSTextStyle.h4size),
                            )),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                /*Text(
                            'Open now : '.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.green,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),*/
                                Text(
                                  'Store Timings : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),
                                getStoreTimeing(),
                                /*Text(
                            'tue : 11am - 10pm'.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),
                          Text(
                            'wed : 11am - 10pm'.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey,
                                fontFamily: 'Gilroy-SemiBold'),
                          ),*/
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  place['cuisine'] != null &&
                      businessAppMode == BusinessAppMode.RESTAURANT
                      ? Container(
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
                          child: Icon(FlutterIcon.food,
                              color: getPrimaryColor(),
                              size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Cuisines : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  place['cuisine'].toLowerCase(),
                                  // 'South india, North India, Chinese, Fast Food'
                                  // .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.darkgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                  place['cost_for_two'] != null &&
                      businessAppMode == BusinessAppMode.RESTAURANT
                      ? Container(
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
                          child: Icon(FlutterIcon.money,
                              color: getPrimaryColor(),
                              size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Average Cost : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "₹" +
                                      "${place['cost_for_two']} for two people (approx)"
                                          .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.darkgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                  AppUtils.getValueFromKey("payment_mode", place) != null
                      ? Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                          child: Icon(FlutterIcon.credit_card,
                              color: getPrimaryColor(),
                              size: FSTextStyle.h5size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Mode: '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Make Payment Using ${AppUtils
                                      .getValueFromKey("payment_mode", place)
                                      .join(",")}'
                                      .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.darkgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                  AppUtils.getValueFromKey("delivery_type", place) != null
                      ? Container(
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
                          child: Icon(FlutterIcon.info_circled,
                              color: getPrimaryColor(),
                              size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Other Info : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.lightgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 24,
                                      height: 24,
                                      child: AppUtils
                                          .isDeliveryOpionAvaile(
                                          place, "delivery")
                                          ? Icon(FlutterIcon.ok_circled2,
                                          color: FsColor.green,
                                          size: FSTextStyle.h5size)
                                          : Icon(
                                          FlutterIcon.cancel_circled2,
                                          color: FsColor.red,
                                          size: FSTextStyle.h5size),
                                    ),
                                    Text(
                                      "Home Delivery".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 24,
                                      height: 24,
                                      child: AppUtils
                                          .isDeliveryOpionAvaile(
                                          place, "pickup")
                                          ? Icon(FlutterIcon.ok_circled2,
                                          color: FsColor.green,
                                          size: FSTextStyle.h5size)
                                          : Icon(
                                          FlutterIcon.cancel_circled2,
                                          color: FsColor.red,
                                          size: FSTextStyle.h5size),
                                    ),
                                    Text(
                                      "Pickup".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                  ],
                                ),
                                /*Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 24,
                                height: 24,
                                child: Icon(FlutterIcon.ok_circled2,
                                    color: FsColor.green,
                                    size: FSTextStyle.h5size),
                              ),
                              Text(
                                "Parking".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.darkgrey,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 24,
                                height: 24,
                                child: Icon(FlutterIcon.cancel_circled2,
                                    color: FsColor.red,
                                    size: FSTextStyle.h5size),
                              ),
                              Text(
                                "Serve Alchohol".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.darkgrey,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 24,
                                height: 24,
                                child: Icon(FlutterIcon.cancel_circled2,
                                    color: FsColor.red,
                                    size: FSTextStyle.h5size),
                              ),
                              Text(
                                "Indoor Seating".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.darkgrey,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                            ],
                          ),*/
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                  true != true
                      ? Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.center,
                                  width: 36,
                                  height: 36,
                                  child: SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Icon(FlutterIcon.star_empty_1,
                                        color: getPrimaryColor(),
                                        size: FSTextStyle.h3size),
                                  )),
                              SizedBox(width: 5),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Review & Ratings'.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.darkgrey,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.fromLTRB(51, 0, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                border: Border.all(
                                    width: 1.0,
                                    color: FsColor.lightgrey
                                        .withOpacity(0.3)),
                              ),
                              child: FlatButton(
                                onPressed: null,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(FlutterIcon.star_1,
                                    color: FsColor.yellow,
                                    size: FSTextStyle.h3size),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                border: Border.all(
                                    width: 1.0,
                                    color: FsColor.lightgrey
                                        .withOpacity(0.3)),
                              ),
                              child: FlatButton(
                                onPressed: null,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(FlutterIcon.star_1,
                                    color: FsColor.yellow,
                                    size: FSTextStyle.h3size),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                border: Border.all(
                                    width: 1.0,
                                    color: FsColor.lightgrey
                                        .withOpacity(0.3)),
                              ),
                              child: FlatButton(
                                onPressed: null,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(FlutterIcon.star_1,
                                    color: FsColor.yellow,
                                    size: FSTextStyle.h3size),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                border: Border.all(
                                    width: 1.0,
                                    color: FsColor.lightgrey
                                        .withOpacity(0.3)),
                              ),
                              child: FlatButton(
                                onPressed: null,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(FlutterIcon.star_empty_1,
                                    color: FsColor.darkgrey,
                                    size: FSTextStyle.h3size),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                border: Border.all(
                                    width: 1.0,
                                    color: FsColor.lightgrey
                                        .withOpacity(0.3)),
                              ),
                              child: FlatButton(
                                onPressed: null,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(FlutterIcon.star_empty_1,
                                    color: FsColor.darkgrey,
                                    size: FSTextStyle.h3size),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(51, 0, 10, 10),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                        child: TextField(
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.basicprimary,
                              fontFamily: 'Gilroy-Regular'),
                          decoration: InputDecoration(
                              hintText: "Write review".toLowerCase(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: getPrimaryColor()))),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(51, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 42,
                                height: 42,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: FsColor.green,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                  border: Border.all(
                                      width: 1.0,
                                      color: FsColor.lightgrey
                                          .withOpacity(0.3)),
                                ),
                                child: Text(
                                  '4.5',
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h4size,
                                      color: FsColor.white,
                                      fontFamily: 'Gilroy-SemiBold'),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '542 Ratings'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.darkgrey,
                                            fontFamily:
                                            'Gilroy-SemiBold'),
                                      ),
                                      Text(
                                        'oneapp rating index based on 542 rating across the app'
                                            .toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h7size,
                                            color: FsColor.lightgrey,
                                            fontFamily: 'Gilroy-Regular'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          'User Review'.toLowerCase(),
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.darkgrey,
                              fontFamily: 'Gilroy-SemiBold'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          'No user review, Be the first to add a review',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.lightgrey,
                              fontFamily: 'Gilroy-SemiBold'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: FsColor.lightgrey.withOpacity(0.5),
                                ))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 42,
                                  height: 42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    border: Border.all(
                                        width: 1.0,
                                        color: FsColor.lightgrey
                                            .withOpacity(0.3)),
                                  ),
                                  child: Image.asset(
                                    "images/default.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Container(
                                    margin:
                                    EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Pravin Shinde'.toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle.h6size,
                                              color: FsColor.darkgrey,
                                              fontFamily:
                                              'Gilroy-SemiBold'),
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '5.0'.toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle.h6size,
                                                  color: FsColor
                                                      .basicprimary,
                                                  fontFamily:
                                                  'Gilroy-SemiBold'),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '30 apr, 2020  |  08:23PM '
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle.h7size,
                                              color: FsColor.lightgrey,
                                              fontFamily:
                                              'Gilroy-SemiBold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(
                                'Lorem ipsum dolor sit amet is a simply text used for typesetting & alignment'
                                    .toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.darkgrey,
                                    fontFamily: 'Gilroy-Regular'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: FsColor.lightgrey.withOpacity(0.5),
                                ))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 42,
                                  height: 42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    border: Border.all(
                                        width: 1.0,
                                        color: FsColor.lightgrey
                                            .withOpacity(0.3)),
                                  ),
                                  child: Image.asset(
                                    "images/default.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Container(
                                    margin:
                                    EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Pravin Shinde'.toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle.h6size,
                                              color: FsColor.darkgrey,
                                              fontFamily:
                                              'Gilroy-SemiBold'),
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '5.0'.toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle.h6size,
                                                  color: FsColor
                                                      .basicprimary,
                                                  fontFamily:
                                                  'Gilroy-SemiBold'),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '30 apr, 2020  |  08:23PM '
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle.h7size,
                                              color: FsColor.lightgrey,
                                              fontFamily:
                                              'Gilroy-SemiBold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(
                                'Lorem ipsum dolor sit amet is a simply text used for typesetting & alignment'
                                    .toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.darkgrey,
                                    fontFamily: 'Gilroy-Regular'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: FsColor.lightgrey.withOpacity(0.5),
                                ))),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 42,
                                  height: 42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    border: Border.all(
                                        width: 1.0,
                                        color: FsColor.lightgrey
                                            .withOpacity(0.3)),
                                  ),
                                  child: Image.asset(
                                    "images/default.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Container(
                                    margin:
                                    EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Pravin Shinde'.toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle.h6size,
                                              color: FsColor.darkgrey,
                                              fontFamily:
                                              'Gilroy-SemiBold'),
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '5.0'.toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle.h6size,
                                                  color: FsColor
                                                      .basicprimary,
                                                  fontFamily:
                                                  'Gilroy-SemiBold'),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                            Icon(FlutterIcon.star_1,
                                                color: FsColor.yellow,
                                                size: FSTextStyle.h6size),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '30 apr, 2020  |  08:23PM '
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle.h7size,
                                              color: FsColor.lightgrey,
                                              fontFamily:
                                              'Gilroy-SemiBold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(
                                'Lorem ipsum dolor sit amet is a simply text used for typesetting & alignment'
                                    .toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.darkgrey,
                                    fontFamily: 'Gilroy-Regular'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : Container(),
                ],
              ),
      ),
    );
    setState(() {});
    return widget;
  }

  void selectAddress(BuildContext context) {
    LocationSelectionHelper()
        .getLocationBottomSheeOrCurrentLocation(context, true, (var address) {
      this.address = address;
      SsoStorage.setPreferredAddress(address);
      getCompanyDetail(compnay_id);
      isLoading = true;
      setState(() {});
    }, () {}, isOnlyLocationSelection: false, businessAppMode: businessAppMode);
  }

  Widget getStoreTimeing() {
    bool isHaveValue = true;
    isHaveValue = getDayTimingSatus(place, "STORE_TIMINGS_MONDAY");
    if (!isHaveValue) {
      isHaveValue = getDayTimingSatus(place, "STORE_TIMINGS_Tuesday");
      if (!isHaveValue) {
        isHaveValue = getDayTimingSatus(place, "STORE_TIMINGS_Wednesday");
        if (!isHaveValue) {
          isHaveValue = getDayTimingSatus(place, "STORE_TIMINGS_Thursday");
          if (!isHaveValue) {
            isHaveValue = getDayTimingSatus(place, "STORE_TIMINGS_Friday");
            if (!isHaveValue) {
              isHaveValue = getDayTimingSatus(place, "STORE_TIMINGS_Saturday");
              if (!isHaveValue) {
                isHaveValue = getDayTimingSatus(place, "STORE_TIMINGS_Sunday");
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

  static String getWhatsAppNumber(Map place) {
    var string = AppUtils.getCallNumber(place)[0].toString();
    if (string.length == 10) {
      return "91" + string;
    } else {
      return string;
    }
  }

  Color getPrimaryColor() {
    return OnlineOrderWebViewState.backgroundColor(businessAppMode);
  }

  void _ordernowBottomSheet(context) {
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
                        callOnlineOrderPage(context, showBottom: false);
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
                            showDialogForNumberMasking(context,place,onlineOrderPresenter);

                        // _showDialog();
                        // Navigator.pop(context);
                        // callIntent(context, place);
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
                        buyAnything(context);
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

  void buyAnything(BuildContext context) {
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

  void callMap(BuildContext context) {
    try {
      print(place["latitude"].toString());
      print(place["longitude"].toString());
      FsFacebookUtils.directionSubmitEvent(
          businessAppMode, place['company_name']);
      MapSample.openMap(
          place["latitude"].toString(), place["longitude"].toString());
    } catch (e) {
      print(e);
      print("googleUrl11111111");
      Toasly.error(context, 'Could not open the map.');
    }
  }

  Future<bool> _isIpad() async {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    return iosInfo.name.toLowerCase().contains('ipad');
  }

  void shareMsg(BuildContext context, Map place) {
    // final RenderBox box = context.findRenderObject();
    /*Share.share(getStoreDetail(place),
        subject: "",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    */
    Map my_data = {
      "c_id": place['company_id'],
      "s_ty": EnumToString.parse(businessAppMode).substring(0, 1)
    };
    FirebaseDynamicLink.getLink(place["company_name"], storeDetails["address"],
            "share_store_${place["company_name"]}_${place["company_id"]}",
            data: my_data)
        .then((uri) async {
      print(uri);
      String s =
          "Hey, I found ${place["company_name"]} ${getTypeDetail()} on oneapp! "
          "Giving home deliveries at your ease. Stay home stay safe. Download 'oneapp' now! ${uri}";
      final RenderBox box = context.findRenderObject();
      FsFacebookUtils.shareSubmitEvent(businessAppMode, place["company_name"]);
      FsShare().myShare(context, s, subject: "");
    });
  }

  String getTypeDetail() {
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      return "restaurant";
    } else {
      return "grocery shop";
    }
  }

  bool isTodayOpen = false;

  String getStoreDetail(Map<dynamic, dynamic> place) {
    return "Hey, I found ${place["company_name"]} on oneapp! Now find more ${getTypeDetail()} near you and order online easily. Download 'oneapp' now! https://www.cubeoneapp.com";
  }

  Widget getOpeningTime(String day, Map s) {
    String value;
    if (day.toLowerCase() == "Monday".toLowerCase()) {
      var dayTiming = getDayTiming(place, "STORE_TIMINGS_MONDAY");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Tuesday".toLowerCase()) {
      var dayTiming = getDayTiming(place, "STORE_TIMINGS_TUESDAY");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Wednesday".toLowerCase()) {
      var dayTiming = getDayTiming(place, "STORE_TIMINGS_Wednesday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Thursday".toLowerCase()) {
      var dayTiming = getDayTiming(place, "STORE_TIMINGS_Thursday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Friday".toLowerCase()) {
      var dayTiming = getDayTiming(place, "STORE_TIMINGS_Friday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Saturday".toLowerCase()) {
      var dayTiming = getDayTiming(place, "STORE_TIMINGS_Saturday");
      if (dayTiming != null && dayTiming.length > 0) {
        value = dayTiming;
      }
    } else if (day.toLowerCase() == "Sunday".toLowerCase()) {
      var dayTiming = getDayTiming(place, "STORE_TIMINGS_SUNDAY");
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
            isTodayOpen = true;
            isEnableForTodayAccordingToTime = true;
            setState(() {});
          } else {
            value2 = " closed";
            // isEnableForTodayAccordingToTime = false;
            isEnableForTodayAccordingToTime = true;
            isTodayOpen = false;
            setState(() {
              // isEnableForTodayAccordingToTime = false;
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
              width: 45,
              child: Text(
                '${getWeekDayInSmall(day)} :'.toLowerCase(),
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
          '${getWeekDayInSmall(day)} : close'.toLowerCase(),
          style: TextStyle(
              fontSize: FSTextStyle.h6size,
              color: FsColor.red,
              fontFamily: 'Gilroy-SemiBold'),
        ),
      );
    }
  }

  callOnlineOrderPage(BuildContext context, {bool showBottom = false}) async {
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
        callOnlineOrderLink(businessAppMode, showBottom, context, location);
      }
    } else {
      callOnlineOrderLink(businessAppMode, showBottom, context, location);
    }
  }

  Future<void> callOnlineOrderLink(BusinessAppMode businessAppMode,
      bool showBottom, BuildContext context, Location location) async {
    bool a = await location.serviceEnabled();
    if (!a) {
      bool b = await location.requestService();
      if (b) {
        if (showBottom) {
          _ordernowBottomSheet(context);
          return;
        }
        print(businessAppMode);
        FsFacebookUtils.onlineOrderSubmitEvent(
            businessAppMode, place["company_name"]);
        if (businessAppMode == BusinessAppMode.RESTAURANT) {
          resto_click(place, context);
        } else if (businessAppMode == BusinessAppMode.GROCERY) {
          callOnlineOrderWebviewPage(context);
        } else if (businessAppMode == BusinessAppMode.TIFFIN) {
          callTiffinList(place["company_name"], "");
        }
      }
    } else {
      if (showBottom) {
        _ordernowBottomSheet(context);
        return;
      }
      print(businessAppMode);
      FsFacebookUtils.onlineOrderSubmitEvent(
          businessAppMode, place["company_name"]);
      if (businessAppMode == BusinessAppMode.RESTAURANT) {
        resto_click(place, context);
      } else if (businessAppMode == BusinessAppMode.GROCERY) {
        callOnlineOrderWebviewPage(context);
      } else if (businessAppMode == BusinessAppMode.TIFFIN) {
        callTiffinList(place["company_name"], "");
      }
    }
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

  static String getWeekDayInSmall(String s) {
    if (s.toLowerCase() == "Monday".toLowerCase()) {
      return "mon";
    } else if (s.toLowerCase() == "Tuesday".toLowerCase()) {
      return "tue";
    } else if (s.toLowerCase() == "Wednesday".toLowerCase()) {
      return "wed";
    } else if (s.toLowerCase() == "Thursday".toLowerCase()) {
      return "thu";
    } else if (s.toLowerCase() == "Friday".toLowerCase()) {
      return "fri";
    } else if (s.toLowerCase() == "Saturday".toLowerCase()) {
      return "sat";
    } else if (s.toLowerCase() == "Sunday".toLowerCase()) {
      return "sun";
    } else {
      return s;
    }
  }

  void resto_click(Map place, BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      print(resto_any_details);
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      String con = Environment()
          .getCurrentConfig()
          .vezaPlugInUrl;
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
                    storeDetails["company_name"],
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

  bool isEnableForTodayAccordingToTime = true;

  void callOnlineOrderWebviewPage(BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      var url2;
      if (businessAppMode == BusinessAppMode.GROCERY) {
        String con = Environment()
            .getCurrentConfig()
            .vezaGroceryPlugInUrl;
        url2 = con +
            "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone&lat=${address['latitude']}&long=${address['longitude']}";
      } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
        String con = Environment()
            .getCurrentConfig()
            .subscriptionPlugInUrl;
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
                return OnlineOrderWebView(
                    businessAppMode, storeDetails["company_name"], url2);
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

  var storeDetails;

  void mapData() {
    print("place --------$place");
    String category = place["cuisine"] != null ? (place["cuisine"]) : (null);
    storeDetails = {
      "com_latitude": place["latitude"],
      "com_longitude": place["longitude"],
      "company_id": place["company_id"],
      "company_name": place["company_name"],
      "minimum_order": place["minimum_order_value"].toString(),
      "in_range": place["in_range"].toString(),
      "category": category,
      "address": getAddress(place),
      "locality": getAddress(place, onlyLocality: true),
      "phone_no": AppUtils.getDetails("support_no", place),
      "enable_online_order": AppUtils.getViewMenuOrderOnlineStatus(
          place, address,
          isCheckInRangeOrNot: false),
      "image": AppUtils.getCompanyImage(place),
      "default_image": AppUtils.getDefultImage(businessAppMode),
      "user_address": address,
    };
    setState(() {});
    companyApiCall();
  }

  static String getAddress(Map place, {bool onlyLocality = false}) {
    String address = "";
    if (!onlyLocality &&
        place["address_line_1"] != null &&
        place["address_line_1"].length > 0) {
      address = place["address_line_1"];
    }
    if (!onlyLocality &&
        place["address_line_2"] != null &&
        place["address_line_2"].length > 0) {
      address = address.length > 0
          ? address + ", " + place["address_line_2"]
          : place["address_line_2"];
    }
    if (place["locality"] != null && place["locality"].length > 0) {
      address = address.length > 0
          ? address + ", " + place["locality"]
          : place["locality"];
    }
    if (place["city"] != null && place["city"].length > 0) {
      address =
      address.length > 0 ? address + ", " + place["city"] : place["city"];
    }
    return address;
  }

  void companyApiCall() {
    onlineOrderPresenter.getCompanyApi(storeDetails["company_id"].toString());
  }

  @override
  error(error, {var callingType}) async {
    print("error callingType---------------- $callingType");
    print("error company-api ---------------- $error");
    if (callingType == "company_details") {
      isLoading = false;
      setState(() {});
      print(error);
      var result = await Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
      );
    }
  }

  @override
  failure(failed, {var callingType}) {
    print("failure callingType---------------- $callingType");
    print("failed company-api ---------------- $failed");
    if (callingType == "company_details") {
      print(failure);
      isLoading = false;
      Toasly.error(context, AppUtils.errorDecoder(failure));
      setState(() {});
    }
  }

  bool isLoading = true;

  @override
  success(success, {var callingType}) {
    print("success callingType---------------- $callingType");
    if (callingType == "timing") {
      print("success setting ---------------- $success");
    } else if(callingType=="number_masking"){
callIntent(context, place);
    }else if (callingType == "company_details") {
      print("success setting ---------------- $success");
      print(place = success['data']);
      getStoreTimeing();
      mapData();
      FsFacebookUtils.storeDetailEvent(businessAppMode, place["company_name"]);
      isLoading = false;
      setState(() {});
    } else {
      print("success company-api ---------------- $success");
      List succes = success["data"];
      if (succes.length > 0) {
        isMoneyKeyAvailable = true;
        setState(() {});
        SsoStorage.setCompanyApi(succes);
        SsoStorage.getCompanyApi("MONEY").then((value) {
          print("money Api ------------- $value");
          onlineOrderPresenter.getStoreTiming(value, "timing");
        });
      } else {}
    }
  }

  bool isMoneyKeyAvailable = false;

  void _termsDialog() {
    // flutter defined function
    SsoStorage.getTermsAndCondition().then((value) {
      if (value == "yes") {
        callOnlineOrderPage(context);
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
                                color: getPrimaryColor(),
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
                                color: getPrimaryColor(),
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
                                color: getPrimaryColor(),
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
                                color: getPrimaryColor(),
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
                                color: getPrimaryColor(),
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
                            _launchURL();
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
                            callOnlineOrderPage(context);
                          },
                          color: getPrimaryColor(),
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

  _launchURL() async {
    const url = 'https://www.cubeoneapp.com/term&conditions.php';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String getDayTiming(Map place, String key) {
    print(place['details']);
    if (place == null || place['details'] == null) {
      return null;
    } else {
      List list = place['details'];
      print(list);
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'].toString().toLowerCase() ==
              key.toLowerCase()) {
            var split = list[i]['company_value'].toString();
            return split;
          }
        }
      } else {
        return null;
      }
    }
  }

  static bool getDayTimingSatus(Map place, String key) {
    print(place['details']);
    if (place == null || place['details'] == null) {
      return false;
    } else {
      List list = place['details'];
      print(list);
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          print(list[i]['company_key'].toString());
          if (list[i]['company_key'].toString().toLowerCase() ==
              key.toLowerCase()) {
            return true;
          }
        }
        return false;
      } else {
        return false;
      }
    }
  }

  Future<void> callIntent(BuildContext context, Map place) async {
    String url = "";
    print("..................................::::::::::::" +
        Environment.config.name);

    if (Environment.config.name == "production") {
      setState(() {
        url = "tel:0${2248966550}";
        print("production env ${url.toString()}");
      });
    }
    else {
      setState(() {
        url = "tel:${09513886363}";
      });
    }

//url for call on fix number

    await AppUtils.launchUrl(url);
    // List number = AppUtils.getCallNumber(place);
    // FsFacebookUtils.callSubmitEvent(businessAppMode, place["company_name"]);
    // if (number.length == 1) {
    //   var number2 = number[0];
    //   String url = "tel:${number2}";
    //   if (await AppUtils.canLaunchUrl(url)) {
    //     await AppUtils.launchUrl(url);
    //     //_sendAnalyticsEvent(place);
    //   } else {
    //     Toasly.error(context, 'calling not supported.');
    //   }
    // } else {
    //   Toasly.error(context, 'Could not launch $number');
    // }
  }

  /*static Future<void> _sendAnalyticsEvent(Map place) async {
    await FirebaseAnalyticsA.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true,
      },
    );
    //setMessage('logEvent succeeded');
  }*/

  void oldOrderPage() {
    print(storeDetails);
    FsNavigator.push(context, new OlderOrder(storeDetails, businessAppMode));
  }
}
