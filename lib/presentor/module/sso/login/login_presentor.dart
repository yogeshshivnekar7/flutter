import 'package:sso_futurescape/presentor/module/sso/login/login_model.dart';
import 'package:sso_futurescape/presentor/module/sso/login/login_view.dart';

class LoginPresentor {
  LoginView _loginView;

  /*IUserLogin _iUserLogin;*/ /*IUserLogin _iUserLogin;*/
  LoginPresentor(LoginView _loginView) {
    this._loginView = _loginView;
  }

  userCheckUserName(String username) {
    LoginModel model = new LoginModel();
    model.checkUserName(username, _loginView.userFound, _loginView.userNotFound,
        _loginView.userCheckFailure);
  }

  userLogin(String username, String password) {
    LoginModel model = new LoginModel();
    String mobileNumber = username;
    /* String password = "918149229032";*/
    model.loginWithPassword(mobileNumber, password, _loginView.loginSuccess,
        _loginView.loginFailed, _loginView.loginError);
  }

  void finalChecking(String userName, foundCallBack, notFoundCallBack,
      failedCallBack) {
    LoginModel model = new LoginModel();
    model.checkUserName(
        userName, foundCallBack, notFoundCallBack, failedCallBack);
  }
}
