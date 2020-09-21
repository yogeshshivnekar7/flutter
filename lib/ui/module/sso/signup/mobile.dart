import 'dart:collection';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/sso/signup/signup_model.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/signup/otp.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/mobile_number_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class MobilePage extends StatefulWidget {
  String comingFrom;
  String data;

  static String NEW_USER = "NEW_USERS";

  static String EXISTING = "EXITING";

  MobilePage({String comingFrom, String data}) {
    this.comingFrom = comingFrom;
    this.data = data;
  }

  @override
  _MobilePageState createState() => new _MobilePageState(comingFrom, data);
}

class _MobilePageState extends State<MobilePage> implements MobileOtpView {
  String comingFrom;
  String data;
  String errorNumber = null;
  bool isAgree = false;

  MobileOtpPresentor _mobileOtpPresentor;
  ContactNumberController userNameController = new ContactNumberController();

  _MobilePageState(String comingFrom, String data) {
    this.comingFrom = comingFrom;
    this.data = data;
    print("coming from " + comingFrom);
    print("data " + data);
    _mobileOtpPresentor = new MobileOtpPresentor(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (!data.contains(new RegExp(r'[A-z]'))) userNameController.text = data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: comingFrom == MobilePage.EXISTING
                ? Container()
                : FsBackButton(
              backEvent: (context) {
                Navigator.pop(context);
                //onBackClick();
              },
            ),
            actions: <Widget>[
              comingFrom == MobilePage.EXISTING
                  ? IconButton(
                      icon: Icon(
                        FlutterIcon.logout,
                        color: const Color(0xFF8c8c8c),
                      ),
                      color: const Color(0xFF545454),
                      onPressed: () {
                        ProfileView.logOutAction(context);
                      },
                    )
                  : Container(),
            ]),
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Image.asset(
                                  'images/logo.png',
                                  fit: BoxFit.fitHeight,
                                  height: 75.0,
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                                  child: Text(
                                    comingFrom == MobilePage.NEW_USER
                                        ? FsString.HeadingCreateAccount
                                        : FsString.HeadingUpdateMobile,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-Bold',
                                        letterSpacing: 1.0,
                                        fontSize: 18.0,
                                        height: 1.5,
                                        color: FsColor.darkgrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: MobileNumberWidget(
                              controller: userNameController,
                              type: MobileNumberWidget.ONLY_MOBILE,
                            ),
                          ),
                          errorNumber != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                      child: Text(
                                        errorNumber,
                                        style: new TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.red,
                                            fontFamily: "Gilroy-Regular"),
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                        ],
                      )),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Padding(
                              child: new Checkbox(
                                value: isAgree,
                                onChanged: (bool value) {
                                  setState(() {
                                    isAgree = value;
                                  });
                                },
                                activeColor: Colors.black,
                                checkColor: FsColor.white,
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                            ),
                            new Padding(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "I agree to",
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h6size,
                                        color:
                                            FsColor.darkgrey.withOpacity(0.8)),
                                  ),
                                  GestureDetector(
                                    child: FlatButton(
                                        padding: EdgeInsets.fromLTRB(
                                            5.0, 5.0, 5.0, 5.0),
                                        onPressed: () {
                                          callTermsConditionPage();
                                        },
                                        child: Text(
                                          "terms & conditions",
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Regular',
                                              fontSize: FSTextStyle.h6size,
                                              color: FsColor.basicprimary),
                                        )),
                                  ),
                                ],
                              ),

                              // child: Text(
                              //   "I agree to terms & conditions",
                              //   style: TextStyle(
                              //       fontFamily: 'Gilroy-Regular',
                              //       fontSize: 14.0,
                              //       color: FsColor.darkgrey.withOpacity(0.8)),
                              // ),

                              padding:
                                  EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                            ),
                          ],
                        ),
                        isAgree
                            ? Container(
                                alignment: Alignment.center,
                                margin:
                                    EdgeInsets.only(bottom: 20.0, left: 20.0),
                                child: GestureDetector(
                                  child: RaisedButton(
                                    padding: EdgeInsets.fromLTRB(
                                        30.0, 10.0, 30.0, 10.0),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(4.0),
                                    ),
                                    child: Text('Agree & Continue',
                                        style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                        )),
                                    onPressed:
                                        /*() {
                                */ /*_sendOtp();*/ /*
                                _validateNumber
                              }*/
                                        _validateNumber,
                                    color: FsColor.basicprimary,
                                    textColor: FsColor.white,
                                  ),
                                ),
                              )
                            : Container(
                          alignment: Alignment.center,
                          margin:
                          EdgeInsets.only(bottom: 20.0, left: 20.0),
                          child: GestureDetector(
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(
                                  30.0, 10.0, 30.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(4.0),
                              ),
                              child: Text('Agree & Continue',
                                  style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                  )),
                              onPressed: null,
                              color: FsColor.basicprimary,
                              textColor: FsColor.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  /*void _sendOtp() {
    var userName = userNameController.getUserName();
    _mobileOtpPresentor.sendOtpForUpdateUsername(userName);
    print(userName);
  }*/

  @override
  failed(response) {
    print(response);
    print("failed");
  }

  @override
  otpSend(response) {}

  void _validateNumber() {
    errorNumber = null;
    var userName = userNameController.getUserName();
    if (userNameController.text == null ||
        userNameController.text.trim() == "") {
      setState(() {
        errorNumber = "Please enter mobile number";
      });
      return;
    } else {
      setState(() {});
    }

    if (isAgree) {
      if (comingFrom == MobilePage.EXISTING) {
        String mobileNumber = userName;
        Map<String, String> updateDate = new HashMap();
        updateDate["contact"] = mobileNumber;
        updateDate["display"] = mobileNumber;
        updateDate["update_to"] = "username";
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpPage(
                    updateDate,
                    otpFor: "UPDATE_USERNAME",
                    username: data,
                    success_dialog_requred: true,
                  )),
        );
      } else {
        HashMap<String, String> hashMap = new HashMap();
        hashMap["mobile"] = userName;
        _mobileOtpPresentor.signUp(hashMap);
      }
    }
  }

  @override
  void signUpError(error) {
    print("***********************");
    print(error);
    print("error");
  }

  @override
  void signUpFailed(failed) {
    print(failed["status_code"]);
    if (failed["status_code"] == 1011) {
      var profileData = failed["data"];
      HashMap<String, String> userData = new HashMap();
      userData["user_id"] = profileData["user_id"].toString();
      userData["username"] = profileData["username"].toString();
      userData["display"] = userNameController.getUserName();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpPage(
                  userData,
                  otpFor: "login",
                  username: userNameController.getUserName(),
                  success_dialog_requred: true,
                )),
      );
      setState(() {
        errorNumber = failed["error"];
      });
    } else if (failed["status_code"] == 422) {
      String res = AppUtils.errorDecoder(failed);

      print(res);
      setState(() {
        errorNumber = res;
      });
    } else {
      setState(() {
        errorNumber = failed["error"];
      });
    }
    print("failed");
  }

  @override
  void signUpSuccess(success) {
    print(success);
    print("success");
    var profileData = success["data"];
    HashMap<String, String> userData = new HashMap();
    userData["user_id"] = profileData["user_id"].toString();

    userData["username"] = profileData["username"].toString();
    userData["display"] = userNameController.getUserName();
    if (comingFrom != MobilePage.EXISTING) {
      FsFacebookUtils.completedRegistrationEvent(userData["username"]);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OtpPage(
                userData,
                otpFor: "login",
                username: userNameController.getUserName(),
                success_dialog_requred: true,
              )),
    );
  }

// void checkChanged(bool value){}

  Future<void> callTermsConditionPage() async {
    const url = 'https://www.cubeoneapp.com/term&conditions.php';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      Toasly.error(context, 'Could not open $url');
    }
  }

  onBackClick() {
    if (comingFrom == MobilePage.EXISTING) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      return null;
    }
  }
}

class MobileOtpPresentor {
  MobileOtpView mobileOtpView;

  MobileOtpPresentor(MobileOtpView mobileOtpView) {
    this.mobileOtpView = mobileOtpView;
  }

  /*void sendOtpForUpdateUsername(String userName) {
    MobileOtpMobile mobileOtpMobile = new MobileOtpMobile();

    mobileOtpMobile.sendOtp(
        userName, mobileOtpView.otpSend, mobileOtpView.failed);
  }*/

  void signUp(HashMap hashMap) {
    SignUpModel model = new SignUpModel();
    print(hashMap);
    model.signUpUserNewUser(hashMap, mobileOtpView.signUpSuccess,
        mobileOtpView.signUpFailed, mobileOtpView.signUpError);
  }
}

class MobileOtpMobile {}

abstract class MobileOtpView implements ISignUpResponse {
  otpSend(response);

  failed(response);
}
