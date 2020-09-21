import 'dart:collection';
import 'dart:convert';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/network/base_network.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/sso/signup/username.dart';
import 'package:sso_futurescape/utils/firebase_util/noomiKeys.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'end_point.dart';

class Network extends BaseNetwork {
  NetworkHandler _networkHandler;
  var authonticator;
  static final int EXPIRED_OR_INVALID_ACCESS_TOKEN_RESPONSE_CODE = 1003;
  static final int LOGIN_CREADENTIALS_RESPONSE_CODE = 1000; //credentials
  static final int SQL_ERROR = 400; //credentials
  /*static final int INVALID_ACCESS_TOKEN_RESPONSE_CODE = 1003; //401;//1006;*/
  static BuildContext context;

  Network(NetworkHandler _networkHandler) {
    this._networkHandler = _networkHandler;
    super.setHandler(
            (code, response)
        {
          print("responseresponseresponse");
          onSuccess(response);
          print("responseresponseresponse");
        },
            (code, response)
        {
          print("onFailureonFailureonFailure");
          onFailure(response);
          print("onFailureonFailure");
        },
            (code, response)
        {
          print("errorerrorerror");
          _networkHandler.error(response);
          print("errorerrorerror");
        });
  }

  void onFailure(String response) {
    //print('onFailure');
    //print(response);
    try {
      var profileJson = json.decode(response);
      var status_code = profileJson['status_code'];
      print(status_code);
      if (status_code == EXPIRED_OR_INVALID_ACCESS_TOKEN_RESPONSE_CODE) {
        print('EXPIRED_OR_INVALID_ACCESS_TOKEN_RESPONSE_CODE');
        reGenerateAccessToken();
      } else {
        _networkHandler.failure(response);
      }
    } catch (e) {
      _networkHandler.failure(response);
    }
  }

  void onSuccess(String response) {
    //var profileJson = json.decode(response);
    //print('onSuccess');
    //print(response);
    //print(profileJson['status_code']);
    _networkHandler.success(response);
  }

  void excute() {
    excuteRequest();
  }

  void setHandlerX(NetworkHandler a) {}

  void setAuthonticator() {
    this.authonticator = authonticator;
  }

  void setErrorReporting(bool param0) {}

  successCallBack(tring) {
    print(this.toString());
    _networkHandler.success(tring);
  }

  void reGenerateAccessToken() {
    print("reGenerateAccessToken");
    SsoStorage.getToken().then((token) {
      var refresh_token;
      if (token != null) {
        var access = jsonDecode(token);
        refresh_token = access["refresh_token"];
        HashMap<String, String> hashMap = new HashMap();
        var currentConfig = Environment().getCurrentConfig();
        hashMap["api_key"] = currentConfig.ssoApiKey;
        hashMap["refresh_token"] = refresh_token;
        hashMap["source"] = "Chsone";
        hashMap["grant_type"] = "refresh_token";
        hashMap["api_key"] = currentConfig.ssoApiKey;
        hashMap["auto_login"] = "1";
        hashMap["platform"] = "android";
        hashMap["client_id"] = currentConfig.ssoClientId;
        hashMap["client_secret"] = currentConfig.ssoClientSecret;
        String type11 = type;
        NetworkHandler a = new NetworkHandler((success) {
          print("Refresh TOken");
          print(success);
          var access_token = jsonDecode(success);
          SsoStorage.saveToken(jsonEncode(access_token["data"]));
          map["access_token"] = access_token["data"]['access_token'];
          type = type11;
          excute();
        }, (f) {
          try {
            print("reGenerateAccessToken onFailure");
            print(f);
            relogin();
            //_networkHandler.failure(f);
            //_networkHandler.failure(f);
          } catch (e1) {
            print(e1);
          }
        }, (e) {
          print("reGenerateAccessToken error");
          try {
            relogin();
            print(e);
            _networkHandler.error(e);
          } catch (e1) {
            print(e1);
          }
        });
        Network network = new Network(a);
        network.setErrorReporting(true);
        network.setRequestDebug(true);
        network.postRequest(
            Environment()
                .getCurrentConfig()
                .ssoAuthUrl + Constant.USER_LOGIN,
            hashMap);
        network.excute();
      } else {
        // _networkHandler.error(e);
      }
    });
  }

  void relogin() {
    SsoStorage.getUserProfile().then((profile) {
      SsoStorage.setLogin("false");
//      Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(
//              builder: (context) => UsernamePage(profile["username"])),
//              (Route<dynamic> route) => false);

      NoomiKeys.navKey.currentState.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => UsernamePage(profile["username"])),
              (Route<dynamic> route) => false);
    });
  }

  void excutePreviousRequest() {}

  /*@override
  String getErrorReortingURL() {
    return Environment().getCurrentConfig().ssoAuthUrl + "errors/logs";
  }*/

  @override
  String getErrorReportingUrl() {
    return Environment()
        .getCurrentConfig()
        .ssoAuthUrl + "errors/logs";
  }

  @override
  Future<dynamic> getDeviceInfo() async {
    var info;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      var currentPlatform = Environment().getCurrentPlatform();
      if (currentPlatform == FsPlatforms.ANDROID) {
        AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
        //factory AndroidDeviceInfo.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
        //Map<String, dynamic> toJson() => _$BreedToJson(this);
      } else if (currentPlatform == FsPlatforms.IOS) {
        info = await deviceInfoPlugin.iosInfo;
      }
    } catch (e) {
      info = {"platofme": "Web"};
    }

    //print(jsonEncode(info));
    return info.toString();
  }

  @override
  Future<dynamic> getUserProfile() {
    return SsoStorage.getUserProfile();
  }

  @override
  String getAppName() {
    return "CubeOneApp";
  }
}

class NetworkHandler {
  void Function(String) success;
  void Function(String) failure;
  void Function(String) error;

  NetworkHandler(void Function(String) success, void Function(String) failure,
      void Function(String) error) {
    this.error = error;
    this.success = success;
    this.failure = failure;
  }
}
