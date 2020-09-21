import 'package:sso_futurescape/presentor/module/sso/login/login_model.dart';
import 'package:sso_futurescape/presentor/module/sso/otp/otp_model.dart';
import 'package:sso_futurescape/presentor/module/sso/otp/otp_view.dart';

class OtpPresenter {
  OtpView otpView;

  OtpModel otpModel;

  OtpPresenter(this.otpView) {
    this.otpModel = new OtpModel();
  }

  @override
  onError(String error) {}


  @override
  onSuccess(String response) {}

  void sendOtp(String otpFor, String username, var userData) {
    OtpModel model = new OtpModel();
    model.sendOtp(otpView.otpSendingFailed, otpFor, username, userData);
  }

  //8055954796

  void loginUsingOtp(var userData, String otpCommon) {
    LoginModel model = new LoginModel();
    model.loginWithOtp(userData["username"], otpCommon, otpView.loginSuccess,
        otpView.loginFailed, otpView.loginError);
  }

  void verifyforgotPasswordUsingOtp(var userData, String otpCommon) {
    OtpModel model = new OtpModel();
    model.verifyForgotPasswordOTP(userData, otpCommon, otpView);
  }

  void verifyConatctInfo(Map<String, String> userData, String otpCommon) {
    OtpModel model = new OtpModel();
    model.verifyConatctInfo(userData, otpCommon, otpView);
  }

  void verifyEmailMobileUsingOTP(Map<String, String> userData, String otpFor,
      String otpCommon) {
    OtpModel model = new OtpModel();
    model.verifyEmailMobileUsingOTP(userData, otpFor, otpCommon, otpView);
  }
}
