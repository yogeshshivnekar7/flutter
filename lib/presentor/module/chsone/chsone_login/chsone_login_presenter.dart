import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/presentor/module/chsone/chsone_login/chsone_login_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/chsone_login/chsone_login_view.dart';
import 'package:sso_futurescape/presentor/module/chsone/chsone_login/chsone_society_detail_model.dart';

class ChsOneLoginPresenter extends RequestChsOneLogindModelResponse {
  ChsOneLoginView _chsOneLoginView;

  ChsOneLoginPresenter(this._chsOneLoginView);

  login_chsone(HashMap<String, String> hashMap) {
    ChsOneLoginModel model = new ChsOneLoginModel(this);
    model.login_chsone(hashMap);
  }

  @override
  void onError(String error) {
    _chsOneLoginView.onChsLoginError(error);
  }

  @override
  void onFailure(String error) {
    _chsOneLoginView.onChsLoginError(error);
  }

  @override
  void onSuccess(String response) {
    _chsOneLoginView.onChsLoginSuccess(response);
    SocietyDetailModel societyModel = new SocietyDetailModel();
    societyModel.getDetails(
        jsonDecode(response)["data"]['access_info']["access_token"]);
  }
}
