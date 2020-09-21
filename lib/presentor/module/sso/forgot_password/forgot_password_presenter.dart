import 'forgot_password_model.dart';
import 'forgot_passwrod_view.dart';

class ForgotPasswordPresenter {
  ForgotPasswordView _forgotPasswordView;
  ForgotPasswordModel _model;

  ForgotPasswordPresenter(this._forgotPasswordView) {
    _model = new ForgotPasswordModel();
  }

  void checkMultipleAccounts(String username) {
    _model.checkMultipleAccounts(_forgotPasswordView, username);
  }

  void resetPassword(String fp_auth_code, String password, String userID) {
    _model.resetPassword(_forgotPasswordView, fp_auth_code, password, userID);
  }

  void changePassword(String password, String access_token,
      String oldPassword) {
    _model.changePassword(
        _forgotPasswordView, password, access_token, oldPassword);
  }
}
