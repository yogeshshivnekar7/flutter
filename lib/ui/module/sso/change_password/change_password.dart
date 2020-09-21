import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/forgot_password/forgot_password_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/forgot_password/forgot_passwrod_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/sso/signup/password.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() =>
      new _ChangePasswordPageState(fp_auth_code, userData);
  String fp_auth_code;
  Map<String, String> userData;

  ChangePasswordPage(this.fp_auth_code, this.userData);
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    implements ForgotPasswordView {
  TextEditingController newpasswrodController = new TextEditingController();
  TextEditingController confirmNewPasswordController =
      new TextEditingController();
  bool newpasswrodValid = false, confirmNewPasswordValid = false;
  String fp_auth_code;
  ForgotPasswordPresenter _presenter;

  Map<String, String> userData;

  String errorNewMessage;

  String errorConfirmMessage;

  _ChangePasswordPageState(this.fp_auth_code, this.userData);

  @override
  void initState() {
    _presenter = new ForgotPasswordPresenter(this);
    super.initState();
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
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
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
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                                  child: Text(
                                    'enter your new\npassword',
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
                              controller: newpasswrodController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText:
                                      newpasswrodValid ? errorNewMessage : null,
                                  hintText: "enter new password",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      color: FsColor.darkgrey),
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: FsColor.basicprimary))),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextField(
                              controller: confirmNewPasswordController,
                              obscureText: true,
                              onChanged: (text) {
                                String newPassword =
                                    newpasswrodController.text.trim();
                                if (newPassword != text) {
                                  setState(() {
                                    confirmNewPasswordValid = true;
                                  });
                                } else {
                                  setState(() {
                                    confirmNewPasswordValid = false;
                                  });
                                }
                                //print("First text field: $text");
                              },
                              decoration: InputDecoration(
                                  errorText: confirmNewPasswordValid
                                      ? errorConfirmMessage
                                      : null,
                                  hintText: "confirm new password",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      color: FsColor.darkgrey),
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: FsColor.basicprimary))),
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
                          margin: EdgeInsets.only(
                              bottom: 20.0, top: 20.0, left: 20.0),
                          child: GestureDetector(
                            child: RaisedButton(
                              padding:
                                  EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                              child: Text('Change Password',
                                  style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                  )),
                              onPressed: () {
                                changePasswrodApi(context);
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

  void changePasswrodApi(BuildContext context) {
    print('changePasswrodApi');
    String newPassword = newpasswrodController.text.trim();
    //String confirmPassword = confirmNewPasswordController.text.trim();
    if (isValid()) {
      _presenter.resetPassword(fp_auth_code, newPassword, userData["user_id"]);
    }
  }

//  bool isValid() {
//    bool isValid = true;
//    String newPassword = newpasswrodController.text.trim();
//    String confirmPassword = confirmNewPasswordController.text.trim();
//    if (newPassword.isEmpty || !(newPassword.length > 7)) {
//      setState(() {
//        newpasswrodValid = true;
//      });
//      Toasly.error(
//          context, "Please enter new password and must be 8 character!");
//      isValid = false;
//    } else {
//      setState(() {
//        newpasswrodValid = false;
//      });
//    }
//    if (confirmPassword.isEmpty || !(confirmPassword.length > 7)) {
//      isValid = false;
//      setState(() {
//        confirmNewPasswordValid = true;
//      });
//      Toasly.error(context,
//          "Please enter confirm new password and must be 8 character!");
//    } else {
//      setState(() {
//        confirmNewPasswordValid = false;
//      });
//    }
//    if (isValid) {
//      if (newPassword != confirmPassword) {
//        isValid = false;
//        Toasly.error(context, "Please check both does not match!");
//        setState(() {
//          confirmNewPasswordValid = true;
//        });
//      } else {
//        setState(() {
//          confirmNewPasswordValid = false;
//        });
//      }
//    }
//    return isValid;
//  }
  bool isValid() {
    bool isValid = true;
    String newPassword = newpasswrodController.text.trim();
    String confirmPassword = confirmNewPasswordController.text.trim();
//    String oldPassword = oldpasswrodController.text.trim();
    if (newPassword.isEmpty || !(newPassword.length > 7)) {
      setState(() {
        newpasswrodValid = true;
        errorNewMessage = "The password must be atleast 8 character";
        return false;
      });

      Toasly.error(context, "The password must be atleast 8 character");
      isValid = false;
    } else {
      setState(() {
        newpasswrodValid = false;
      });
    }
    if (confirmPassword.isEmpty || !(confirmPassword.length > 7)) {
      isValid = false;
      setState(() {
        confirmNewPasswordValid = true;
        errorConfirmMessage = "The password must be atleast 8 character";
        return false;
      });
      Toasly.error(context, "The password must be atleast 8 character");
    } else {
      setState(() {
        confirmNewPasswordValid = false;
      });
    }
//    if (password_status) {
//      if (oldPassword.isEmpty) {
//        isValid = false;
//        setState(() {
//          oldPasswordValid = true;
//        });
//        Toasly.error(context, "Please enter old new password!");
//      } else {
//        setState(() {
//          oldPasswordValid = false;
//        });
//      }
//    }

    if (isValid) {
      if (newPassword != confirmPassword) {
        isValid = false;

//        Toasly.error(context, "Please check both does not match!");
        setState(() {
          errorConfirmMessage = "Confirm password does not match";
          confirmNewPasswordValid = true;
        });
      } else {
        setState(() {
          confirmNewPasswordValid = false;
        });
      }
    }
    return isValid;
  }

  @override
  onError(error) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  onFailure(failure) {
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure));
  }

  @override
  onUserAccountFound(accounts) {
    Toasly.success(context, "Password Changed Successfully!");
    // TODO: implement onUserAccountFound
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordPage(userData['username']),
        ),
        ModalRoute.withName('/'));
  }

  @override
  void onErrorUserAccount(error) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  void onFailureUserAccount(failure) {
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure));
  }
}
