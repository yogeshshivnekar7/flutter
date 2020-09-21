import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

import 'api_handler.dart';

class AuthApiCall {
  /* doLoin(String userName, String password) {
    HashMap<String, String> hashMap = new HashMap();
    hashMap["grant_type"] = "password";
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["client_id"] = currentConfig.ssoClientId;
    hashMap["client_secret"] = currentConfig.ssoClientSecret;
    hashMap["username"] = userName;
    hashMap["password"] = password;

    void success(String response) {
      print(
          "**************************************************success ---- - " +
              response);
      final Map<String, dynamic> s = jsonDecode(response);
      print("s - " + s.toString());
      var app = s["app"];
      print("app- " + app.toString());
      var data = s["data"];
      print("data - " + data.toString());
    }

    void error(String error) {
      print("**************************************************error ---- - " +
          error);
    }

    void failure(String failure) {
      print(
          "**************************************************failure ---- - " +
              failure);
    }

    NetworkHandler networkHandler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {response});

    Network aa = SSOAPIHandler.getLoginRequest(networkHandler, hashMap);
    aa.excute();
  }*/

  /*void singUp(SignUpPojo signUpPojo) {
    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["first_name"] = signUpPojo.firstName;
    hashMap["last_name"] = signUpPojo.lastName;
    hashMap["password"] = signUpPojo.password;
    hashMap["mobile"] = signUpPojo.userName;
    hashMap["source"] = "Chsone";
    void success(String success) {}
    void error(String error) {}
    void failure(String failure) {}
    NetworkHandler netwrkHandler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SSOAPIHandler.postSignUp(netwrkHandler, hashMap);
  }*/

  getUserProfile(String accessToken) {
    HashMap<String, String> param = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    param["access_token"] = accessToken;

    void success(String response) {
      print("response - " + response);
      print("s - " + jsonDecode(response));
    }

    void error(String error) {
      print("error" + error);
    }

    void failure(String failure) {
      print("failure" + failure);
    }

    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});
    Network network = SSOAPIHandler.getUserProfile(handler, param);
    network.excute();
  }
}
