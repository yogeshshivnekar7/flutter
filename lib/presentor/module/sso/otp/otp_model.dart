import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/presentor/module/sso/otp/otp_view.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class OtpModel {
  OtpModel();

  void generateOtp(int userId) {}

  void sendOtp(otpFailed, String callingType, String username, var userData) {
    NetworkHandler network = new NetworkHandler((s) {
      print(s);
    }, (f) {
      print(f);
      otpFailed(jsonDecode(f));
    }, (e) {
      print(e);
    });

    if (callingType == "login") {
      Network sendOptNetwork =
      SSOAPIHandler.sendOtpForLogin(userData["user_id"], network);
      sendOptNetwork.excute();
    } else if (callingType == "forgot_password") {
      print("callingType   $callingType");
      Network sendOptNetwork =
      SSOAPIHandler.sendOtpForForgotPassword(
          userData["username"], userData["user_id"], network);
      sendOptNetwork.excute();
    } else if (callingType == "UPDATE_USERNAME") {
      SsoStorage.getToken().then((token) {
        var tokensss;
        /*if (token != null) {*/
          var access = jsonDecode(token);
          tokensss = access["access_token"];
        /*} else {
          tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
        }*/
        print(tokensss);
        Map<String, String> hashMap = userData;
        hashMap["access_token"] = tokensss;
        Network sendOptNetwork = SSOAPIHandler.sendContactOtp(hashMap, network);
        sendOptNetwork.excute();
      }).catchError((e) {
        print(e);
      });
    } else if (callingType == "email") {
      print("verify Emaill");
      SsoStorage.getToken().then((token) {
        var tokensss;
        /*if (token != null) {*/
          var access = jsonDecode(token);
          tokensss = access["access_token"];
        /*} else {
          tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
        }*/
        print(tokensss);
        Map<String, String> hashMap = new HashMap();
        hashMap["access_token"] = tokensss;
        hashMap["user_id"] = userData["user_id"];
        hashMap["source"] = "CUBEONE";
        //hashMap["email"] = "amit.kumar@futurescapetech.com"; //userId["email"];
        hashMap["verification_type"] = "email";
        Network sendOptNetwork = SSOAPIHandler.sendOtpForVerification(
            hashMap, network);
        sendOptNetwork.excute();
      }).catchError((e) {
        print(e);
      });
    }
  }

  void verifyConatctInfo(Map<String, String> userData, String otpCommon,
      OTPVerify otpView) {
    NetworkHandler network = new NetworkHandler((s) {
      print(s);
      otpView.otpVerificationSuccess(jsonDecode(s));
    }, (f) {
      print(f);
      otpView.otpVerificationFailed(jsonDecode(f));
    }, (e) {
      otpView.otpVerificationError(e);
      print(e);
    });
    SsoStorage.getToken().then((token) {
      var tokensss;
      /*if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /*} else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      Map<String, String> hashMap = new HashMap();
      hashMap["otp"] = otpCommon;
      hashMap["update_to"] = "username";
      hashMap["access_token"] = tokensss;
      Network sendOptNetwork =
      SSOAPIHandler.verifyOtpForVerification(hashMap, network);
      sendOptNetwork.excute();
    }).catchError((e) {
      print(e);
    });
  }

  void verifyForgotPasswordOTP(userData, String otpCommon, OTPVerify otpView) {
    NetworkHandler network = new NetworkHandler((s) {
      print(s);
      otpView.otpVerificationSuccess(jsonDecode(s));
    }, (f) {
      print(f);
      otpView.otpVerificationFailed(jsonDecode(f));
    }, (e) {
      print(e);
      otpView.otpVerificationError(e);
    });

    SSOAPIHandler.verifyOtpForForgotPassword(userData, otpCommon, network)
        .excute();
  }

  void verifyEmailMobileUsingOTP(Map<String, String> userData, String otpFor,
      String otpCommon, OtpView otpView) {
    NetworkHandler network = new NetworkHandler((s) {
      print(s);
      otpView.otpVerificationSuccess(jsonDecode(s));
    }, (f) {
      print(f);
      otpView.otpVerificationFailed(jsonDecode(f));
    }, (e) {
      otpView.otpVerificationError(e);
      print(e);
    });
    SsoStorage.getToken().then((token) {
      var tokensss;
      /*  if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /*} else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      Map<String, String> hashMap = new HashMap();
      //hashMap["access_token"] = tokensss;
      hashMap["otp"] = otpCommon;
      hashMap["user_id"] = userData["user_id"];
      hashMap["verification_type"] = "email";
      hashMap["otp_type"] = otpFor;
      hashMap["type"] = "verify";
      Network sendOptNetwork =
      SSOAPIHandler.verifyEmailMobileOtpForVerification(hashMap, network);
      sendOptNetwork.excute();
    }).catchError((e) {
      print(e);
    });
  }
}

abstract class OTPVerify {
  otpVerificationFailed(var falure);

  otpVerificationError(var error);

  otpVerificationSuccess(var success);
}
/*abstract class OtpResponse {
  void onSuccess(String response);

  void onError(String error);
}*/
