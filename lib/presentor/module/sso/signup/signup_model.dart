import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/sso/signup/signup_pojo.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class SignUpModel {
  SignUpModelResponse signUpModelResponse;

/*  SignUpModel(SignUpModelResponse signUpModelResponse) {
    this.signUpModelResponse = signUpModelResponse;
  }*/

  signUpUser(SignUpPojo signUpPojo) {
    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["first_name"] = signUpPojo.firstName;
    hashMap["last_name"] = signUpPojo.lastName;
    hashMap["password"] = signUpPojo.password;
    hashMap["mobile"] = signUpPojo.userName;
    hashMap["source"] = "cubeone";

    void success(String success) {
      signUpModelResponse.onSuccess(success);
    }

    void error(String error) {
      signUpModelResponse.onError(error);
    }

    void failure(String failure) {
      signUpModelResponse.onError(AppUtils.errorDecoder(failure));
    }

    NetworkHandler netwrkHandler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    Network networkt = SSOAPIHandler.postSignUp(netwrkHandler, hashMap);
    networkt.excute();
  }

  /* Future<void> searchUser(SignUpPojo signUpPojo) async {
    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["username"] = signUpPojo.userName;
    hashMap["source"] = "Chsone";

    void success(String success) {
      signUpModelResponse.onSearchSuccess(signUpPojo);
    }

    void error(String error) {
      signUpModelResponse.onError(error);
    }

    void failure(String failure) {
      signUpModelResponse.onError(AppUtils.errorDecoder(failure));
    }

    NetworkHandler netwrkHandler = new NetworkHandler(
        (response) => {success(response)},
        (response) => {failure(response)},
        (response) => {error(response)});

    Network network = SSOAPIHandler.searchUser(netwrkHandler, hashMap);
    network.excute();
  }
*/
  void signUpUserNewUser(HashMap hashMap, signUpSuccess, signUpFailed,
      signUpError) {
    hashMap["source"] = "Chsone";
    /*  void success(String success) {}
    void error(String error) {}
    void failure(String failure) {}*/
    NetworkHandler netwrkHandler = new NetworkHandler((s) {
      signUpSuccess(jsonDecode(s));
    }, (f) {
      signUpFailed(jsonDecode(f));
    }, (e) {
      signUpError(e);
    });

    Network network = SSOAPIHandler.postSignUp(netwrkHandler, hashMap);
    network.excute();
  }
}

abstract class SignUpModelResponse {
  void onSuccess(String response);

  void onSearchSuccess(SignUpPojo signUpPojo);

  void onError(String error);
}

abstract class ISignUpResponse {
  void signUpSuccess(var success);

  void signUpFailed(var failed);

  void signUpError(var failed);
}
