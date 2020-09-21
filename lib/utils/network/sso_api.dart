import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/end_point.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'api_handler.dart';

class SSOAPIHandler {
  static Network getNetworkRequest(NetworkHandler a) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest("http://localhost:35839/#/");
    return network;
  }

  static Network getLoginRequest(
      NetworkHandler a, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["client_id"] = currentConfig.ssoClientId;
    hashMap["client_secret"] = currentConfig.ssoClientSecret;

    /*hashMap["username"] = userName;
    hashMap["password"] = password;*/
    /* print("params- " + hashMap.toString());*/
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.USER_LOGIN,
        hashMap);
    return network;
  }

  static Network postSignUp(NetworkHandler a, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    /*  hashMap["first_name"] = "";
    hashMap["last_name"] = "";*/
    //hashMap["password"] = "123456789";
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    print(hashMap);
    network.postRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.USERS, hashMap);
    return network;
  }

  static Network searchUser(NetworkHandler a, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.SEARCH_USERS,
        hashMap);
    return network;
  }

  static Network testGetNetworkRequest(NetworkHandler a, HashMap map) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest("http://localhost:35839/#/", map);
    network.getRequest("http://localhost:35839/#/", map, ["unit", "s"]);
    String accessToken = "";
    SsoStorage.saveToken(accessToken);
    SsoStorage.getToken().then((s) => {});
    return network;
  }

  static Network getUserProfile(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.USERS_PROFILE,
        hashmap);
    return network;
  }

  static Network getUserProfileProgres(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl +
            Constant.USERS_PROFILE_PROGRESS,
        hashmap);
    return network;
  }

  static Network getCountries(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    hashmap["api_key"] = Environment().getCurrentConfig().ssoApiKey;
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.COUNTRIES,
        hashmap);
    return network;
  }

  static Network getStatesWrtCountry(
      NetworkHandler a, HashMap<String, String> hashmap, String country_id) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    hashmap["api_key"] = Environment().getCurrentConfig().ssoApiKey;
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl +
            Constant.COUNTRIES +
            "/" +
            country_id +
            "/states",
        hashmap);
    return network;
  }

  static Network verifyMobile(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().ssoAuthUrl +
            Constant.USERS_PROFILE, //todo change Endopint
        hashmap);
    return network;
  }

  static Network verifyEmail(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().ssoAuthUrl +
            Constant.USERS_PROFILE, //todo change Endopint
        hashmap);
    return network;
  }

  static Network addNewUserAddress(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().ssoAuthUrl +
            Constant.USER_ADDRESS, //todo change Endopint
        hashmap);
    return network;
  }

  static Network updateUserProfile(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.putRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.USERS_PROFILE,
        hashmap);
    return network;
  }

  static Network updateUserProfileImage(
      NetworkHandler a, HashMap<String, String> hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.USERS_AVATAR,
        hashmap);
    return network;
  }

  static Network checkUserName(
      NetworkHandler a, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl +
            Constant.USER_CHECKE_USERNAME,
        hashMap);
    return network;
  }

  static Network sendOtp(String userName, NetworkHandler s) {
    //FIxme APi send opt while username update using mobile numbe
    HashMap hashMap = new HashMap();
    Network network = new Network(s);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.SEND_OTP,
        hashMap);
    return network;
  }

  static Network verifyOtp(String userName, NetworkHandler s) {
    //FIxme APi send opt while username update using mobile numbe
    HashMap hashMap = new HashMap();
    Network network = new Network(s);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.VERIFY_OTP,
        hashMap);
    return network;
  }

  static Network postNumberMasking(HashMap a, NetworkHandler s) {
    var currentConfig = Environment().getCurrentConfig();
    //my logic
    String url = Environment.config.nodeUrl + "api/v1/exotel/intercom-call-log";
    Network network = new Network(s);
    print(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    // network.postRequest(currentConfig.nodeUrl,a);
    network.postRequestJSON(url, json.encode(a));

    return network;
  }

  static Network sendOtpForLogin(String userId, NetworkHandler s) {
    var currentConfig = Environment().getCurrentConfig();
    HashMap<String, String> hashMap = new HashMap();
    Network network = new Network(s);
    hashMap["source"] = "CUBEONE";
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["user_id"] = userId.toString();
    //hashMap["mobile"]="917666755466";
    print(hashMap);

    network.setErrorReporting(true);
    network.setRequestDebug(true);

    network.postRequest(currentConfig.ssoAuthUrl + Constant.USERS_OTP, hashMap);
    return network;
  }

  static Network sendOtpForForgotPassword(String userName, String userID,
      NetworkHandler s) {
    var currentConfig = Environment().getCurrentConfig();
    HashMap<String, String> hashMap = new HashMap();
    Network network = new Network(s);
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["username"] = userName.toString();
    hashMap["type"] = "forget_password";
    hashMap["user_id"] = userID.toString();
    hashMap["source"] = "CUBEONE";
    //hashMap["mobile"]="917666755466";
    print(hashMap);

    network.setErrorReporting(true);
    network.setRequestDebug(true);

    network.postRequest(currentConfig.ssoAuthUrl + Constant.USERS_OTP, hashMap);
    return network;
  }

  static Network sendResetPassword(String fp_auth_code, String password,
      String userID, NetworkHandler s) {
    var currentConfig = Environment().getCurrentConfig();
    HashMap<String, String> hashMap = new HashMap();
    Network network = new Network(s);
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["user_id"] = userID.toString();
    hashMap["fp_auth_code"] = fp_auth_code;
    hashMap["password"] = password;
    hashMap["source"] = "CUBEONE";
    //hashMap["mobile"]="917666755466";
    print(hashMap);

    network.setErrorReporting(true);
    network.setRequestDebug(true);

    network.postRequest(
        currentConfig.ssoAuthUrl + Constant.RESET_PASSWORD, hashMap);
    return network;
  }

  static Network sendChangePassword(String password, String access_token,
      String oldPassword, NetworkHandler s) {
    var currentConfig = Environment().getCurrentConfig();
    HashMap<String, String> hashMap = new HashMap();
    Network network = new Network(s);
    hashMap["access_token"] = access_token;
    hashMap["new_password"] = password;
    hashMap["source"] = "CUBEONE";
    if (oldPassword != null && !oldPassword.isEmpty) {
      hashMap["old_password"] = oldPassword;
    }
    //hashMap["mobile"]="917666755466";
    print(hashMap);

    network.setErrorReporting(true);
    network.setRequestDebug(true);

    network.putRequest(
        currentConfig.ssoAuthUrl + Constant.SET_PASSWORD, hashMap);
    return network;
  }

  static Network checkMultipleAccounts(String userName, NetworkHandler s) {
    var currentConfig = Environment().getCurrentConfig();
    HashMap<String, String> hashMap = new HashMap();
    Network network = new Network(s);

    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["username"] = userName;
    hashMap["check_contact"] = "1";
    //hashMap["mobile"]="917666755466";
    print(hashMap);

    network.setErrorReporting(true);
    network.setRequestDebug(true);

    network.getRequest(
        currentConfig.ssoAuthUrl + Constant.USER_SEARCH, hashMap);
    return network;
  }

  static Network sendOtpForVerification(
      HashMap<String, String> hashMap, NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["source"] = "CUBEONE";
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(currentConfig.ssoAuthUrl + Constant.USERS_OTP, hashMap);
    return network;
  }

  static Network verifyEmailMobileOtpForVerification(
      HashMap<String, String> hashMap, NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["source"] = "CUBEONE";
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.ssoAuthUrl + Constant.VERIFY_USERS_OTP, hashMap);
    return network;
  }

  static Network sendContactOtp(
      Map<String, String> hashMap, NetworkHandler networkHandler) {
    /*users/contacts/otp*/
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    hashMap["source"] = "CUBEONE";
    // hashMap["source"] = "chsone";
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.ssoAuthUrl + Constant.USERS_CONTACT_OTP, hashMap);
    return network;
  }

  //7066128580

  /*VERIFY_USERS_CONTACT_OTP*/
  static Network verifyOtpForVerification(
      Map<String, String> hashMap, NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    hashMap["source"] = "CUBEONE";
    Network network = new Network(networkHandler);
    //hashMap["source"] = "chsone";
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.ssoAuthUrl + Constant.VERIFY_USERS_CONTACT_OTP, hashMap);
    return network;
  }

  static Network verifyOtpForForgotPassword(Map<String, String> userdata,
      String otpCommon, NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    Map<String, String> hashMap = new HashMap();
    hashMap["otp"] = otpCommon;
    hashMap["source"] = "CUBEONE";
    hashMap["user_id"] = userdata["user_id"].toString();
/*
    hashMap["source"] = "oneapp";
*/
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["type"] = "forget_password";
    hashMap["otp_type"] = "mobile";
    //hashMap["source"] = "chsone";
    print(hashMap);
    print("ffffffffffffffffff");
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.ssoAuthUrl + Constant.VERIFY_USERS_FORGOTPAS_OTP,
        hashMap);
    return network;
  }

  static getSearchSocieties(a, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.SEARCH_SOCIETY,
        hashMap);
    return network;
  }

  static getBuildings(a, String socId) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().chsoneResidentUrl +
            Constant.GET_BUILDING_LIST_URL,
        null,
        [socId]);
    return network;
  }

  static Network getReceipts(a, String unit_id, String token,
      {String search,
        String per_page,
        String page,
        String search_by,
        String search_value,
        String filter_status,
        String filter_payment_mode,
        String is_pagination}) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = HashMap();
    hashMap["unit_id"] = unit_id;

    hashMap["token"] = token;
    if (per_page != null) {
      hashMap["per_page"] = per_page;
    }
    if (page != null) {
      hashMap["page"] = page;
    }
    if (is_pagination != null) {
      hashMap["is_pagination"] = is_pagination;
    }
    if (search_by != null) {
      hashMap["search_by"] = search_by;
    }
    if (filter_payment_mode != null) {
      hashMap["filter_payment_mode"] = filter_payment_mode;
    }
    if (filter_status != null) {
      hashMap["filter_status"] = filter_status;
    }
    network.getRequest(
      Environment()
          .getCurrentConfig()
          .chsoneResidentUrl +
          Constant.GET_RECEIPTS,
      hashMap,
    );
    return network;
  }

  static getRestaurant(a, HashMap hashMap, String industry_type) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    if (industry_type == "resto") {
      network.getRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl +
            Constant.GET_RESTAURANT_LIST_URL,
        hashMap,
      );
    } else if (industry_type == "tiffin") {
      network.getRequest(
          Environment()
              .getCurrentConfig()
              .ssoAuthUrl +
              Constant.GET_TIFFIN_LIST_URL,
          hashMap);
    } else if (industry_type == "retails") {
      network.getRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl +
            Constant.GET_RETAILS_LIST_URL,
        hashMap,
      );
    } else if (industry_type == "wines") {
      network.getRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl +
            Constant.GET_RETAILS_LIST_URL,
        hashMap,
      );
    }

    return network;
  }

  static getTiffin(a,
      {String search,
        String filter = "type:company,",
        String industry_type = "food",
        String business_category,
        String lat,
        String long,
        String distace = "20"}) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = HashMap();
    hashMap["api_key"] = Environment()
        .getCurrentConfig()
        .ssoApiKey;
    String sBusiness_category = "";
    if (business_category != null && !business_category.isEmpty) {
      sBusiness_category += ",business_category:$business_category";
    }
    if (industry_type == null || industry_type.isEmpty) {
      industry_type = 'food';
    }
    if (lat != null) {
      hashMap["latitude"] = lat;
      hashMap["longitude"] = long;
      /*if (distace == null) {
        distace = "20";
      }
      hashMap["distance"] = distace;*/
    }

    hashMap["filter"] = filter +
        "industry_type:$industry_type,discovery_enabled:yes,status:active" /*+ sBusiness_category*/ +
        "&fields=details";
    if (search != null && !search.isEmpty) {
      hashMap["search"] = search;
    }
    network.getRequest(
      Environment()
          .getCurrentConfig()
          .ssoAuthUrl +
          Constant.GET_TIFFIN_LIST_URL,
      hashMap,
    );
    return network;
  }

  static getGrocery(HashMap hashMap, a,
      {String lat, String long, String distace = "20"}) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    if (lat != null) {
      hashMap["latitude"] = lat;
      hashMap["longitude"] = long;
      /* if (distace == null) {
        distace = "20";
      }
      hashMap["distance"] = distace;*/
    }
    network.getRequest(
      Environment()
          .getCurrentConfig()
          .ssoAuthUrl +
          Constant.GET_RETAILS_LIST_URL,
      hashMap,
    );
    return network;
  }

  static getRestaurantURL(a, String company_id) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = HashMap();
    hashMap["api_key"] = Environment()
        .getCurrentConfig()
        .ssoApiKey;
    String url = "web/companies/$company_id/access";
    //Constant.GET_RESTAURANTURL_LIST_URL, company_id);
    network.getRequest(
      Environment()
          .getCurrentConfig()
          .ssoAuthUrl + url,
      hashMap,
    );
    return network;
  }

  static getUnits(a, HashMap<String, String> hashMap, String socId) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().chsoneResidentUrl +
            Constant.GET_BUILDING_UNITS,
        hashMap,
        [socId]);
    return network;
  }

  static Network getMemberType(a, hashMap, String socId) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().chsoneResidentUrl +
            Constant.GET_MEMBER_TYPE_URL,
        hashMap,
        [socId]);
    return network;
  }

  static Network getMemberStatus(a, hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().chsoneResidentUrl +
            Constant.GET_UNIT_MEMBER_STATUS,
        hashMap);
    return network;
  }

  static Network getMemberStatusVizlog(a, String socId, String unitId) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(Environment()
        .getCurrentConfig()
        .vizlogAppUrl +
        "company/" +
        socId +
        "/units/" +
        unitId);
    return network;
  }

  static Network postMemberRegister(
      NetworkHandler a, HashMap<String, String> registerMemberParams) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().chsoneResidentUrl +
            Constant.REGISTER__MEMBER,
        registerMemberParams);
    return network;
  }

  static Network getAllComplexUnits(NetworkHandler a, HashMap hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .chsoneResidentUrl +
            Constant.CHSONE_COMPLEX_ALL_UNITS,
        hashmap);
    return network;
  }

  //{Vizlog_url}/users/requests/23

  static Network getAllComplexVizlogUnits(NetworkHandler a, HashMap hashmap,
      List<String> query) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .vizlogAppUrl + "users/requests",
        hashmap,
        query);
    return network;
  }

  /*static Network getAllComplexUnits(NetworkHandler a, HashMap hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(Environment()
        .getCurrentConfig()
        .chsoneResidentUrl +
        Constant.CHSONE_COMPLEX_ALL_UNITS, hashmap);
    return network;
  }*/

  static Network getUnitDues(NetworkHandler a, HashMap hashmap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().chsoneResidentUrl +
            Constant.CHSONE_COMPLEX_UNIT_DUES,
        hashmap);
    return network;
  }

  static getBuildingVizlog(a, String socId, hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().vizlogAppUrl + Constant.COMPANY,
        hashMap,
        [socId, "buildings"]);
    return network;
  }

  static getVizlogUnit(a, String socId, String buildingId, hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment().getCurrentConfig().vizlogAppUrl + Constant.COMPANY,
        hashMap,
        [socId, "building", buildingId, "units"]);
    return network;
  }

  static Network postMemberRegisterVizlog(NetworkHandler a, socId, buildingId,
      unitId, HashMap<String, String> registerMemberParams) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().vizlogAppUrl +
            Constant.COMPANY +
            "/" +
            socId +
            "/building/" +
            buildingId +
            "/unit/" +
            unitId +
            "/request",
        registerMemberParams);
    return network;
  }

  static Network deleteUserAddress(NetworkHandler handler,
      HashMap<String, String> map) {
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl + Constant.USER_ADDRESS,
        map);
    return network;
  }

  static Network getAppUpdate(handler) {
    Network network = new Network(handler);
    HashMap<String, String> parameter = new HashMap<String, String>();
    parameter["api_key"] = Environment()
        .getCurrentConfig()
        .ssoApiKey;
    print(AppUtils.getDeviceCode());
    parameter["platform"] = AppUtils.getDeviceCode();
    parameter["app_name"] = "cubeone";
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl +
            "applications/versions/" +
            Environment()
                .getCurrentConfig()
                .getOneAppId,
        parameter);
    print(parameter);
    return network;
  }

  static Network posDeviceRegister(HashMap platform, handler) {
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl + "users/device", platform);
    return network;
  }

/* static Network deleteUserAddress(NetworkHandler handler,
      HashMap<String, String> map) {
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.deleteRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl + Constant.USER_ADDRESS,
        map);
    return network;
  }*/
  static Network getInvoice(a, String token, String invoiceNumber, unitId) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = HashMap();
    // hashMap["unit_id"] = unit_id;
    print("invoiuce number");
    print(invoiceNumber);

    hashMap["token"] = token;
    hashMap["unit_id"] = unitId.toString();
    hashMap["per_page"] = '1';
    // if (per_page != null) {
    //   hashMap["per_page"] = per_page;
    // }
    // if (page != null) {
    //   hashMap["page"] = page;
    // }
    // if (is_pagination != null) {
    //   hashMap["is_pagination"] = is_pagination;
    // }
    // if (search_by != null) {
    //   hashMap["search_by"] = search_by;
    // }
    // if (filter_payment_mode != null) {
    //   hashMap["filter_payment_mode"] = filter_payment_mode;
    // }
    // if (filter_status != null) {
    //   hashMap["filter_status"] = filter_status;
    // }
    network.getRequest(
      Environment()
          .getCurrentConfig()
          .chsoneResidentUrl +
          Constant.GET_INVOICE +
          "/" +
          invoiceNumber,
      hashMap,
    );
    return network;
  }

  static Network getIncidentalInvoice(NetworkHandler a, String token,
      String invoiceNumber, unitId) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = HashMap();
    hashMap["unit_id"] = unitId.toString();
    print("invoiuce number");
    print(invoiceNumber);

    hashMap["token"] = token;
    hashMap["per_page"] = '1';
    network.getRequest(
      Environment()
          .getCurrentConfig()
          .chsoneResidentUrl +
          Constant.GET_INCIDENTAL_INVOICE +
          "/" +
          invoiceNumber,
      hashMap,
    );
    return network;
  }

  static Network getMemberInvitation(NetworkHandler netwrkHandler,
      String token) {
    HashMap<String, String> hashMap = new HashMap<String, String>();
    hashMap["access_token"] = token;
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.getRequest(currentConfig.ssoAuthUrl + "users/invites", hashMap);
    return network;
  }

  static Network respondInvitation(String inviteId, NetworkHandler a,
      HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.ssoAuthUrl + "users/invites/" + inviteId, hashMap);
    return network;
  }

  static Network getCompanyApi(NetworkHandler a, String compId,
      HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.getRequest(
        currentConfig.ssoAuthUrl + "web/companies/" + compId + "/access",
        hashMap);
    return network;
  }

  static Network getCompanyDetail(NetworkHandler a, String compId,
      HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        currentConfig.ssoAuthUrl + "web/companies/" + compId, hashMap);
    return network;
  }

  static Network getTiming(NetworkHandler a, String url,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.getRequest(url + "/v1/settings/public", hashMap);
    return network;
  }

  static Network postOrder(NetworkHandler a, String url,
      HashMap<String, String> hashMap) {
//    https://stgmoneyapi.vezaone.com/api/v1/customers/orders
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.postRequest(url + "/v1/customers/orders", hashMap);
    return network;
  }

  static Network cancelOrder(
      NetworkHandler a, String url, HashMap<String, String> hashMap) {
//    https://stgmoneyapi.vezaone.com/api/v1/customers/orders
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.putRequest(
        url + "/customers/orders/${hashMap['order_id']}", hashMap);
    return network;
  }

  static Network getOrderSummary(NetworkHandler a, String url, String orderId,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.getRequest(url + "/v1/customers/orders/" + orderId, hashMap);
    return network;
  }

  static Network getOldOrder(NetworkHandler a, String url,
      HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.getRequest(url + "/v1/customers/orders", hashMap);
    return network;
  }

  static Network orderUpdate(NetworkHandler a, String url, String orderId,
      HashMap<String, String> hashMap,
      {bool deleteItem = false}) {
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    if (!deleteItem) {
      network.putRequest(url + "/v1/customers/orders/" + orderId, hashMap);
    } else {
      network.deleteRequest(
          url + "/v1/customers/orders/" + orderId + "/items", hashMap);
    }
    return network;
  }

  static Network deleteItem(NetworkHandler a, String url, String orderId,
      String itemId, HashMap<String, String> hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.deleteRequest(
        url + "/v1/customers/orders/" + orderId + "/items/" + itemId, hashMap);
    return network;
  }

  static Network getAllOrders(NetworkHandler a,
      HashMap<String, String> hashMap) {
    String url = Environment()
        .getCurrentConfig()
        .notificationUrl;
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.getRequest(url + "orders", hashMap);
//    network.deleteRequest(
//        url + "/orders" , hashMap);
    return network;
  }

  static Network getAllCartOrders(NetworkHandler a, String user_id,
      String company_id, HashMap<String, String> hashMap) {
    String url = Environment()
        .getCurrentConfig()
        .notificationUrl;
    Network network = new Network(a);
    network.setErrorReporting(true);
    url += "cart";
    network.setRequestDebug(true);
    if (user_id != null) {
      url += '/' + user_id;
    }
    if (user_id != null && company_id != null) {
      url += '/' + company_id;
    }
    network.getRequest(url, hashMap);
//    network.deleteRequest(
//        url + "/orders" , hashMap);
    return network;
  }

  static String encodeQueryComponent(String component,
      {Encoding encoding = utf8}) {
    var encodeComponent = Uri.encodeComponent(component);
    print("encoded ------ $encodeComponent");
    return encodeComponent;

//    return _Uri._uriEncode(_Uri._unreservedTable, component, encoding, true);
  }

  static Network getOrderDetails(NetworkHandler a, String companyId,
      String orderNo) {
    String url = Environment()
        .getCurrentConfig()
        .notificationUrl;
    Network network = new Network(a);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.setEncode(true);
    network.getRequest(
        url + "orders/" + companyId, null, [encodeQueryComponent(orderNo)]);
//    network.deleteRequest(
//        url + "/orders" , hashMap);
    return network;
  }

  static Network addProductToCart(NetworkHandler a, url, hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.setEncode(true);
    network.postRequest(url + "app/customers/session/cart", hashMap);

    return network;
  }

  static Network getSearchResults(NetworkHandler a, hashMap) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    var industry_type = hashMap['business_mode'];

    if (industry_type == "resto") {
      network.getRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl +
            Constant.GET_RESTAURANT_LIST_URL,
        hashMap,
      );
    } else if (industry_type == "tiffin") {
      network.getRequest(
          Environment()
              .getCurrentConfig()
              .ssoAuthUrl +
              Constant.GET_TIFFIN_LIST_URL,
          hashMap);
    } else if (industry_type == "retails") {
      network.getRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl +
            Constant.GET_RETAILS_LIST_URL,
        hashMap,
      );
    } else if (industry_type == "wines") {
      network.getRequest(
        Environment()
            .getCurrentConfig()
            .ssoAuthUrl +
            Constant.GET_RETAILS_LIST_URL,
        hashMap,
      );
    }

    return network;
  }
}
