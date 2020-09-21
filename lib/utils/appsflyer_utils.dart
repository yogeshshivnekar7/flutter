import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:common_config/utils/application.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_notification.dart';

class AppsFlyerUtils {
  static AppsflyerSdk _appsflyerSdk;

  static void sendEvent(String eventName, Map value) {
    if (_appsflyerSdk == null) {
      var afDevKey = "nCUYUh47zfF4ctuq3VZxuZ";
      var appId = "1492930711";

      try {
        AppsFlyerOptions options;
        if (Environment().getCurrentConfig().geCurrentPlatForm() ==
            FsPlatforms.IOS) {
          options = AppsFlyerOptions(
              afDevKey: afDevKey, showDebug: true, appId: appId);
          ;
        } else {
          options = AppsFlyerOptions(afDevKey: afDevKey, showDebug: true);
          ;
        }

        _appsflyerSdk = AppsflyerSdk(options);
        _appsflyerSdk
            .initSdk(
                registerConversionDataCallback: true,
                registerOnAppOpenAttributionCallback: true)
            .then((event) {
          unstall();
          _sendEvent(eventName, value);
        });
      } on Exception catch (e) {
        _appsflyerSdk = null;
      }
    } else {
      _sendEvent(eventName, value);
    }
  }

  static Future unstall() async {
    String ftoken = await FirebaseNotifications.firebaseMessaging.getToken();
    _appsflyerSdk.updateServerUninstallToken(ftoken);
  }

  static Future<bool> _sendEvent(String eventName, Map eventValues) async {
    bool result;
    try {
      result = await _appsflyerSdk.trackEvent(eventName, eventValues);
//      print("result --------- $result");
    } on Exception catch (e) {}
    print("Result trackEvent eventName - $eventName : result : ${result}");
  }
}
