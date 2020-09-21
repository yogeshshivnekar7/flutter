import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

class FsAppBarStyle {
  static TextStyle getAppStyle(BusinessAppMode businessAppMode) {
    if (businessAppMode != null &&
        businessAppMode == BusinessAppMode.APP_THEME) {
      return FSTextStyle.appbartext;
    }
    return FSTextStyle.appbartextlight;
  }

  static Color iconColor(businessAppMode) {
    if (businessAppMode != null &&
        businessAppMode == BusinessAppMode.APP_THEME) {
      return FsColor.black;
    }
    return FsColor.white;
  }

  static StatelessWidget getleading(businessAppMode, {Function clickEvent}) {
    if (businessAppMode != null &&
        businessAppMode == BusinessAppMode.APP_THEME) {
      return FsBackButton(
        backEvent: clickEvent,
      );
    } else {
      return FsBackButtonlight(backEvent: clickEvent);
    }
  }

  static Color getButtonColor(BusinessAppMode businessAppMode) {
    if (businessAppMode != null &&
        businessAppMode == BusinessAppMode.APP_THEME) {
      return FsColor.basicprimary;
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      return FsColor.primarytiffin;
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      return FsColor.primarydailyessential;
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      return FsColor.primarygrocery;
    } else if (businessAppMode == BusinessAppMode.RESTAURANT) {
      return FsColor.primaryrestaurant;
    } else
      return FsColor.primaryrestaurant;

    //FsColor.primarygrocery
  }
}
