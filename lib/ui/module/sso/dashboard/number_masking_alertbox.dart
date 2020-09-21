import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

bool isEnableForTodayAccordingToTime = true;

var businessAppMode;

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

void showLogoutAlertDialog(BuildContext ctx) {
  showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
          backgroundColor: Colors.white,
          title: new Text("Register a new Number",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey)),
          shape: new RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: new Text("Are you sure you want to register new number?",
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
                "NO",
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h5size,
                    color: FsColorStepper.active),
              ),
            ),
            FlatButton(
              onPressed: () {
                ProfileView.logOutAction(context);
              },
              child: Text(
                "YES",
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

void showDialogForNumberMasking(
    BuildContext ctx, var place, OnlineOrderPresenter ob,
    {String pynaNUmber, String companyId, Color color}) {
  print("place..............................:" + place.toString());
  // flutter defined function
  SsoStorage.getUserProfile().then((value) {
    print("--------------User Details Value Click envent");
    print(value);
    print(
        ":::::::::::::::::::::::::::::::${pynaNUmber} : ${value['mobile'].toString()} : ${companyId}");

    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          // title: new Text("title"),
          content: Container(
              height: 150,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text:
                              'You are calling with your registered mobile number ',
                          style: TextStyle(
                            fontFamily: 'Gilroy-SemiBold',
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '+${value['mobile'].toString()}',
                              style: TextStyle(
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontSize: FSTextStyle.h6size,
                                  color: color),
                            )
                          ]),
                    ),
                    SizedBox(height: 10),

                    Text(
                      'Do you want to Register a new mobile number?'
                          .toLowerCase(),
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Please Note : if you proceed with registering a new number, the current account will be logged automatically',
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h7size,
                        color: FsColor.red,
                      ),
                    ),

                    // FlatButton(
                    //   onPressed: () {
                    //     // showLogoutAlertDialog(ctx);
                    //     ProfileView.logOutAction(context);
                    //   },
                    //   color: FsColor.primarypyna,
                    //   child: Text(
                    //     "Register a new mobile number. ",
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //         fontFamily: 'Gilroy-SemiBold',
                    //         // fontSize: FSTextStyle.h5size,
                    //         color: FsColorStepper.inactive),
                    //   ),
                    // )
                  ])),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Register New Mobile",
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: color,
                ),
              ),
              onPressed: () {
                ProfileView.logOutAction(context);
              },
            ),
            FlatButton(
              color: color,
              child: Text(
                "Call Now",
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.white,
                ),
              ),
              onPressed: () {
                String tag = "grocery";
                if (businessAppMode == BusinessAppMode.GROCERY) {
                  tag = "grocery";
                } else if (businessAppMode == BusinessAppMode.RESTAURANT) {
                  tag = "restaurant";
                } else if (businessAppMode == BusinessAppMode.TIFFIN) {
                  tag = "tiffin";
                } else if (businessAppMode == BusinessAppMode.WINESHOP) {
                  tag = "wineshop";
                } else {
                  tag = "daily_essential";
                }
                // Navigator.of(context).pop();
                print("isEnableForTodayAccordingToTime");
                print(isEnableForTodayAccordingToTime);
                ob.postNumberMasking(
                    pynaNUmber != null
                        ? pynaNUmber
                        : AppUtils.getCallNumber(place)[0],
                    "0${(value['mobile'].toString()).substring(2)}",
                    companyId != null
                        ? companyId
                        : place["company_id"].toString(),
                    tag,
                    "number_masking");
                // callIntent(context, place);
              },
            ),
            //   new FlatButton(
            //     child: new Text("Call Now"),
            //     onPressed: () {
            //       String tag = "grocery";
            //       if (businessAppMode == BusinessAppMode.GROCERY) {
            //         tag = "grocery";
            //       } else if (businessAppMode == BusinessAppMode.RESTAURANT) {
            //         tag = "restaurant";
            //       } else if (businessAppMode == BusinessAppMode.TIFFIN) {
            //         tag = "tiffin";
            //       } else if (businessAppMode == BusinessAppMode.WINESHOP) {
            //         tag = "wineshop";
            //       } else {
            //         tag = "daily_essential";
            //       }
            //     // Navigator.of(context).pop();
            //     print("isEnableForTodayAccordingToTime");
            //     print(isEnableForTodayAccordingToTime);
            //     ob.postNumberMasking(
            //      pynaNUmber!=null?pynaNUmber: AppUtils.getCallNumber(place)[0],
            //     "0${(value['mobile'].toString()).substring(2)}",
            //     companyId!=null?companyId: place["company_id"].toString()
            //   , tag, "number_masking");
            //     // callIntent(context, place);
            //   },
            // ),
          ],
        );
      },
    );
  });
}
