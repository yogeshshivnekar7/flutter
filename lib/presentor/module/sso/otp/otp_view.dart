import 'package:sso_futurescape/presentor/module/sso/login/login_model.dart';
import 'package:sso_futurescape/presentor/module/sso/otp/otp_model.dart';

abstract class OtpView implements IUserLogin, OTPVerify {
  void onSuccess();

  void onError(String error);

  void showProgress();

  void hideProgress();

  void otpSendingFailed(var failed);
}
