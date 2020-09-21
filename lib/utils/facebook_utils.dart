import 'package:common_config/utils/firebase/firebase_analytics_util.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/utils/appsflyer_utils.dart';

class FsFacebookUtils {
  static String RESTO_CALL = "RESTO";
  static String TIFFIN_CALL = "TIFFIN";
  static String RETAIL_CALL = "RETAIL";
  static String WINESHOP_CALL = "PynaShop";

  /*static void splash_facebook() async {
    FacebookAnalyticsPlugin.logCustomEvent(
        name: "FB_EVENT", parameters: {'SCREEN': 'SPLASH'});
  }*/
  /*static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);*/

  static String getType(BusinessAppMode businessAppMode) {
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      return RESTO_CALL.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      return TIFFIN_CALL.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      return RETAIL_CALL.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      return RETAIL_CALL.toLowerCase();
    } else if (businessAppMode == BusinessAppMode.WINESHOP) {
      return WINESHOP_CALL.toLowerCase();
    }
  }

  static void completedRegistrationEvent(String number) async {
    if (Environment().getCurrentConfig().build_variant != "production") {
      return;
    }
// FacebookAnalyticsPlugin.logAchievedLevel(level: FacebookAppEvents.eventNameCompletedRegistration);

    FacebookAppEvents appEvents = FacebookAppEvents();
    var eventName = "fb_mobile_complete_registration";
    var value = {"sso": number};
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  /*static void locationSearchEvent() async {
    FacebookAnalyticsPlugin.logCustomEvent(name: "FB_LOCATION_SEARCH");
  }*/

  static void callCartClick(String eventName1, String value1) async {
    var eventName = eventName1;
    var value = {eventName: value1};
    if (Environment().getCurrentConfig().build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void callSubmitEvent(
      BusinessAppMode businessAppMode, String shop_name) async {
    var eventName = "call_now_click";
    var value = {getType(businessAppMode): shop_name};
    if (Environment().getCurrentConfig().build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void whatsAppSubmitEvent(BusinessAppMode businessAppMode,
      String shop_name) async {
    var eventName = "whatsapp_order_click";
    var value = {getType(businessAppMode): shop_name};

    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();

    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void directionSubmitEvent(BusinessAppMode businessAppMode,
      String shop_name) async {
    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    var eventName = "direction_click";
    var value = {getType(businessAppMode): shop_name};

    FacebookAppEvents appEvents = FacebookAppEvents();
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void shareSubmitEvent(BusinessAppMode businessAppMode,
      String shop_name) async {
    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    var eventName = "share_details_click";
    var value = {getType(businessAppMode): shop_name};
    FacebookAppEvents appEvents = FacebookAppEvents();
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void onlineOrderSubmitEvent(BusinessAppMode businessAppMode,
      String shop_name) async {
    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();
    var eventName = "order_now_click";
    var value = {getType(businessAppMode): shop_name};
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void storeDetailEvent(BusinessAppMode businessAppMode,
      String shop_name) async {
    var eventName = "store_detail";
    var value = {getType(businessAppMode): shop_name};

    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();

    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);

    appEvents.logEvent(name: shop_name, parameters: value);
    AppsFlyerUtils.sendEvent(shop_name, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(shop_name, value);
  }

  static void requestSubmitEvent(BusinessAppMode businessAppMode,
      String shop_name) async {
    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();
    var eventName = "request_submit";
    var value = {getType(businessAppMode): shop_name};
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void requestSocietySubmitEvent(String shop_name) async {
    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();
    var eventName = "request_submit";
    var value = {"SOCIETY".toLowerCase(): shop_name};
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }

  static void requestDashoardEvent(String shop_name) async {
    if (Environment()
        .getCurrentConfig()
        .build_variant != "production") {
      return;
    }
    FacebookAppEvents appEvents = FacebookAppEvents();
    var eventName = "dashboard";
    var value = {"user".toLowerCase(): shop_name};
    appEvents.logEvent(name: eventName, parameters: value);
    AppsFlyerUtils.sendEvent(eventName, value);
    FirebaseAnalyticsA.sendAnalyticsEvent(eventName, value);
  }
}
