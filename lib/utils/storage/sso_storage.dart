import 'dart:convert';

import 'package:common_config/utils/storage/storage.dart';

class SsoStorage {
  static String IS_MOBILE_UPDATED = 'is_mobile_updated';

  static String INTERCOM_HELP = "intercom_help";

  static void saveToken(String accessToken) {
    LocalStorage.getStorage().setItem("token", accessToken);
  }

  static Future<String> getToken() {
    //print("getToken");
    return LocalStorage.getStorage().getItem("token");
  }

  static void setVizlogToken(var accessToken) {
    print(accessToken);
    print("sssssssssssssssssss");
    LocalStorage.getStorage()
        .setItem("viz_access_token", jsonEncode(accessToken));
  }

  static Future<dynamic> getVizlogToken() async {
    String vizAccessToken =
        await LocalStorage.getStorage().getItem("viz_access_token");
    print(vizAccessToken);
    return json.decode(vizAccessToken);
  }

  static void setHRMSToken(var accessToken) {
    LocalStorage.getStorage().setItem("hrms_access_token", (accessToken));
  }

  static Future<dynamic> getOneAppInterest() async {
    String vizAccessToken =
        await LocalStorage.getStorage().getItem("one_app_interest");
    if (vizAccessToken == null) {
      return null;
    }
    return json.decode(vizAccessToken);
  }

  static void setOneAppInterest(var interest) {
    String string = json.encode(interest);
    LocalStorage.getStorage().setItem("one_app_interest", (string));
  }

  static Future<dynamic> getHRMSToken() async {
    //print("getToken");
    String vizAccessToken =
        await LocalStorage.getStorage().getItem("hrms_access_token");
    return json.decode(vizAccessToken);
  }

  static void setPreferredAddress(var address) {
    String string = json.encode(address);
    LocalStorage.getStorage().setItem("preferred_address", string);
  }

  static Future<dynamic> getPreferredAddress() async {
    String preferred_address =
        await LocalStorage.getStorage().getItem("preferred_address");
    if (preferred_address == null) {
      return null;
    }
    return json.decode(preferred_address);
  }

  static void setPunchAttendance(var key, var accessToken) {
    LocalStorage.getStorage().setItem(key, jsonEncode(accessToken));
  }

  static Future<dynamic> getPunchAttendance(String date) async {
    //print("getToken");
    String vizAccessToken = await LocalStorage.getStorage().getItem(date);
    if (vizAccessToken == null) {
      return null;
    }
    return json.decode(vizAccessToken);
  }

  static void setTermsAndCondition(var value) {
    LocalStorage.getStorage()
        .setItem("terms_and_conditions", jsonEncode(value));
  }

  static Future<dynamic> getTermsAndCondition() async {
    //print("getToken");
    String value =
        await LocalStorage.getStorage().getItem("terms_and_conditions");
    if (value == null) {
      return "no";
    }
    return json.decode(value);
  }

  static void saveCompanyAccess(List comAppAccess) {
    String string = json.encode(comAppAccess);
    LocalStorage.getStorage().setItem("comAppAccess", string);
  }

  static Future<dynamic> getCompanyAccess() async {
    String comAppAccessString =
        await LocalStorage.getStorage().getItem("comAppAccess");
    return json.decode(comAppAccessString);
  }

  static void saveAppAccess(appAccess) {
    String string = json.encode(appAccess);
    // print(string);
    LocalStorage.getStorage().setItem("userAppAccess", string);
  }

  static Future<dynamic> getAppAccess() async {
    //  LocalStorage.getItem("userAppAccess").then((c)=>{ print("RRRRRR")});
    String comAppAccessString =
        await LocalStorage.getStorage().getItem("userAppAccess");
    return json.decode(comAppAccessString);
  }

  static void setUserId(int userId) {
    /*LocalStorage.setItemInt("user_id", userId);*/
  }

  /* static Future<int> getUserId() async {
    */ /* return await LocalStorage.getItemInt("user_id");*/ /*
  }*/

  static Future<String> isLogin() async {
    return await LocalStorage.getStorage().getItem("login");
  }

  static void setLogin(String loginFlag) {
    LocalStorage.getStorage().setItem("login", loginFlag);
  }

  static Future<String> isMobileUpdated() async {
    return await LocalStorage.getStorage().getItem(IS_MOBILE_UPDATED);
  }

  static void setMobileUpdated(String updateFlag) {
    LocalStorage.getStorage().setItem(IS_MOBILE_UPDATED, updateFlag);
  }

  static void setUserProfile(var userProfile) {
    LocalStorage.getStorage().setItem("user_profile", json.encode(userProfile));
  }

  /*static getUserProfile() async {
    String item = await LocalStorage.getStorage().getItem("user_profile");
    return json.decode(item);
  }*/

  /* static void setSessionToken(String sessionToken) {
    LocalStorage.getStorage().setItem("sessionToken", sessionToken);
  }*/
  /* static Future<dynamic> getUserProfile() async {
    String item = await LocalStorage.getStorage().getItem("user_profile");
    var x=null;
    if(item!=null){
      x=json.decode(item);
    }
    return Future.value(x);
  }*/
  static Future<dynamic> getUserProfile() async {
    String item = await LocalStorage.getStorage().getItem("user_profile");
    var decode;
    if (null != item) {
      decode = json.decode(item);
    }
    return decode;
  }

  static void setSessionToken(String sessionToken) {
    LocalStorage.getStorage().setItem("sessionToken", sessionToken);
  }

  static getSessionToken() {
    return LocalStorage.getStorage().getItem("sessionToken");
  }

  static getDefaultChsoneSoc() {
    var defaultChsone = LocalStorage.getStorage().getItem("default_chsone_soc");
    return defaultChsone;
  }

  static getDefaultChsoneUnit() {
    var defaultChsone =
        LocalStorage.getStorage().getItem("default_chsone_unit");
    return defaultChsone;
  }

  static void setDefaultChsoneUnit(var data) {
    print(data);
    LocalStorage.getStorage().setItem("default_chsone_unit", jsonEncode(data));
  }

  static getDefaultVizlogUnit() {
    var defaultChsone =
        LocalStorage.getStorage().getItem("default_vizlog_unit");
    print("getDefaultVizlogUnit----------------------------------------");
    print(defaultChsone);
    return defaultChsone;
  }

  static void setDefaultVizlogUnit(var data) {
    print("setDefaultVizlogUnit----------------------------------------");
    print(data);
    LocalStorage.getStorage().setItem("default_vizlog_unit", jsonEncode(data));
  }

  static void setAllChsoneUnit(data) {
    LocalStorage.getStorage().setItem("all_chsone_unit", jsonEncode(data));
  }

  static void setAllVizLogUnit(data) {
    LocalStorage.getStorage().setItem("all_vizlog_unit", jsonEncode(data));
  }

  static void setAllHRMSCompany(data) {
    LocalStorage.getStorage().setItem("all_hrms_company", jsonEncode(data));
  }

  static void setVizProfile(var profile) {
    LocalStorage.getStorage().setItem("viz_profile", jsonEncode(profile));
  }

  static Future<dynamic> getVizProfile() async {
    //print("getToken");
    String vizProfile = await LocalStorage.getStorage().getItem("viz_profile");
    var decode = json.decode(vizProfile);
    print("vizprofile  -- $decode");
    return decode;
  }

  static Future<dynamic> getAllVizLogUnit() async {
    //print("getToken");
    String vizProfile =
        await LocalStorage.getStorage().getItem("all_vizlog_unit");
    return json.decode(vizProfile);
  }

  static Future<dynamic> getHRMSCompany() async {
    //print("getToken");
    String vizProfile =
        await LocalStorage.getStorage().getItem("all_hrms_company");
    return json.decode(vizProfile);
  }

  static Future<dynamic> getAllChsoneUnit() async {
    //print("getToken");
    String vizProfile =
        await LocalStorage.getStorage().getItem("all_chsone_unit");
    return json.decode(vizProfile);
  }

  static void clearAll() {
    LocalStorage.getStorage().clearAll();
  }

  static Future<String> getAccessToken() async {
    String token = await getToken();
    var access = jsonDecode(token);
    return Future.value(access["access_token"]);
  }

  static void setFcmToken(String token) {
    print("dsc--------------------------------$token");
    LocalStorage.getStorage().setItem("fcm_token", token);
  }

  static Future<String> getFcmToken() async {
    print("dgetFcmToken----------");
    return await LocalStorage.getStorage().getItem("fcm_token");
  }

  static Future<String> getUserId() async {
    return await LocalStorage.getStorage().getItem("userIdSave");
  }

  static void saveUserId(String userId) {
    LocalStorage.getStorage().setItem("userIdSave", userId);
  }

  static void setUserName(String userName) {
    LocalStorage.getStorage().setItem("username_se", userName);
  }

  static Future<String> getUserName() async {
    return await LocalStorage.getStorage().getItem("username_se");
  }

  static void setOtpCounter(String key, data) {
    LocalStorage.getStorage().setItem(key, jsonEncode(data));
  }

  static Future<dynamic> getOtpCounter(String key) async {
    String vizAccessToken = await LocalStorage.getStorage().getItem(key);
    if (vizAccessToken != null) {
      return json.decode(vizAccessToken);
    } else {
      return null;
    }
  }

  static void setCompanyApi(List data) {
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        String key = data[i]["product_code"];
        LocalStorage.getStorage().setItem(key, jsonEncode(data[i]));
      }
    }
    print("data----------------- $data");
//    LocalStorage.getStorage().setItem("company_api", jsonEncode(data));
  }

  static Future<dynamic> getCompanyApi(String productCode) async {
    //print("getToken");
    String vizProfile = await LocalStorage.getStorage().getItem(productCode);
    return json.decode(vizProfile);
  }

  static void setPastOrderDetails(key, List orders) {
    LocalStorage.getStorage().setItem(key, jsonEncode(orders));
  }

  static Future<dynamic> getPastOrderDetails(String companyId) async {
    //print("getToken");
    String vizProfile = await LocalStorage.getStorage().getItem(companyId);
    if (vizProfile == null) {
      return null;
    }
    return json.decode(vizProfile);
  }

  static void setIntercomHelp(String seen) {
    LocalStorage.getStorage().setItem(INTERCOM_HELP, seen);
  }

  static Future<String> getIntercomHelp() {
    return LocalStorage.getStorage().getItem(INTERCOM_HELP);
  }

  static void setMeetingToken(var token) {
    LocalStorage.getStorage().setItem("meeting_token", jsonEncode(token));
  }

  static Future<dynamic> getMeetingToken() async {
    String meetingTokenStr = await LocalStorage.getStorage().getItem("meeting_token");
    var meetingTokenObj = jsonDecode(meetingTokenStr);
    return Future.value(meetingTokenObj != null ? meetingTokenObj["access_token"] : "");
  }

  static void setMeetingUserProfile(var profile) {
    LocalStorage.getStorage().setItem("meeting_user_profile", jsonEncode(profile));
  }

  static Future<dynamic> getMeetingUserProfile() async {
    String meetingUserProfileStr = await LocalStorage.getStorage().getItem("meeting_user_profile");
    var meetingUserProfileObj = jsonDecode(meetingUserProfileStr);
    return Future.value(meetingUserProfileObj);
  }

  static getMeetingSociety() {
    var meetingCompany = LocalStorage.getStorage().getItem("meeting_society");
    return meetingCompany;
  }

  static void setMeetingSociety(var data) {
    LocalStorage.getStorage().setItem("meeting_society", jsonEncode(data));
  }

  static Future<String> isMeetingIntroShown() {
    return LocalStorage.getStorage().getItem("meeting_intro_shown");
  }

  static void setMeetingIntroShown() {
    LocalStorage.getStorage().setItem("meeting_intro_shown", "true");
  }
}
