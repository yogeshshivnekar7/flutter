import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/model/app/app_model.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_databse_sso.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class LoginModel {
  void checkUserName(
      String username, userFound, userNotFound, userCheckFailure) {
    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["username"] = username;
    hashMap["source"] = "Chsone";
    NetworkHandler a = new NetworkHandler((s) {
      print("rrrrrrrrrrrrrrrSSsssS" + s.toString());
      var jsonDecode2 = jsonDecode(s);
      if (jsonDecode2["status_code"] == 200) {
        userFound(jsonDecode2);
      } else {
        userNotFound(username);
      }
    }, (f) {
      print("rrrrrrrrrrrrrrrSSsssSFFFFFFFFF");
      var userFalure = jsonDecode(f);
      print(userFalure);
      if (userFalure["status_code"] == 1011 || userFalure["status_code"] == 1010) {
        userFound(userFalure);
      } else if (userFalure["status_code"] == 404) {
        userNotFound(username);
      } else {
        userCheckFailure(userFalure);
      }
    }, (e) {
      print("rrrrrrrrrrrrrrreeeeeeeeeeeeeFFFFFFFFF");
      userCheckFailure(e);
    });

    Network network = SSOAPIHandler.searchUser(a, hashMap);
    network.excute();
  }

  void loginWithPassword(
      String username, String password, loginSuccess, loginFailed, loginError) {
    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["password"] = password;
    hashMap["username"] = username;
    hashMap["source"] = "Chsone";
    hashMap["grant_type"] = "user_login";

    NetworkHandler a = new NetworkHandler((s) {
      var resPonse = jsonDecode(s);
      loginSuccess(resPonse);
      _registerDevice(resPonse);
      FirebaseDatabaseSSO.loginUserStore(hashMap);
    }, (f) {
      var userFalure = jsonDecode(f);
      loginFailed(userFalure);
    }, (e) {
      loginError(e);
    });
    Network network = SSOAPIHandler.getLoginRequest(a, hashMap);
    network.excute();
  }

  void loginWithOtp(userName, String otpCommon, Function loginSuccess,
      Function loginFailed, loginError) {
    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    print(otpCommon);
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["username"] = userName;
    //hashMap["user_id"] = userName;
    hashMap["source"] = "Chsone";

    hashMap["grant_type"] = "user_login";
    hashMap["auto_login"] = "0";

    hashMap["login_otp"] = otpCommon;

    NetworkHandler a = new NetworkHandler((s) {
      var response = jsonDecode(s);
      loginSuccess(response);
      _registerDevice(response);
      print(s);
    }, (f) {
      print(f);
      var userFalure = jsonDecode(f);
      loginFailed(userFalure);
    }, (e) {
      print(e);
      loginError(e);
    });
    Network network = SSOAPIHandler.getLoginRequest(a, hashMap);
    network.excute();
  }

  void _registerDevice(jsonDecode) {
    if (jsonDecode == null) {} else {
      //  String accessToken = jsonDecode["data"]["access_token"];
      AppModel appModel = new AppModel();
      appModel.deviceRegister(() {
        print("Device Registre");
      }, () {
        print("Device Fauiled");
      });
    }
  }
}

abstract class IUserNameCheck {
  userFound(var data);

  userNotFound(String username);

  userCheckFailure(var error);
}

abstract class IUserLogin {
  loginFailed(var falure);

  loginError(var error);

  loginSuccess(var success);
}

/*
var a = {
  "app": {"version": "v1", "name": "CHSONE Auth"},
  "status_code": 400,
  "error": "Username already exists."
};*/
