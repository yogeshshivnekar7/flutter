import 'dart:collection';
import 'dart:ui';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/sso/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/sso/login/login_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/sso/signup/mobile.dart';
import 'package:sso_futurescape/ui/module/sso/signup/otp.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import '../../../widgets/mobile_number_widget.dart';
import 'password.dart';

class UsernamePage extends StatefulWidget {
  String username;

  UsernamePage(this.username);

  @override
  _UsernamePageState createState() => new _UsernamePageState(username);
}

class _UsernamePageState extends State<UsernamePage>
    implements LoginView, TextListener {
  LoginPresentor _loginPresentor; //=new LoginPresentor(this);
  ContactNumberController userNameController;
  String username;
  bool userNameFound = false;
  bool passwordFound = false;
  bool isMobileNumber = false;
  bool isLoadind = false;
  Map<String, String> userData = null;

  _UsernamePageState(this.username) {
    userNameController = new ContactNumberController(textListener: this);
  }

  @override
  void initState() {
    super.initState();
    getOtpStorage().then((a) {
      SsoStorage.clearAll();
      setOtpStorage();
    });


//    userNameController.addListener(_usernameChange);
    if (username == null) {
      userNameController.text = username;
    }
    _loginPresentor = new LoginPresentor(this);
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // leading: Icon(Icons.arrow_back, color: FsColor.darkgrey, size: 18.0),
      ),
      // backgroundColor: FsColor.primary.withOpacity(0.1),
      body: Container(
        // decoration: BoxDecoration(
        //     image: new DecorationImage(
        //     colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
        //     image: new ExactAssetImage('images/bg.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
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
                                  'enter your\nusername/mobile',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-bold',
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
                            /*decoration: InputDecoration(
                                  // labelText: 'Username',
                                  hintText: "e.g. 9999999999",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      color: FsColor.darkgrey),
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: FsColor.primary))),*/
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                          child: Text(
                            "don't have a username yet? create with your\nmobile number",
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.black),
                          ),
                        ),
                      ],
                    )),
                userNameController
                    .getUserName()
                    .length > 2
                    ? Container(

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      !userNameFound && !isLoadind
                          ? Container(
                        margin: EdgeInsets.only(
                            bottom: 20.0),
                        child: GestureDetector(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(
                                30.0, 10.0, 30.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(4.0),
                            ),
                            child: Text('Continue',
                                style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                )),
                            onPressed: () {
                              _validateUserName();
                            },
                            color: FsColor.basicprimary,
                            textColor: FsColor.white,
                          ),
                        ),
                      )
                          : isLoadind
                          ? CircularProgressIndicator()
                          : Container(),
                      // userData['password_status']==1
                      passwordFound
                          ? Container(
                        margin: EdgeInsets.only(
                            bottom: 20.0, right: 5.0),
                        child: GestureDetector(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(
                                30.0, 10.0, 30.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(4.0),
                            ),
                            child: Text('Use Password',
                                style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                )),
                            onPressed: () {
                              _validateUserName();
                            },
                            color: FsColor.basicprimary,
                            textColor: FsColor.white,
                          ),
                        ),
                      )
                          : Container(),
                      userNameFound && isMobileNumber
                          ? Container(
                        margin: EdgeInsets.only(
                            bottom: 20.0, left: 5.0),
                        child: GestureDetector(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(
                                30.0, 10.0, 30.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(4.0),
                            ),
                            child: Text('Use OTP',
                                style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                )),
                            onPressed: () {
                              _validateUserNameOtp();
                            },
                            color: FsColor.basicprimary,
                            textColor: FsColor.white,
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Your username/mobile ',
              style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  fontSize: FSTextStyle.h5size,
                  color: FsColor.darkgrey),
              children: <TextSpan>[
                new TextSpan(
                    text: userNameController.getUserName(),
                    style: TextStyle(
                        fontFamily: 'Gilroy-Bold',
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.darkgrey)),
                new TextSpan(
                    text: ' not found on cubeone',
                    style: TextStyle(
                        fontFamily: 'Gilroy-Regular',
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.darkgrey)),
              ],
            ),
          ),
          // title: new Text(
          //   "Your username 'rahuln' not found on OneApp",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //       fontFamily: 'Gilroy-Regular',
          //       fontSize: FSTextStyle.h5size,
          //       color: FsColor.darkgrey),
          // ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Text(
              "please recheck your username/mobile or \ncreate new account",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  fontSize: FSTextStyle.h5size,
                  color: FsColor.darkgrey),
            ),
          ),
          actions: <Widget>[
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(
                    child: new Text('Change Username',
                        style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.darkgrey,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },

                  ),
                  SizedBox(width: 10.0),
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    child: Text("Create Account",
                        style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MobilePage(comingFrom: MobilePage.NEW_USER,
                                  data: userNameController.text,
                                )),
                      );
                    },
                    color: FsColor.basicprimary,
                    textColor: FsColor.white,
                  ),
                ]),
          ],
        );
      },
    );
  }

  void _validateUserName() {
    print("RRRRRR");
    if (mobileUser == AppConstant.INVALID_MOBILEUSER) {
      Toasly.error(context, "Please enter valid mobile number");
      return;
    }
    saveUserId(userData);
    if (userNameFound) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PasswordPage(
                  userNameController.getUserName(),
                  userData: userData,
                )),
      );
    } else {
      setState(() {
        isLoadind = true;
      });
      _loginPresentor.finalChecking(userNameController.getUserName(),
              (username) {
            setState(() {
              isLoadind = false;
            });
            userFound(username);
          }, (username) {
            setState(() {
              isLoadind = false;
            });
            _showDialog();
          }, (username) {
            setState(() {
              isLoadind = false;
            });
            Toasly.error(context, "Please check the internet connection");
          });
    }
  }

  void _validateUserNameOtp() {
    saveUserId(userData);
    if (userNameFound) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OtpPage(userData, otpFor: "login",
                    username: userNameController.getUserName())),
      );
    } else {
      print(userNameFound);
    }
  }

  /*void _validateUserNamePassword() {
    if (userNameController.text == "8149229032") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordPage(userNameController.text)),
      );
    }
  }*/

  void _usernameChange() {
    print("-------------------------adddddddddddddd------------------");

    _loginPresentor.userCheckUserName(userNameController.getUserName());
  }

  @override
  userCheckFailure(error) {
    print("Dipesh");
    print(error);
//    Toasly.error(context, error);
    setState(() {
      isLoadind = false;
    });

    FsNavigator.push(context, ErrorNoInternetPage());
  }

  @override
  userFound(data) {
    userData = HashMap();
    var profileData = data["data"];
    print("profileData ----- $profileData");
    userData["user_id"] = profileData["user_id"].toString();

    userData["username"] = profileData["username"].toString();
    print("passtatus -------------");
    print(profileData["password_status"]);

    userData["password_status"] = profileData["password_status"].toString();
    userData["display"] = userNameController.getUserName();

    if (userNameController.text.trim().isNotEmpty) {
      print(mounted);
      // if (!mounted) return;
      setState(() {
        hideKeyboard();
//        print("userData --- $userData");
//        print("password --- $userData['password_status']");
//        print(userData['password_status']);
        if (userData['password_status'] == '1') {
          passwordFound = true;
        }
        print(userNameController.text);
        String dail = "";
        if (userNameController.country == null) {
          dail = userNameController.country.dialingCode;
          print(dail);
        }
        if (int.tryParse(userNameController.text.trim()) != null) {
          userNameFound = true;
          isMobileNumber = true;
          print(userNameFound);
        } else {
          userNameFound = true;
          isMobileNumber = false;
          print(userNameFound);
        }
      });
    }
    isLoadind = false;
    setState(() {

    });
  }

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  userNotFound(username) {
    // if (!mounted) return;
    setState(() {
      isLoadind = false;
      userNameFound = false;
      passwordFound = false;
      isMobileNumber = false;
    });
  }

  @override
  loginError(error) {
    setState(() {
      isLoadind = false;
    });

    FsNavigator.push(context, ErrorNoInternetPage());
    return null;
  }

  @override
  loginFailed(falure) {
    return null;
  }

  @override
  loginSuccess(success) {
    return null;
  }

  @override
  clearList() {
    return null;
  }

  @override
  onErrorUserAccount(error) {
    print("------------------------asndisafni----------------");
    setState(() {
      isLoadind = false;
    });

    FsNavigator.push(context, ErrorNoInternetPage());
  }

  @override
  onFailureUserAccount(failed) {
    print("------------------------failed----------------");
    return null;
  }

  @override
  onUserAccountFound(accounts) {
    return null;
  }

  int mobileUser = AppConstant.NOT_MOBILEUSER;
  @override
  onTextChanged(text) {
    print("text change--------------$text");


    try {
      mobileUser = AppConstant.MOBILEUSER;
      int.parse(text);
      print("text-------------------------------$text");
      if (Environment().getCurrentConfig().geCurrentPlatForm() !=
          FsPlatforms.WEB) {
        PhoneNumberUtil.isValidPhoneNumber(
            phoneNumber: text, isoCode: userNameController.country.isoCode)
            .then((isValid) {
          print("valid number ----------------------- " + isValid.toString());
          if (isValid) {
            mobileUser = AppConstant.VALID_MOBILEUSER;
            isLoadind = true;
            hideKeyboard();
            _usernameChange();
//          setState(() {
//            isLoading = true;
//            lenght = text.length;
//          });
//          print("isloading------------------$isLoading");

          } else {
            mobileUser = AppConstant.INVALID_MOBILEUSER;
            setState(() {
              isLoadind = false;
              userNameFound = false;
              passwordFound = false;
              isMobileNumber = false;
            });
          }
//        print("isloading------------------$lenght");
        });
      } else {
        _usernameChange();
      }

    } catch (e) {
      print(e);
      print("-------------------catch----------");
      isLoadind = false;
      userNameFound = false;
      passwordFound = false;
      isMobileNumber = false;
      mobileUser = AppConstant.NOT_MOBILEUSER;
      _usernameChange();
    }
    setState(() {

    });
    //callExtra();
  }

  void saveUserId(Map<String, String> userData) {
    if (userData != null) {
      SsoStorage.saveUserId(userData["user_id"].toString());
    }
  }

  var dataFP;
  var dataUpdateUN;
  var dataLogin;
  var dataMobile;
  var dataEmail;

  Future<void> getOtpStorage() async {
    //forgot_password
//    UPDATE_USERNAME
//    login
//    mobile
//    email
    dataFP = await SsoStorage.getOtpCounter("forgot_password");
    dataUpdateUN = await SsoStorage.getOtpCounter("UPDATE_USERNAME");
    dataLogin = await SsoStorage.getOtpCounter("login");
    dataMobile = await SsoStorage.getOtpCounter("mobile");
    dataEmail = await SsoStorage.getOtpCounter("email");
  }

  void setOtpStorage() {
    print("data--------------- $dataFP");
    print("data--------------- $dataUpdateUN");
    print("data--------------- $dataLogin");
    print("data--------------- $dataMobile");
    print("data--------------- $dataEmail");
    SsoStorage.setOtpCounter("forgot_password", dataFP);
    SsoStorage.setOtpCounter("UPDATE_USERNAME", dataUpdateUN);
    SsoStorage.setOtpCounter("login", dataLogin);
    SsoStorage.setOtpCounter("mobile", dataMobile);
    SsoStorage.setOtpCounter("email", dataEmail);
  }

  @override
  onContactClicked() {
    // TODO: implement onContactClicked
    throw UnimplementedError();
  }

/* Future<void> callExtra() async {
    try{
      print("DDDDDDDDDDDDDDDDDDDDDDDDD");
      print("RAAAAA");
      String phoneNumber = "+" + userNameController.getUserName();
      PhoneNumber number =
      await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);
      String parsableNumber = number.parseNumber();
      print(number.dialCode);
      print(number.phoneNumber);
      print(number.phoneNumber);
      print(number);
      print("DDDDDDDDDDDDDDDDDDDDDDDDD");
    }catch(e){
      print(e);
    }
  }*/
}
