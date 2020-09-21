import 'dart:convert';

import 'package:sso_futurescape/presentor/module/sso/signup/signup_model.dart';
import 'package:sso_futurescape/presentor/module/sso/signup/signup_pojo.dart';
import 'package:sso_futurescape/presentor/module/sso/signup/signup_view.dart';
import 'package:sso_futurescape/utils/logger.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class SignUpPresenter extends SignUpModelResponse {
  SignUpResponseView signUpResponse;

  SignUpModel signUpModel;

  SignUpPresenter(SignUpResponseView signUpResponse) {
    this.signUpResponse = signUpResponse;
    signUpModel = new SignUpModel();

  }

  signUp(SignUpPojo signUpPojo) {
    /* if (signUpPojo.userName
        .trim()
        .isEmpty) {
      onError("Please Enter Mobile Number");
      return;
    }
    signUpResponse.showProgress();
    signUpModel.searchUser(signUpPojo);*/
  }

  @override
  onError(String error) {
    signUpResponse.hideProgress();
    signUpResponse.onError(error);
  }

  @override
  onSuccess(String response) {
    Logger.log("SignUp response - " + response);

    Map<String, dynamic> map = jsonDecode(response);

    Map<String, dynamic> data = map["data"];
    int userId = data["user_id"];
    Logger.log("userId -  $userId");
    SsoStorage.setUserId(userId);
    signUpResponse.hideProgress();
    signUpResponse.onSuccess();
  }

  @override
  void onSearchSuccess(SignUpPojo signUpPojo) {
    signUpModel.signUpUser(signUpPojo);
  }
}
