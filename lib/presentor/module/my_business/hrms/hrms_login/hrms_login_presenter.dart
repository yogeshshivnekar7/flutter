import 'dart:collection';

import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'hrms_login_model.dart';
import 'hrms_login_view.dart';

class HRMSLoginPresenter extends RequestHRMSLoginModelResponse {
  HRMSLoginView _hrmsLoginView;

  HRMSLoginPresenter(this._hrmsLoginView);

  login_hrms() {
    HRMSLoginModel model = new HRMSLoginModel(this);
    SsoStorage.getUserProfile().then((_userProfiew) {
      HashMap<String, String> hashMap = new HashMap();
      hashMap["grant_type"] = "password";
      hashMap["auto_login"] = "1";
      hashMap["session_token"] = _userProfiew["session_token"];
      hashMap["platform"] = AppUtils.getDeviceCode();
      hashMap["username"] = _userProfiew["username"];
      SsoStorage.getHRMSCompany().then((_companies) {
        List _companies1 = _companies;
        hashMap["api_key"] =
            _companies1[0]['api_keys'][AppUtils.getDeviceCode()]['api_key'];
        model.login_hrms(hashMap);
      });
    });
  }

  @override
  void onError(String error) {
    _hrmsLoginView.onHRMSLoginError(error);
  }

  @override
  void onFailure(String error) {
    _hrmsLoginView.onHRMSLoginError(error);
  }

  @override
  void onSuccess(String response) {
    SsoStorage.setHRMSToken(response);
    _hrmsLoginView.onHRMSLoginSuccess(response);
  }
}
