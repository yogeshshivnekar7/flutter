import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

import 'forgot_passwrod_view.dart';

class ForgotPasswordModel {
  void checkMultipleAccounts(ForgotPasswordView passwordView, String username) {
    NetworkHandler a = new NetworkHandler((s) {
      passwordView.onUserAccountFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      passwordView.onFailureUserAccount(userFalure);
    }, (e) {
      passwordView..onErrorUserAccount(e);
    });
    Network network = SSOAPIHandler.checkMultipleAccounts(username, a);
    network.excute();
  }

  void resetPassword(ForgotPasswordView passwordView, String fp_auth_code,
      String password, String userID) {
    NetworkHandler a = new NetworkHandler((s) {
      passwordView.onUserAccountFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      passwordView.onFailureUserAccount(userFalure);
    }, (e) {
      passwordView..onErrorUserAccount(e);
    });
    Network network =
    SSOAPIHandler.sendResetPassword(fp_auth_code, password, userID, a);
    network.excute();
  }

  void changePassword(ForgotPasswordView passwordView, String password,
      String access_token, String oldPassword) {
    NetworkHandler a = new NetworkHandler((s) {
      print("NetworkHandlerNetworkHandlerNetworkHandlerNetworkHandler");
      passwordView.onUserAccountFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      passwordView.onFailureUserAccount(userFalure);
    }, (e) {
      passwordView..onErrorUserAccount(e);
    });
    Network network = SSOAPIHandler.sendChangePassword(
        password, access_token, oldPassword, a);
    network.excute();
  }
}
