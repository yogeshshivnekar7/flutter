import 'dart:convert';

import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/forgot_password/forgot_password_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/sso/login/login_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/sso/identify_account/identify_account.dart';
import 'package:sso_futurescape/ui/module/sso/signup/mobile.dart';
import 'package:sso_futurescape/ui/module/sso/signup/otp.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_databse_sso.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class PasswordPage extends StatefulWidget {
  String userName;
  var userData;

  PasswordPage(String password, {var userData}) {
    this.userName = password;
    this.userData = userData;
  }

  @override
  _PasswordPageState createState() =>
      new _PasswordPageState(userName, userData: userData);
}

class _PasswordPageState extends State<PasswordPage> implements LoginView {
  String userName;
  bool isProgress = false;
  LoginPresentor loginPresentor; //=new LoginPresentor(_loginView);
  String passwordError = null;

  bool _showPassword = false;

  var userData;

  @override
  void initState() {
    super.initState();
    loginPresentor = new LoginPresentor(this);
  }

  var passwordController = TextEditingController();

  _PasswordPageState(String password, {this.userData}) {
    this.userName = password;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: FsBackButton(),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
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
                                    'enter your password',
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
                          ),
                          Container(
                            child: TextField(
                              obscureText: !_showPassword,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      color: FsColor.basicprimary,
                                      icon: Icon(_showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      }),
                                  errorText: passwordError,
                                  hintText: "password",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      color: FsColor.darkgrey),
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: FsColor.basicprimary))),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.only(
                                top: 0.0, left: 0.0, right: 0.0),
                            child: GestureDetector(
                              child: FlatButton(
                                  key: null,
                                  onPressed: () {
                                    ForgotPasswordPresenter
                                        _forgotPasswordPresenter =
                                        new ForgotPasswordPresenter(this);
                                    _forgotPasswordPresenter
                                        .checkMultipleAccounts(userName);
                                  },
                                  child: new Text(
                                    "forgot password?",
                                    style: new TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.basicprimary,
                                        fontFamily: "Gilroy-Bold"),
                                  )),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !isProgress
                            ? Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: GestureDetector(
                                  child: RaisedButton(
                                    padding: EdgeInsets.fromLTRB(
                                        30.0, 10.0, 30.0, 10.0),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(4.0),
                                    ),
                                    child: Text('Login',
                                        style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                        )),
                                    onPressed: () {
                                      _loginUsingPasswordClick();
                                    },
                                    color: FsColor.basicprimary,
                                    textColor: FsColor.white,
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: GestureDetector(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.black),
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

  BuildContext _loginUsingPassword() {
    setState(() {
      passwordError = null;
    });
    var password = passwordController.text.trim();
    if (password == "") {
      passwordError = "please enter password";
    } else {
      setState(() {
        isProgress = true;
      });
      loginPresentor.userLogin(userName, password);
    }

    // context,MaterialPageRoute(builder: (context) => MobilePage(MobilePage.EXISTING,"")),);
  }

  void _supportshowDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "alert!",
            textAlign: TextAlign.center,
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Text(
                "we no longer support log in via email/username and password combination. \nplease add your mobile number for login.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: 15.0,
                    color: FsColor.darkgrey)),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            RaisedButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4.0),
              ),
              child: new Text(
                "Add Now",
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.white),
              ),
              color: FsColor.basicprimary,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _loginUsingPassword();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  loginError(error) {
    print(error);
    setState(() {
      isProgress = false;
    });
//    setState(() {
//      isLoadind = false;
//    });

    FsNavigator.push(context, ErrorNoInternetPage());
  }

  @override
  loginFailed(failed) {
    print(failed);
    setState(() {
      isProgress = false;
      if (failed['error'] == 'The user credentials were incorrect.') {
        passwordError =
            'Wrong password. try again or click forgot password to reset it.';
      } else {
        passwordError = failed["error"];
      }
    });
  }

  @override
  loginSuccess(succes) {
    SsoStorage.setLogin("true");

    SsoStorage.saveToken(jsonEncode(succes["data"]));
    //print("ssssssssssssssssssssssssssssss");
    print(succes);
    var isUserProfileIsNUmber = false;
    if (userData != null) {
      var userNameFromProfile = userData["username"].toString();
      isUserProfileIsNUmber = int.tryParse(userNameFromProfile) == null;
      print(isUserProfileIsNUmber);
    }
    print("FGGSGSGSGGSGSGGSGSGSG");

    if (int.tryParse(userName) == null || isUserProfileIsNUmber) {
      isProgress = false;
      SsoStorage.setMobileUpdated("false");
      SsoStorage.setUserName(userName);
      print(succes);
      print("tryParsetryParsetryParsetryParsetryParse");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MobilePage(comingFrom: MobilePage.EXISTING, data: userName),
          ),
              (Route<dynamic> route) => false);
    } else {
      SsoStorage.setMobileUpdated("true");
      //Navigator.popUntil(context, ModalRoute.withName('/splash'));
      print("setMobileUpdatedsetMobileUpdatedsetMobileUpdatedsetMobileUpdated");
      //Navigator.pushNamed(context, '/interest');
      try {
        FirebaseDatabaseSSO.getIntrest().then((x) {
          print(x);
          print("tttttttttttttttttttttt");
          isProgress = false;
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
        print("ffffffffff");
        print(e);
      }
    }
  }

  @override
  userCheckFailure(error) {}

  @override
  userFound(data) {}

  @override
  userNotFound(username) {}

  void _loginUsingPasswordClick() {
    _loginUsingPassword();
  }

  @override
  onErrorUserAccount(error) {
    // TODO: implement onError
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  onFailureUserAccount(failed) {
    // TODO: implement onFailure
    Toasly.error(context, AppUtils.errorDecoder(failed));
  }

  @override
  onUserAccountFound(accounts) {
    // TODO: implement onUserAccountFound
    print("DataaaaaaAA");
    List userData = accounts["data"];
    print("Dataaaaaa");
    print(userData);
    if (userData.length == 1) {
      print("Size 1");
      print(userData[0]);
      Map<String, String> map = new Map<String, String>();
      map["username"] = userData[0]["username"];
      map["user_id"] = userData[0]["user_id"].toString();
      map["display"] = userData[0]["mobile"].toString();
      map["email"] = userData[0]["email"];
      map["mobile"] = userData[0]["mobile"].toString();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OtpPage(map, username: userName, otpFor: "forgot_password")),
      );
    } else {
      print("Size 2");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IdentifyAccountPage(userName, userData))
          //ResetPasswordPage(userName)),
          );
    }
  }
}
