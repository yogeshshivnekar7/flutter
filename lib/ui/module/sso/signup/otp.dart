import 'dart:async';
import 'dart:convert';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/otp/otp_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/otp/otp_view.dart';
import 'package:sso_futurescape/ui/module/sso/change_password/change_password.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_databse_sso.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class OtpPage extends StatefulWidget {
  String otpFor;
  String username;
  bool success_dialog_requred = false;
  Map<String, String> userData;

  @override
  State<StatefulWidget> createState() {
    return _OtpPageState(userData, username, otpFor,
        success_dialog_requred: success_dialog_requred);
  }

  OtpPage(Map<String, String> userData,
      {String username, String otpFor, bool success_dialog_requred}) {
    this.username = username;
    this.otpFor = otpFor;
    this.userData = userData;
    this.success_dialog_requred = success_dialog_requred;
  }
}

class _OtpPageState extends State<OtpPage> implements OtpView {
  TextEditingController optController1 = new TextEditingController();
  TextEditingController optController2 = new TextEditingController();
  TextEditingController optController3 = new TextEditingController();
  TextEditingController optController4 = new TextEditingController();

  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  FocusNode myFocusNode3 = new FocusNode();
  FocusNode myFocusNode4 = new FocusNode();

  String otpFor;
  String otpErrorMsg;
  String username;
  int timeSecond = MAX_SECOND;
  bool success_dialog_requred = false;
  Timer timers;

  static int MAX_SECOND = 59;

  OtpPresenter otpPresenter;

  Map<String, String> userData;
  String mobileNumber;

  int counter = 0;

  _OtpPageState(Map<String, String> userData, String username, String otpFor,
      {bool success_dialog_requred}) {
    this.username = username;
    this.otpFor = otpFor;
    this.userData = userData;
    this.success_dialog_requred = success_dialog_requred;
    print(this.username);
    print(this.otpFor);
    print(this.userData);
    print(this.success_dialog_requred);
    /*print("ddddddddddddddddddddddeeeeeeee");
    print(userData);*/
    if (userData == null ||
        userData["display"] == null ||
        userData["display"] == 'null') {
      this.mobileNumber = username;
      print(this.mobileNumber);
    } else {
      this.mobileNumber = userData["display"];
      print(this.mobileNumber);
    }

    otpPresenter = new OtpPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _timerCall();
    optController1.addListener(listener1);
    optController2.addListener(listener2);
    optController3.addListener(listener3);
    optController4.addListener(listener4);
    _sendOtp();

    /*access_token:DkaOYwwsqYDiwIx4nBVhhuzNQmEbDLKU4ppet4H0
contact:parag.kamble@futurescapetech.com
update_to:email/mobile/username/none
//source:Vizlog */
  }

  void _sendOtp() {
    try {
      SsoStorage.getOtpCounter(otpFor).then((data) {
        try {
          print("getOtpCounter------------ $data");
          if (data != null /*&& data["user_id"] == userData["user_id"]*/ &&
              data["date"] == AppUtils.getCurrentHour()) {
            if (data["count"] <= 2) {
              counter = data["count"];
              counter++;
              data["count"] = counter;
              callOtp(data);
            } else {
              Toasly.error(
                  context, "limit exceeded \n please try after an hour!!");
            }
          } else {
            counter++;
            var data = {
//            "user_id": userData["user_id"],
              "count": counter,
              "date": AppUtils.getCurrentHour()
            };
            callOtp(data);
          }
          setState(() {});
        } catch (e) {
          counter++;
          var data = {
//            "user_id": userData["user_id"],
            "count": counter,
            "date": AppUtils.getCurrentHour()
          };
          callOtp(data);
        }
      });
    } catch (e) {
      print(e);
      counter++;
      var data = {
//            "user_id": userData["user_id"],
        "count": counter,
        "date": AppUtils.getCurrentHour()
      };
      callOtp(data);
    }
  }

  void callOtp(data) {
    SsoStorage.setOtpCounter(otpFor, data);
    _timerCall();
    otpCall();
    setState(() {});
  }

  void otpCall() {
    otpPresenter.sendOtp(otpFor, mobileNumber, userData);
  }

  void _timerCall() {
    setState(() {
      timeSecond = MAX_SECOND;
    });

    print(timeSecond);
    this.timers = Timer.periodic(new Duration(seconds: 1), (timer) {
      _timeOutTick(timer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: FsBackButton(),
        ),
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
                            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                            child: Stack(
                              children: <Widget>[
                                new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'we have sent you an OTP\non ${getSendOnUsername()}',
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy-Bold',
                                                  fontSize: 18.0,
                                                  height: 1.5,
                                                  letterSpacing: 1.0,
                                                  color: FsColor.darkgrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'enter the 4 digit OTP to proceed',
                                                  style: TextStyle(
                                                      fontFamily: 'Gilroy-Bold',
                                                      fontSize: 13.0,
                                                      height: 1.5,
                                                      color: FsColor.darkgrey
                                                          .withOpacity(0.8)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  width: 50.0,
                                  child: new TextField(
                                    focusNode: myFocusNode1,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: optController1,
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (String value) {
                                      print(
                                          "--------------------------------------------------------" +
                                              value);
                                    },
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: FSTextStyle.h2size,
                                        color: FsColor.darkgrey,
                                        fontFamily: "Gilroy-Bold"),
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: FsColor.basicprimary,
                                                width: 1.0))),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(1.0, 0, 1.0, 0),
                                ),
                                new Container(
                                  width: 50.0,
                                  child: new TextField(
                                    focusNode: myFocusNode2,
                                    controller: optController2,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (String value) {
                                      print(
                                          "--------------------------------------------------------" +
                                              value);
                                    },
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: FSTextStyle.h2size,
                                        color: FsColor.darkgrey,
                                        fontFamily: "Gilroy-Bold"),
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: FsColor.basicprimary,
                                                width: 1.0))),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(1.0, 0, 1.0, 0),
                                ),
                                new Container(
                                  width: 50.0,
                                  child: new TextField(
                                    focusNode: myFocusNode3,
                                    controller: optController3,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (String value) {
                                      print(
                                          "--------------------------------------------------------" +
                                              value);
                                    },
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: FSTextStyle.h2size,
                                        color: FsColor.darkgrey,
                                        fontFamily: "Gilroy-Bold"),
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: FsColor.basicprimary,
                                                width: 1.0))),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(1.0, 0, 1.0, 0),
                                ),
                                new Container(
                                  width: 50.0,
                                  child: new TextField(
                                    onSubmitted: (String value) {
                                      print(
                                          "--------------------------------------------------------" +
                                              value);
//                                      Navigator.pop(context, "ok");
                                    },
                                    focusNode: myFocusNode4,
                                    controller: optController4,
                                    /*maxLength: 1,*/
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontSize: FSTextStyle.h2size,
                                        color: FsColor.darkgrey,
                                        fontFamily: "Gilroy-Bold"),
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: FsColor.basicprimary,
                                                width: 1.0))),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(1.0, 0, 1.0, 0),
                                )
                              ]),
                          otpErrorMsg != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                      child: Text(
                                        otpErrorMsg,
                                        style: new TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            color: FsColor.red,
                                            fontFamily: "Gilroy-Regular"),
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          Container(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 0.0, right: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                timeSecond <= 0
                                    ? Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(
                                            top: 15.0, left: 0.0, right: 0.0),
                                        child: GestureDetector(
                                          child: FlatButton(
                                              padding:
                                                  EdgeInsets.only(left: 0.0),
                                              onPressed: () {
//                                                print("counter ------- "+counter.toString());

                                                _sendOtp();
                                              },
                                              child: new Text(
                                                "Resend OTP",
                                                style: new TextStyle(
                                                    fontSize: 14.0,
                                                    color: counter < 3
                                                        ? FsColor.basicprimary
                                                        : FsColor.lightgreybg,
                                                    fontFamily: "Gilroy-Bold"),
                                              )),
                                        ),
                                      )
                                    : new Container(),
                                Container(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.only(
                                      top: 15.0, left: 0.0, right: 0.0),
                                  child: Text(
                                    '$timeSecond s',
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: 16.0,
                                        color: FsColor.darkgrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            child: RaisedButton(
                              padding:
                                  EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              child: Text('Clear',
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold')),
                              onPressed: () {
                                _clearAll();
                                // _futureloginshowDialog();
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => InterestPage()),
                                );*/
                              },
                              color: FsColor.basicprimary,
                              textColor: FsColor.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 20,
                        ),
                        isLoading
                            ? Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            child: CircularProgressIndicator(
                              valueColor:
                              new AlwaysStoppedAnimation<Color>(
                                  Colors.black),
                            ),
                          ),
                        )
                            : Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(
                                  30.0, 10.0, 30.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(4.0),
                              ),
                              child: Text('Proceed',
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold')),
                              onPressed: () {
                                _verifyOtpUI();
                                // _futureloginshowDialog();
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => InterestPage()),
                                );*/
                              },
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

  void _verifyOtp() {
    print("listener4");
    var otpString1 = optController1.text.toString();
    var otpString2 = optController2.text.toString();
    var otpString3 = optController3.text.toString();
    var otpString4 = optController4.text.toString();
    String otpCommon = otpString1 + otpString2 + otpString3 + otpString4;
    print(otpFor);
    if (otpCommon.length == 4) {
      isLoading = true;
      if (otpFor == "login") {
        otpPresenter.loginUsingOtp(userData, otpCommon);
      } else if (otpFor == forgot_password) {
        otpPresenter.verifyforgotPasswordUsingOtp(userData, otpCommon);
      } else if (otpFor == "email") {
        otpPresenter.verifyEmailMobileUsingOTP(userData, otpFor, otpCommon);
      } else {
        otpPresenter.verifyConatctInfo(userData, otpCommon);
      }
    } else {
      if (otpCommon.length == 0) {
        otpErrorMsg = "Please enter otp";
      } else {
        otpErrorMsg = "Please enter valid otp";
      }
      setState(() {});
    }
  }

  //<created/updated>
  String createdOrUpdatred = "created";

  void _otpverifiedshowDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "congratulations",
            textAlign: TextAlign.center,
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Text(
                "your account is successfully $createdOrUpdatred. please use your mobile number for login next time",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey)),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  child: new Text(
                    "Done",
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.white),
                  ),
                  color: FsColor.basicprimary,
                  onPressed: () {
                    Navigator.of(context).pop();
                    try {
                      SsoStorage.setMobileUpdated("true");
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/interest', ModalRoute.withName('/interest'));
                    } catch (e) {
                      print(e);
                    }

                    // Navigator.of(context).pop();
                  },
                ),
              ],
            )
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  /* bool facus4=false;*/
  void listener3() {
    chnageFocus(optController3, myFocusNode4);
  }

  void chnageFocus(TextEditingController optController3,
      FocusNode myFocusNode4) {
    if (optController3.text.trim() == "") {} else {
      print("listener3");
      setState(() {
        FocusScope.of(context).requestFocus(myFocusNode4);
      });
    }
  }

  void listener4() {
    if (optController4.text.trim() == "") {} else {
      print("listener3");
      FocusScope.of(context).requestFocus(FocusNode());
//      _verifyOtpUI();
    }
  }

  void listener2() {
    chnageFocus(optController2, myFocusNode3);
  }

  void listener1() {
    chnageFocus(optController1, myFocusNode2);
  }

  /* void handleTimeout() {
    print("");
  }*/
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (timers != null) timers.cancel();
    optController1.dispose();
    optController2.dispose();
    optController3.dispose();
    optController4.dispose();
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();
    myFocusNode4.dispose();
  }

  void _timeOutTick(Timer timer) {
    //print("ssssssss");
    //print(timeSecond);
    //print(timer.tick);
    //print("ssssssss");
    setState(() {
      if (timeSecond > 0) {
        var tick = timer.tick;
        if (tick == null) {
          tick = 0;
        }
        timeSecond = (MAX_SECOND - tick);
      } else {
        timer.cancel();
        //timers.cancel();
        timeSecond = 0;
      }
    });
  }

  @override
  void hideProgress() {}

  @override
  void onError(String error) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSuccess() {}

  @override
  void showProgress() {}

  @override
  loginError(error) {
    print(error);
    setState(() {
      if (error["error"] == 'otp_missmatch') {
        otpErrorMsg = 'OTP  does not match';
      } else {
        otpErrorMsg = error["error"];
      }
      isLoading = false;
    });
  }

  @override
  loginFailed(failed) {
    print(failed);
    setState(() {
      isLoading = false;
      if (failed["error"] == 'otp_missmatch') {
        otpErrorMsg = 'OTP  does not match';
      } else {
        otpErrorMsg = AppUtils.errorDecoder(failed);
      }
    });
  }

  @override
  loginSuccess(succes) {
    timers.cancel();
    print(succes);
    try {
      SsoStorage.setLogin("true");
      SsoStorage.setMobileUpdated("true");
      SsoStorage.saveToken(jsonEncode(succes["data"]));
      /*Navigator.of(context).pushNamedAndRemoveUntil(
          '/interest', ModalRoute.withName('/interest'));*/

      FirebaseDatabaseSSO.getIntrest().then((x) {
//        print(x);
        if (x != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/loading', ModalRoute.withName('/loading'));
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/interest', ModalRoute.withName('/interest'));
        }
      }).catchError((e) {
        print(e);
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/interest', ModalRoute.withName('/interest'));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  otpVerificationError(error) {
    setState(() {
      isLoading = false;
      otpErrorMsg = error["error"];
    });
  }

  @override
  otpVerificationFailed(falure) {
    setState(() {
      isLoading = false;
      otpErrorMsg = falure["error"];
    });
  }

  var forgot_password = "forgot_password";
  var UPDATE_USERNAME = "UPDATE_USERNAME";

  @override
  otpVerificationSuccess(success) {
    setState(() {
      otpErrorMsg = "";
      isLoading = false;
    });
    print(otpFor);
    if (otpFor == "email") {
      Navigator.of(context).pop({"otpFor": otpFor, "result": "success"});
    } else if (otpFor == forgot_password) {
      Navigator.of(context).pop();
      try {
        String fp_auth_code = success['data']['fp_auth_code'];
//        Navigator.pushNamed(context, '/change_password');
        print(fp_auth_code);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangePasswordPage(fp_auth_code, userData)),
        );
      } catch (e) {
        print(e);
      }
    } else {
      if (otpFor == UPDATE_USERNAME) {
        setState(() {
          createdOrUpdatred = "updated";
        });
      } else if (otpFor == "login") {
        setState(() {
          createdOrUpdatred = "created";
        });
      }
      if (success_dialog_requred) {
        _otpverifiedshowDialog();
      }
    }
  }

  bool isLoading = false;

  void _verifyOtpUI() {
    setState(() {
      isLoading = false;
      otpErrorMsg = null;
    });
/*
    FocusScope.of(context).requestFocus(FocusNode());
*/
    _verifyOtp();
  }

  void _clearAll() {
    setState(() {
      isLoading = false;
      optController1.text = "";
      optController2.text = "";
      optController3.text = "";
      optController4.text = "";
      FocusScope.of(context).requestFocus(myFocusNode1);
    });
  }

  @override
  void otpSendingFailed(failed) {
    try {
      Toasly.error(context, AppUtils.errorDecoder(failed));
      Navigator.pop(context);
    } catch (e) {}
  }

  String getSendOnUsername() {
    if (int.tryParse(mobileNumber) != null) {
      return 'mobile number (+$mobileNumber)';
    } else {
      if (userData == null || userData['email'] == null) {
        return 'email (+$mobileNumber)';
      }
      return 'email (${userData['email'].toString()})';
    }
  }
}
