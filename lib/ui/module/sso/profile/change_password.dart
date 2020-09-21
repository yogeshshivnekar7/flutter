import 'dart:convert';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/forgot_password/forgot_password_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/forgot_password/forgot_passwrod_view.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => new _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    implements ForgotPasswordView, ProfileResponseView {
  TextEditingController newpasswrodController = new TextEditingController();
  TextEditingController oldpasswrodController = new TextEditingController();
  TextEditingController confirmNewPasswordController =
      new TextEditingController();
  bool newpasswrodValid = false,
      confirmNewPasswordValid = false,
      oldPasswordValid = false;
  ForgotPasswordPresenter _presenter;
  ProfilePresenter profilePresenter;
  var _userProfie;
  bool password_status = false;

  String errorNewMessage;

  String errorConfirmMessage;

  bool _showOldPassword = false;

  bool _showConfirmPassword = false;
  bool _showNewPassword = false;

  @override
  void initState() {
    _presenter = new ForgotPasswordPresenter(this);
    profilePresenter = new ProfilePresenter(this);
    SsoStorage.getToken().then((token) {
      var accessToken = "rJsYBUKND6619dNiRf3mC40jKjKVNoMMTcrKuaJI";
      if (token != null) {
        accessToken = jsonDecode(token)["access_token"];
      }

      profilePresenter.getProfileDetails();
    }); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          password_status ? 'Change Password' : 'Set Password'.toLowerCase(),
          style: FSTextStyle.appbartext,          
        ),
        leading: FsBackButton(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        password_status
                            ? ListTile(
                                subtitle: TextField(
                                  obscureText: !_showOldPassword,
                                  controller: oldpasswrodController,
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                  ),
                                  minLines: 1,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        color: FsColor.basicprimary,
                                        icon: Icon(_showOldPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _showOldPassword =
                                            !_showOldPassword;
                                          });
                                        }),
                                    labelText: 'Old Password',
                                    errorText: oldPasswordValid
                                        ? 'password can\'t be empty'
                                        : null,
                                  ),
                                ),
                              )
                            : Container(),
                        ListTile(
                          subtitle: TextField(
                            obscureText: !_showNewPassword,
                            controller: newpasswrodController,
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  color: FsColor.basicprimary,
                                  icon: Icon(_showNewPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _showNewPassword = !_showNewPassword;
                                    });
                                  }),
                              labelText: 'New Password',
                              errorText:
                              newpasswrodValid ? errorNewMessage : null,
                            ),
                          ),
                        ),
                        ListTile(
                          subtitle: TextField(
                            obscureText: !_showConfirmPassword,
                            controller: confirmNewPasswordController,
                            onChanged: (text) {
                              String newPassword =
                              newpasswrodController.text.trim();
                              if (newPassword != text) {
                                setState(() {
                                  confirmNewPasswordValid = true;
                                  errorConfirmMessage =
                                  "Confirm password does not match";
                                });
                              } else {
                                setState(() {
                                  confirmNewPasswordValid = false;
                                });
                              }
                              //print("First text field: $text");
                            },
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  color: FsColor.basicprimary,
                                  icon: Icon(_showConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _showConfirmPassword =
                                      !_showConfirmPassword;
                                    });
                                  }),
                              labelText: 'Confirm Password',
                              errorText: confirmNewPasswordValid
                                  ? errorConfirmMessage
                                  : null,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        child: Text('Save And Proceed',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: const Color(0xFF404040),
                        textColor: FsColor.white,
                        onPressed: () {
                          changePasswrodApi(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePasswrodApi(BuildContext context) {
    if (isValid()) {
      print('changePasswrodApi');
      String newPassword = newpasswrodController.text.trim();
      String oldPassword = oldpasswrodController.text.trim();
      //String confirmPassword = confirmNewPasswordController.text.trim();

      SsoStorage.getToken().then((token) {
        var accessToken = "rJsYBUKND6619dNiRf3mC40jKjKVNoMMTcrKuaJI";
        if (token != null) {
          accessToken = jsonDecode(token)["access_token"];
        }
        _presenter.changePassword(newPassword, accessToken, oldPassword);
      });
    }
  }

  bool isValid() {
    bool isValid = true;
    String newPassword = newpasswrodController.text.trim();
    String confirmPassword = confirmNewPasswordController.text.trim();
    String oldPassword = oldpasswrodController.text.trim();
    if (newPassword.isEmpty || !(newPassword.length > 7)) {
      setState(() {
        newpasswrodValid = true;
        errorNewMessage = "The password must be atleast 8 character";
        return false;
      });

      //Toasly.error(context, "The password must be atleast 8 character", gravity: Gravity.CENTER);
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
      // Toasly.error(context, "The password must be atleast 8 character", gravity: Gravity.CENTER);
    } else {
      setState(() {
        confirmNewPasswordValid = false;
      });
    }
    if (password_status) {
      if (oldPassword.isEmpty) {
        isValid = false;
        setState(() {
          oldPasswordValid = true;
        });
        // Toasly.error(context, "Please enter old new password!", gravity: Gravity.CENTER);
      } else {
        setState(() {
          oldPasswordValid = false;
        });
      }
    }

    if (isValid) {
      if (newPassword != confirmPassword) {
        isValid = false;
        //Toasly.error(context, "Confirm password does not match", gravity: Gravity.CENTER);
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
  void onErrorUserAccount(var error) {
    /* Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );*/
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error),
        gravity: Gravity.CENTER);
  }

  @override
  void onFailureUserAccount(var failure) {
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure),
        gravity: Gravity.CENTER);
  }

  @override
  onUserAccountFound(accounts) {
    Toasly.success(
        context, "Password Changed Successfully!", gravity: Gravity.CENTER);
    // TODO: implement onUserAccountFound
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileView()),
    );
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void onSuccess(String success) {
    var profileJson = json.decode(success);
    _userProfie = profileJson["data"];
    SsoStorage.setUserProfile(_userProfie);
    setState(() {
      if (_userProfie['password_status'] == 1) {
        password_status = true;
      }
    });
    // TODO: implement onSuccess
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
  }

  @override
  void onError(String error) {

  }

  @override
  void onFailure(String error) {

  }
}
