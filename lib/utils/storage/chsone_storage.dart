import 'dart:convert';

import 'package:common_config/utils/storage/storage.dart';

class ChsoneStorage {
  static String CHSONE_ACCESS_INFO = "chsone_access_info";
  static String CHSONE_USER_DATA = "chsone_user_date";

  static void saveChsoneAccessInfo(var accessInfo) {
    LocalStorage.getStorage()
        .setItem(CHSONE_ACCESS_INFO, json.encode(accessInfo));
  }

  static void saveChsoneUserData(var userData) {
    LocalStorage.getStorage().setItem(CHSONE_USER_DATA, json.encode(userData));
  }

  static Future<dynamic> getChsoneAccessInfo() async {
    String data = await LocalStorage.getStorage().getItem(CHSONE_ACCESS_INFO);
    var access_info = null;
    if (data != null) {
      access_info = json.decode(data);
    }
    return access_info;
  }

  static Future<dynamic> getChsoneUserData() async {
    String data = await LocalStorage.getStorage().getItem(CHSONE_USER_DATA);
    var user_data = null;
    if (data != null) {
      user_data = json.decode(data);
    }
    return user_data;
  }

  static Future<String> getAccessToken() async {
    var access_info = await getChsoneAccessInfo();
    return access_info["access_token"].toString();
  }

  static saveSocietyDetails(var data) {
    LocalStorage.getStorage().setItem("SOC_Details", json.encode(data));
  }

  static Future<dynamic> getSocietyDetails() async {
    String data = await LocalStorage.getStorage().getItem("SOC_Details");
    return Future.value(json.decode(data));
  }

  static Future<dynamic> getMemberIdForUnit(String unitId) async {
    var userdata = await getChsoneUserData();
    List userMemebre = userdata["members"];
    print(userMemebre);
    print(unitId);
    if (userMemebre != null) {
      for (var member in userMemebre) {
        if (member["unit_id"].toString() == unitId) {
          return member;
        }
      }
    }
    return null;
  }

  static setCsoneIntro(bool status) {
    LocalStorage.getStorage().setItem("chsone_into", status.toString());
  }

  static Future<bool> getCsoneIntro() async {
    var status = await LocalStorage.getStorage().getItem("chsone_into");
    return Future.value(status == null
        ? false
        : status.toLowerCase() == 'false' ? false : true);
  }




}
