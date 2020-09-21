import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_notification.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class AppModel {
  //TODO note
  void deviceRegister(Function register, Function notRegister, {String app}) {
    print("sederer");
    SsoStorage.getToken().then((tokenString) async {
      var token = jsonDecode(tokenString);
      var accessToken = token["access_token"];

      FirebaseNotifications().getFcmToken().then((fcmToken) async {
        var firebaseToken;
        if (fcmToken != null) {
          print("Firebase token");
          print(fcmToken);
          firebaseToken = fcmToken;
        }
        HashMap<String, String> parameter = new HashMap();
        String appId;
        if (app == AppConstant.VIZLOG) {
          appId = Environment()
              .getCurrentConfig()
              .vizlogAppId;
        } else {
          appId = Environment()
            .getCurrentConfig()
            .getOneAppId;
        }
        print("aappID -------------------------------------------------------");
        print(
            "aappID -------------------------------------------------------$appId");
        parameter["app_id"] = appId.toString();
        parameter["platform"] = AppUtils.getDeviceCode();
        var deviceDetails = await getDeviceDetails();
        parameter["device_key"] = deviceDetails[2];
        parameter["access_token"] = accessToken;
        if (firebaseToken != null) parameter["firebase_token"] = firebaseToken;

        NetworkHandler networkHandler = new NetworkHandler((s) {
          var response = jsonDecode(s);
          register();
        }, (f) {
          var response = jsonDecode(f);
          notRegister(AppUtils.errorDecoder(response));
        }, (e) {
          notRegister("no internet");
        });
        Network network =
        SSOAPIHandler.posDeviceRegister(parameter, networkHandler);
        network.excute();
      });
    });
  }

  bool isNeedToUpdate(String supportedVersion, double currentVersion) {
    print("ADITI");
    List<String> splitVersions = supportedVersion.split(",");

    print(splitVersions);
    int length = splitVersions.length;
    bool needToUpdate = true;
    /*double[] versionArray = new double[length];*/
    for (int i = 0; i < length; i++) {
      /* versionArray[i] = splitVersions[i];*/
      if (double.parse(splitVersions[i]) == currentVersion) {
        needToUpdate = false;
        break;
      }
    }
    return needToUpdate;
  }

  void getAppUpdate(double platform, hasUpdate, hasNoUpdate) {
    print(platform);
    // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    print(DateTime.now());
    NetworkHandler networkHandler = new NetworkHandler((s) {
      print(s);
      try {
        // print("SSSSSSSSSSSSSSSSSSSSSSSSSSS");
        print(DateTime.now());
        var jsonBody = jsonDecode(s)["data"];
        print(jsonBody);
        String supportedVersion = jsonBody["version"];
        bool needToUpdate = isNeedToUpdate(supportedVersion, platform);
        print(needToUpdate);

        if (needToUpdate) {
          print(supportedVersion);
          print(needToUpdate);
          hasUpdate();
        } else {
          hasNoUpdate();
        }
      } catch (e) {
        print(e);
      }
    }, (f) {
      print("fffffffffffffff");
      hasNoUpdate();
    }, (e) {
      print("EEEEEEEEEEEEEE");
      hasNoUpdate();
    });

    Network network = SSOAPIHandler.getAppUpdate(networkHandler);
    network.excute();
  }

  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } catch (e) {
      print('Failed to get platform version');
      return ["web", "web", "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"];
    }
    return [deviceName, deviceVersion, identifier];
  }
}

abstract class IAppUpdate {
  void hasUpdate();

  void hasNoUpdate();
}
