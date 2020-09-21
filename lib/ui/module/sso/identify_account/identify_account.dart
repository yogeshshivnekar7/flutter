import 'dart:collection';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/forgot_password/forgot_password_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/forgot_password/forgot_passwrod_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/sso/signup/otp.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class IdentifyAccountPage extends StatefulWidget {
  String userName;
  List userData;

  IdentifyAccountPage(this.userName, this.userData);

  @override
  _IdentifyAccountPageState createState() =>
      new _IdentifyAccountPageState(userName, this.userData);
}

class _IdentifyAccountPageState extends State<IdentifyAccountPage>
    implements ForgotPasswordView {
  ForgotPasswordPresenter _forgotPasswordPresenter;
  String username;
  List userData;

  _IdentifyAccountPageState(this.username, this.userData);

  @override
  void initState() {
    if (userData == null) {
      userData = new List();
    }
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
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
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
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: Text(
                    'Identify your Account'.toLowerCase(),
                    style: TextStyle(
                        fontFamily: 'Gilroy-Bold',
                        fontSize: FSTextStyle.h5size,
                        height: 1.5,
                        letterSpacing: 1.0,
                        color: FsColor.darkgrey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ListView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userData == null ? 0 : userData.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map user = userData[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                            side: BorderSide(
                                color: FsColor.lightgrey.withOpacity(0.2),
                                width: 1.0),
                          ),
                          elevation: 0.0,
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.only(
                                bottom: 10.0,
                                top: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      "${user["img"]}",
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ListView(
                                      primary: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: '${user["username"]}'
                                                      .toLowerCase(),
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy-SemiBold',
                                                    fontSize: FSTextStyle
                                                        .h6size,
                                                    color: FsColor.basicprimary,
                                                  ),
                                                ),
                                              ])),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          RaisedButton(
                                            padding: EdgeInsets.fromLTRB(
                                                5.0, 0.0, 5.0, 0.0),
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  4.0),
                                              side: BorderSide(
                                                  color: FsColor.lightgrey,
                                                  width: 1.0),
                                            ),
                                            child: Text(
                                              'This is me',
                                              style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-SemiBold',
                                              ),
                                            ),
                                            color: FsColor.basicprimary,
                                            textColor: FsColor.white,
                                            onPressed: () {
                                              showOtpScreen(user);
                                            },
                                          ),
                                        ],
                                      )),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        )

      // Container(
      //   child: Stack(
      //     children: <Widget>[
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.max,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           Container(
      //               padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: <Widget>[
      //                   Container(
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       mainAxisSize: MainAxisSize.max,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: <Widget>[
      //                         new Image.asset(
      //                           'images/dummy_logo.png',
      //                           fit: BoxFit.fitHeight,
      //                           height: 75.0,
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                   Container(
      //                     padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
      //                     child: Column(
      //                       children: <Widget>[
      //                         Container(
      //                           alignment: Alignment.topLeft,
      //                           padding:
      //                               EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      //                           child: Text(
      //                             'Identify your Account'.toLowerCase(),
      //                             style: TextStyle(
      //                                 fontFamily: 'Gilroy-Bold',
      //                                 fontSize: 18.0,
      //                                 height: 1.5,
      //                                 letterSpacing: 1.0,
      //                                 color: FsColor.darkgrey),
      //                           ),
      //                         ),
      //                         Container(
      //                           child: Card(
      //                               shape: RoundedRectangleBorder(
      //                                 borderRadius: const BorderRadius.all(
      //                                   Radius.circular(4.0),
      //                                 ),
      //                                 side: BorderSide(
      //                                     color: FsColor.lightgrey.withOpacity(0.2),
      //                                     width: 1.0),
      //                               ),
      //                               elevation: 0.0,
      //                               child: Container(
      //                                 padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      //                                 child: Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.spaceBetween,
      //                                   mainAxisSize: MainAxisSize.max,
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.center,
      //                                   children: <Widget>[
      //                                     ClipRRect(
      //                                       borderRadius:
      //                                           BorderRadius.circular(5),
      //                                       child: Image.asset(
      //                                         "images/default.png",
      //                                         height: 48,
      //                                         width: 48,
      //                                         fit: BoxFit.cover,
      //                                       ),
      //                                     ),
      //                                     SizedBox(width: 5),
      //                                     Expanded(
      //                                       child: ListView(
      //                                         primary: false,
      //                                         physics:
      //                                             NeverScrollableScrollPhysics(),
      //                                         shrinkWrap: true,
      //                                         children: <Widget>[
      //                                           Container(
      //                                             alignment:
      //                                                 Alignment.centerLeft,
      //                                             child: Text(
      //                                               'Full Name Comes Here',
      //                                               style: TextStyle(
      //                                                 fontFamily:
      //                                                     'Gilroy-SemiBold',
      //                                                 fontSize:
      //                                                     FSTextStyle.h6size,
      //                                                 color: FsColor.basicprimary,
      //                                               ),
      //                                             ),
      //                                           ),
      //                                           SizedBox(height: 5),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                     RaisedButton(
      //                                       padding: EdgeInsets.fromLTRB(
      //                                           30.0, 10.0, 30.0, 10.0),
      //                                       shape: new RoundedRectangleBorder(
      //                                         borderRadius:
      //                                             new BorderRadius.circular(
      //                                                 4.0),
      //                                         side: BorderSide(color: FsColor.lightgrey,width: 1.0),
      //                                       ),
      //                                       child: Text(
      //                                         'This is me',
      //                                         style: TextStyle(
      //                                           fontSize: FSTextStyle.h6size,
      //                                           fontFamily: 'Gilroy-SemiBold',
      //                                         ),
      //                                       ),
      //                                       color: FsColor.basicprimary,
      //                                       textColor: FsColor.white,
      //                                       onPressed: () {
      //                                         Navigator.push(
      //                                           context,
      //                                           MaterialPageRoute(
      //                                               builder: (context) =>
      //                                                   ChangePasswordPage()),
      //                                         );
      //                                       },
      //                                     ),
      //                                   ],
      //                                 ),
      //                               )),
      //                         ),
      //                         Container(
      //                           child: Card(
      //                               shape: RoundedRectangleBorder(
      //                                 borderRadius: const BorderRadius.all(
      //                                   Radius.circular(4.0),
      //                                 ),
      //                                 side: BorderSide(color: FsColor.lightgrey.withOpacity(0.2),width: 1.0),
      //                               ),
      //                               elevation: 0.0,
      //                               child: Container(
      //                                 padding: EdgeInsets.fromLTRB(
      //                                     10.0, 10.0, 10.0, 10.0),
      //                                 child: Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.spaceBetween,
      //                                   mainAxisSize: MainAxisSize.max,
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.center,
      //                                   children: <Widget>[
      //                                     ClipRRect(
      //                                       borderRadius:
      //                                           BorderRadius.circular(5),
      //                                       child: Image.asset(
      //                                         "images/default.png",
      //                                         height: 48,
      //                                         width: 48,
      //                                         fit: BoxFit.cover,
      //                                       ),
      //                                     ),
      //                                     SizedBox(width: 5),
      //                                     Expanded(
      //                                       child: ListView(
      //                                         primary: false,
      //                                         physics:
      //                                             NeverScrollableScrollPhysics(),
      //                                         shrinkWrap: true,
      //                                         children: <Widget>[
      //                                           Container(
      //                                             alignment:
      //                                                 Alignment.centerLeft,
      //                                             child: Text(
      //                                               'Full Name Comes Here',
      //                                               style: TextStyle(
      //                                                 fontFamily:
      //                                                     'Gilroy-SemiBold',
      //                                                 fontSize:
      //                                                     FSTextStyle.h6size,
      //                                                 color: FsColor.basicprimary,
      //                                               ),
      //                                             ),
      //                                           ),
      //                                           SizedBox(height: 5),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                     RaisedButton(
      //                                       padding: EdgeInsets.fromLTRB(
      //                                           30.0, 10.0, 30.0, 10.0),
      //                                       shape: new RoundedRectangleBorder(
      //                                         borderRadius:
      //                                             new BorderRadius.circular(
      //                                                 4.0),
      //                                                 side: BorderSide(color: FsColor.lightgrey,width: 1.0),
      //                                       ),
      //                                       child: Text(
      //                                         'This is me',
      //                                         style: TextStyle(
      //                                           fontSize: FSTextStyle.h6size,
      //                                           fontFamily: 'Gilroy-SemiBold',
      //                                         ),
      //                                       ),
      //                                       color: FsColor.basicprimary,
      //                                       textColor: FsColor.white,
      //                                       onPressed: () {
      //                                         Navigator.push(
      //                                           context,
      //                                           MaterialPageRoute(
      //                                               builder: (context) =>
      //                                                   ChangePasswordPage()),
      //                                         );
      //                                       },
      //                                     ),
      //                                   ],
      //                                 ),
      //                               )),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               )),
      //         ],
      //       ),
      //     ],
      //   ),
      // )

    );
  }

  @override
  onErrorUserAccount(error) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  onFailureUserAccount(failed) {
    print(failed);
    Toasly.error(context, AppUtils.errorDecoder(failed));
  }

  /*List accounts;*/

  @override
  onUserAccountFound(accounts1) {
    print("onUserAccountFoundonUserAccountFoundonUserAccountFound");
    print(accounts1);
    setState(() {
      print("setStatesetStatesetState");
      userData = accounts1["data"] /*["results"]*/;
      print("ddDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
      print(userData);
    });
    // TODO: implement onUserAccountFound
  }

  showOtpScreen(Map user) {
    Map<String, String> map = new HashMap<String, String>();
    map["username"] = user["username"].toString();
    map["user_id"] = user["user_id"].toString();
    map["display"] = user["mobile"].toString();
    map["email"] = user["email"];
    map["mobile"] = user["mobile"].toString();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              OtpPage(map, username: username, otpFor: "forgot_password")),
    );
  }
}
