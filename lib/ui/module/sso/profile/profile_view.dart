import 'dart:convert';

import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/help_support.dart';
import 'package:sso_futurescape/ui/module/orders/old_order.dart';
import 'package:sso_futurescape/ui/module/sso/about_us/about_us.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/sso/profile/change_password.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_edit.dart';
import 'package:sso_futurescape/ui/module/sso/signup/interest.dart';
import 'package:sso_futurescape/ui/module/sso/signup/otp.dart';
import 'package:sso_futurescape/ui/module/sso/signup/username.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/ui/widgets/percent_indicator.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/fsshare.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'manage_address.dart';

class ProfileView extends StatefulWidget {
  Function notifyFunction;

  ProfileView({this.notifyFunction}) {}

  @override
  State<StatefulWidget> createState() {
    return new _ProfileViewState(notifyFunction: notifyFunction);
    //_ProfilePageState _profilePageState = new _ProfilePageState();
  }

  static Future<void> logOutAction(BuildContext context) async {
    var profile = await SsoStorage.getUserName();
    SsoStorage.setLogin("false");
    Navigator.of(context, rootNavigator: true).pop('dialog');
    String userName = null;
    if (profile != null) {
      userName = profile;
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => UsernamePage(userName)),
        (Route<dynamic> route) => false);
    /*Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginPage();
        },
      ),
    );*/
  }
}

class _ProfileViewState extends State<ProfileView>
    implements ProfileResponseView {
  _ProfileViewState({this.notifyFunction}) {}
  ProfilePresenter presenter;
  int counter = 0;
  bool isPublic = false;
  bool isLoading = true;
  bool isEmailVerify = true;
  bool isEmail = false;
  bool isEdit = false;
  var profileData = null;
  var profileProgressData = null;

  bool isAvatar = false;
  bool isAddressVerify = false;
  static final String path = "lib/ui/module/sso/profile/profile_view.dart";
  bool isWeddingAnniversary = false;

  bool isHighestEducation = false;
  bool isPanId = false;
  bool isAadharId = false;
  bool isBloodGroup = false;
  String profileImageURL = null;
  String avatar_size = "avatar_medium";
  REQUEST_TYPE request_type;
  List manageaddress = [
    {
      "name": "Addresses",
    }
  ];
  List interest = [
    {
      "name": "Update your interests",
    }
  ];

  List logout = [
    {
      "name": "Logout",
    }
  ];
  List share = [
    {
      "name": "Refer a business",
    }
  ];

  List terms_conditions = [
    {
      "name": "Terms & Conditions",
    }
  ];

  List rateUs = [
    {
      "name": "Rate Us",
    }
  ];

  List about = [
    {
      "name": "About CubeOneApp",
    }
  ];
  List help_center = [
    {
      "name": "Help Center",
    }
  ];

  List changepassword = [
    {
      "name": "<Change/Set> Password",
    }
  ];

  void shareMsg(BuildContext context) {
    String s = "oneapp lists the local shops/businesses for the customers to find them easily and in one place.\n" +
        "Listed businesses have reported of an increased sales via on-call and online ordering from the oneapp users.\n" +
        "In view of the pandemic, oneapp is offering FREE LISTING for all the businesses.\n" +
        "Don't miss the opportunity. Get your business listed today!\n https://cubeone.page.link/share ";
    FsShare().myShare(context, s);
  }

  @override
  void initState() {
    presenter = new ProfilePresenter(this);
    print(profileData);
    presenter.getProfileProgress();
    getUserProfile();

    /*SsoStorage.getUserProfile().then((profile) {
      print("*******************");
      print(profile);
      if (profile != null) {
        try {
          print(profile);
          print("*******************");
          setState(() {
            isLoading = false;
            isEdit = true;
            profileData = profile;
            initializeVariables();
          });
        } catch (e) {
          print(e);
        }
      } else {
        print("getUserProfileCalled");
        getUserProfile();
      }
    }).catchError((e) {
      print(e);
    });*/
    /*if (profileData != null) {
      getUserProfile();
    }*/
    //initializeVariables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color1 = Color(0xff404040);
    final Color color2 = Color(0xff999999);
    final _media = MediaQuery.of(context).size;
    // final String image = avatars[0];
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Profile".toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
      ),
      body: isLoading
          ? PageLoader()
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0)),
                        gradient: LinearGradient(
                            colors: [color1, color2],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  height: 180,
                                  width: 180,
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(90.0),
                                    child: Image(
                                      image: getProfileWidget(),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          child: Column(children: <Widget>[
                            Text(
                              profileData != null ? getFullname() : "",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Gilroy-bold',
                              ),
                            ),
                          ]),
                        ),
                        /* Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              color: Colors.grey,
                              icon: Icon(FlutterIcon.google),
                              onPressed: () {},
                            ),
                            IconButton(
                              color: Colors.grey,
                              icon: Icon(FlutterIcon.facebook_official),
                              onPressed: () {},
                            ),
                            IconButton(
                              color: Colors.grey,
                              icon: Icon(FlutterIcon.twitter),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 0.0),*/

                  isPublic
                      ? Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 16.0),
                          margin: const EdgeInsets.only(
                              top: 20,
                              left: 20.0,
                              right: 20.0,
                              bottom: 20.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                              ),
                              borderRadius:
                              BorderRadius.circular(30.0)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.email),
                                onPressed: () {},
                              ),
                              Spacer(),
                              IconButton(
                                color: Colors.white,
                                icon: Icon(FlutterIcon.phone_1),
                                onPressed: () {},
                              ),
                              Spacer(),
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.message),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                  !isPublic
                      ? Container(
                    padding:
                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    // height: screenAwareSize(45, context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 6,
                          spreadRadius: 10,
                        )
                      ],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Profile Strength",
                          style: TextStyle(
                            fontSize: FSTextStyle.h5size,
                            fontFamily: 'Gilroy-Semibold',
                          ),
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width -
                              50,
                          lineHeight: 20.0,
                          percent: profileProgressData != null
                              ? profileProgressData / 100
                              : 0,
                          backgroundColor: Colors.grey.shade300,
                          progressColor: Color(0xFF1b52ff),
                          animation: true,
                          animateFromLastPercent: true,
                          alignment: MainAxisAlignment.spaceEvenly,
                          animationDuration: 1000,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          center: Text(
                            "$profileProgressData% profile completed",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        /*ListTile(
                                title: Text(
                                  "Orders",
                                  style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    fontFamily: 'Gilroy-Semibold',
                                  ),
                                ),
                              ),*/
                        ListTile(
                          onTap: () {
                            openOrderPage();
                          },
                          title: Text(
                            "My Orders",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(FlutterIcon.list_alt),
                        ),
                        ListTile(
                          onTap: () {
                            MainDashboardState.cart_icon.a.clickOnCount(
                                context, BusinessAppMode.APP_THEME);
                          },
                          title: Text(
                            "My Cart",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Contact",
                            style: TextStyle(
                              fontSize: FSTextStyle.h5size,
                              fontFamily: 'Gilroy-Semibold',
                            ),
                          ),
                        ),
                        !isPublic
                            ? ListTile(
                          title: Text(
                            "Mobile",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(profileData != null
                              ? profileData["mobile"] == null
                              ? ""
                              : profileData["mobile"]
                              : ""),
                          leading: Icon(Icons.phone),
                        )
                            : Container(),
                        isEmail
                            ? ListTile(
                          title: Text(
                            "Email",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData["email"] == null
                                ? ""
                                : profileData["email"]
                                : "",
                            softWrap: true,
                          ),
                          leading: Icon(Icons.email),
                          trailing: Container(
                            child: isEmailVerify
                                ? FlatButton.icon(
                              icon: Icon(
                                  FlutterIcon.ok_circled,
                                  color: FsColor.green,
                                  size: 12),
                              label: Text('Verified',
                                  style: TextStyle(
                                    color: FsColor.green,
                                    fontSize: 12,
                                    fontFamily:
                                    'Gilroy-Regular',
                                  )),
                              onPressed: () {},
                            )
                                : FlatButton.icon(
                              icon: Icon(
                                  FlutterIcon.attention,
                                  color: FsColor.red,
                                  size: 12),
                              label: Text(
                                'Verify',
                                style: TextStyle(
                                  color: FsColor.red,
                                  fontSize: 12,
                                  fontFamily:
                                  'Gilroy-Regular',
                                ),
                              ),
                              onPressed: () {
                                verifyEmail();
                              },
                            ),
                          ),
                        )
                            : Container(),
                        (isAadharId || isPanId)
                            ? ListTile(
                          title: Text(
                            "Identity",
                            style: TextStyle(
                              fontSize: FSTextStyle.h5size,
                              fontFamily: 'Gilroy-Semibold',
                            ),
                          ),
                        )
                            : Container(),
                        isPanId
                            ? ListTile(
                          title: Text(
                            "PAN/TAX ID",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData["pan"] != null
                                ? profileData["pan"]
                                : ""
                                : "",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(Icons.web),
                        )
                            : Container(),
                        isAadharId
                            ? ListTile(
                          title: Text(
                            "Aadhaar/SSN",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData["aadhaar"] != null
                                ? profileData["aadhaar"]
                                : ""
                                : "",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(Icons.web),
                        )
                            : Container(),
                        ListTile(
                          title: Text(
                            "Personal Details",
                            style: TextStyle(
                              fontSize: FSTextStyle.h5size,
                              fontFamily: 'Gilroy-Semibold',
                            ),
                          ),
                        ),
                        !isPublic
                            ? ListTile(
                          title: Text(
                            "Date of birth",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData["dob"] != null
                                ? getDisplayDateFormat(
                                profileData["dob"])
                                : ""
                                : "",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(Icons.calendar_view_day),
                        )
                            : Container(),
                        ListTile(
                          title: Text(
                            "Gender",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData["gender"] != null
                                ? profileData["gender"]
                                : ""
                                : "",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(Icons.person),
                        ),
                        isBloodGroup
                            ? ListTile(
                          title: Text(
                            "Blood Group",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData["blood_group"] != null
                                ? profileData["blood_group"]
                                : ""
                                : "",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(FlutterIcon.eyedropper),
                        )
                            : Container(),
                        isWeddingAnniversary
                            ? ListTile(
                          title: Text(
                            "Wedding Anniversary",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData[
                            "wedding_anniversary"] !=
                                null
                                ? getDisplayDateFormat(
                                profileData[
                                "wedding_anniversary"])
                                : ""
                                : "",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(Icons.calendar_view_day),
                        )
                            : Container(),
                        isHighestEducation
                            ? ListTile(
                          title: Text(
                            "Highest Education",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          subtitle: Text(
                            profileData != null
                                ? profileData[
                            "highest_education"] !=
                                null
                                ? profileData[
                            "highest_education"]
                                : ""
                                : "",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                          ),
                          leading: Icon(FlutterIcon.graduation_cap),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                  /* Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(title: Text("Addresses",
                          style: TextStyle(fontFamily: 'Gilroy-Semibold',),),),
                        ListTile(
                          title: Text("Manage Addresses",
                            style: TextStyle(fontFamily: 'Gilroy-Regular',),),
                          leading: Icon(Icons.home),
                          trailing: Container(
                            child: FlatButton.icon(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey, size: 15),
                              label: Text(""
                              ),
                              onPressed: () =>
                              {
                              Navigator.push(
                                context, new MaterialPageRoute(
                                  builder: (context) =>
                                      SavedAddress(profileData)
                              ),
                              ),
                              },
                            ),
                          ),
                        ),
                      ],),)*/
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: manageaddress == null
                          ? 0
                          : manageaddress.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = manageaddress[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        '${place["name"]}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              openManageAddress();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  isPublic
                      ? SizedBox(
                    height: 10,
                  )
                      : Container(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: changepassword == null
                          ? 0
                          : changepassword.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = changepassword[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FlutterIcon.key,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text: profileData[
                                                        'password_status'] ==
                                                            1
                                                            ? 'Change Password'
                                                            : 'Set Password',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ChangePasswordPage();
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  /* Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ListView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: terms_conditions == null
                                ? 0
                                : terms_conditions.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map place = terms_conditions[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FlutterIcon.logout,
                                          color: const Color(0xFF8c8c8c),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            child: ListView(
                                              primary: false,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: RichText(
                                                      text: TextSpan(
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .body1,
                                                          children: [
                                                        TextSpan(
                                                          text:
                                                              '${place["name"]}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy-regular',
                                                            fontSize:
                                                                FSTextStyle
                                                                    .h5size,
                                                            color:
                                                                FsColor.basicprimary,
                                                          ),
                                                        ),
                                                      ])),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                            width: 25.0,
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Icon(Icons.arrow_forward_ios,
                                                    color: Colors.grey,
                                                    size: 15),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    termsConditionWebview();
                                  },
                                ),
                              );
                            },
                          ),
                        ),*/
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: interest == null ? 0 : interest.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = interest[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.list,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        '${place["name"]}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              updateInterest();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  /*Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rateUs == null ? 0 : rateUs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = rateUs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FlutterIcon.star_empty_1,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        '${place["name"]}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              print(
                                  "Rate Up click 111111111111111111111111111");
                              AppReview.isRequestReviewAvailable
                                  .then((value) => print(value));
                              AppReview.requestReview.then((onValue) {
                                setState(() {
                                  print("requestReview-----------" +
                                      onValue);
                                  //output = onValue;
                                });
                                print("requestReview-------------2" +
                                    onValue);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),*/
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: about == null ? 0 : about.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = about[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.info_outline,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        '${place["name"]}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AboutUsScreenPage()),
                              );
                              //aboutWebview();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: share == null ? 0 : share.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = share[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FlutterIcon.share,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        '${place["name"]}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              shareMsg(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                      help_center == null ? 0 : help_center.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = help_center[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.question_answer,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        '${place["name"]}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HelpSupport()),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: logout == null ? 0 : logout.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map place = logout[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FlutterIcon.logout,
                                    color: const Color(0xFF8c8c8c),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        '${place["name"]}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Gilroy-regular',
                                                          fontSize:
                                                          FSTextStyle
                                                              .h4size,
                                                          color: FsColor
                                                              .basicprimary,
                                                        ),
                                                      ),
                                                    ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      width: 25.0,
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                              size: 15),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              showLogoutAlertDialog(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  /* ],
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isEdit
          ? FloatingActionButton(
        onPressed: () =>
        {
          openProfileEdit(),
          // pressedCall()
        },
        child: Icon(FlutterIcon.pencil_1),
        backgroundColor: const Color(0xFF404040),
      )
          : Container(),
    );

    /* // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            pressedCall();
          },
          child: Text('View Profile'),
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
        ),
      ),
    );
    ;*/
  }

  ImageProvider getProfileWidget() {
    try {
      return isAvatar
          ? profileImageURL != null
          ? NetworkImage(
        profileImageURL,
      )
          : new ExactAssetImage("images/default.png",
          scale: 1.0, bundle: null)
          : new ExactAssetImage("images/default.png", scale: 1.0, bundle: null);
    } catch (e) {
      print(e);
    }
  }

  /*ImageProvider buildNetworkImage() {
    try {
      if (profileUrl == null) {
        return new ExactAssetImage("images/default.png",
            scale: 1.0, bundle: null);
      }
      return new NetworkImage(profileUrl);
    } catch (e) {
      print("rrrrrrarararar");
      return new ExactAssetImage("images/default.png",
          scale: 1.0, bundle: null);
    }
  }*/

  void showLogoutAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Logout",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text("Are you sure you want to logout?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "NO",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              ),
              FlatButton(
                onPressed: () {
                  ProfileView.logOutAction(context);
                },
                child: Text(
                  "YES",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              )
            ],
          );
        });
  }

  getFullAddress() {
    return "";
    profileData["address_line_1"] +
        " " +
        profileData["address_line_2"] +
        " \n" +
        profileData["city"] +
        " " +
        profileData["zip_code"] +
        " \n" +
        profileData["state"] +
        " " +
        profileData["country"];
  }

  String getFullname() {
    String fname =
    profileData["first_name"] == null ? "" : profileData["first_name"];
    String lastName =
    profileData["last_name"] == null ? "" : profileData["last_name"];
    //   return fname == "" ? lastName : fname + " " + lastName;
    return fname + " " + lastName;
  }

  @override
  void hideProgress() {
    // Toasly.success(context, "hideProgress");
  }

  @override
  void onSuccess(String success) {
    /* Toasly.success(context, "success",
        duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);*/

    if (request_type == REQUEST_TYPE.GET_PROFILE) {
      //profileData = null;
      //setState(() {});
      var profileJson = json.decode(success);
      SsoStorage.setUserProfile(profileJson["data"]);
      profileData = profileJson["data"];
      print("Response Profile DATA" + profileData.toString());
      setState(() {
        initializeVariables();
        print(profileData);
        isLoading = false;
        isEdit = true;
      });
    } else if (request_type == REQUEST_TYPE.VERIFY_MOBILE) {
      Map<String, String> userData = new Map();
      userData["first_name"] = profileData["first_name"].toString();
      userData["last_name"] = profileData["last_name"].toString();
      userData["username"] = profileData["username"].toString();
      userData["mobile"] = profileData["mobile"].toString();
      userData["displayName"] = profileData["mobile"].toString();
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => OtpPage(userData, otpFor: "mobile")),
      );
//todo redirect otp page
    } else if (request_type == REQUEST_TYPE.VERIFY_EMAIL) {
      Map<String, String> userData = new Map();
      userData["first_name"] = profileData["first_name"].toString();
      userData["last_name"] = profileData["last_name"].toString();
      userData["username"] = profileData["username"].toString();
      userData["email"] = profileData["email"].toString();
      userData["displayName"] = profileData["email"].toString();
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => OtpPage(userData, otpFor: "email")),
      );
//todo redirect email verify page
    } else if (request_type == REQUEST_TYPE.VERIFY_ADDRESS) {}
  }

  @override
  void onFailure(String failure) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((failure))));
  }

  @override
  void onError(String error) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((error))));
  }

  @override
  void showProgress() {
    //Toasly.success(context, "showProgress");
  }

  void initializeVariables() {
    if (profileData != null) {
      if (profileData["pan"] == null) {
        isPanId = false;
      } else {
        isPanId = true;
      }
      if (profileData["aadhaar"] == null) {
        isAadharId = false;
      } else {
        isAadharId = true;
      }
      if (profileData["wedding_anniversary"] == null) {
        isWeddingAnniversary = false;
      } else {
        isWeddingAnniversary = true;
      }
      if (profileData["blood_group"] == null) {
        isBloodGroup = false;
      } else {
        isBloodGroup = true;
      }
      if (profileData["highest_education"] == null) {
        isHighestEducation = false;
      } else {
        isHighestEducation = true;
      }
      if (profileData[avatar_size] == null) {
        isAvatar = false;
      } else {
        print(
            "IMAGE_LINK : " + profileData[avatar_size] + "?dummy=${counter++}");
        profileImageURL = profileData[avatar_size] + "?dummy=${counter++}";
        isAvatar = true;
      }
      if (profileData["email_verified"] == 0) {
        //todo email verification not allowed from Profile view so hiding it.
        isEmailVerify = false;
      } else {
        isEmailVerify = true;
      }
      if (profileData["email"] == null) {
        isEmail = false;
      } else {
        isEmail = true;
      }
      if (profileData["address_verified"] == 0) {
        isAddressVerify = false;
      } else {
        isAddressVerify = true;
      }
    }
  }

  Future<void> verifyEmail() async {
    if (profileData["email"] != null) {
      Map<String, String> userData = new Map();
      userData["user_id"] = profileData["user_id"].toString();
      userData["first_name"] = profileData["first_name"].toString();
      userData["last_name"] = profileData["last_name"].toString();
      userData["username"] = profileData["username"].toString();
      userData["email"] = profileData["email"].toString();
      userData["display"] = profileData["email"].toString();
      var result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => OtpPage(userData, otpFor: "email")),
      );
      /* if (result) {*/
      print(result);
      if (result != null &&
          result["otpFor"] == "email" &&
          result["result"] == "success") {
        print("ffffff");
        isEmailVerify = true;
        profileData["email_verified"] = 1;
        setState(() {});
      }
      /*  }*/

      /*request_type = REQUEST_TYPE.VERIFY_EMAIL;
      presenter.verifyEmail(profileData["email"]);*/
    }
  }

  void verifyAddress() {
    request_type = REQUEST_TYPE.VERIFY_ADDRESS;
  }

  void verifyMobile() {
    request_type = REQUEST_TYPE.VERIFY_MOBILE;
    presenter.verifyMobile("");
  }

  void getUserProfile() {
    print("getUserProfile Count");
    request_type = REQUEST_TYPE.GET_PROFILE;
    presenter.getProfileDetails();
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
    var profileJson = json.decode(success);
    print("profileView " + profileJson["data"]['profile'].toString());

    /*int abcd = profileJson["data"]['profile'];
    print("abcd " + abcd.toString());*/
    setState(() {
      profileProgressData = profileJson["data"]['profile'];
    });
  }

  openProfileEdit() async {
    var _selection;
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return new ProfileEdit(profileData);
      },
    ));

    if (results != null && results.containsKey('selection')) {
      print("inside Selection");
      getUserProfile();
      /*setState(() {
        _selection = results[avatar_size];
        print(_selection.toString());
      });*/
    } else {
      print("outside Selection");
      getUserProfile();
    }

    /*Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => ProfileEdit(profileData)),
    );*/
  }

  String getDisplayDateFormat(String date) {
    String displayDAte =
    AppUtils.changeDateFormat(date, "yyyy-MM-dd", "dd-MM-yyyy");
//    print("display dob ---- "+displayDAte);
    if (displayDAte == null) {
      displayDAte = "";
    }
    return displayDAte;
  }

  void openManageAddress() async {
    Map result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ManageAddress(profileData);
        },
      ),
    );
    getUserProfile();
  }

  Function notifyFunction;

  void updateInterest() async {
    Map result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return InterestPage(
            notifyFunction: notifyFunction,
          );
        },
      ),
    );
  }

  void openOrderPage() {
    FsNavigator.push(context, OlderOrder(null, BusinessAppMode.APP_THEME));
  }
/*
  void termsConditionWebview() {
    try {
      if ((Platform.isAndroid != null && Platform.isAndroid) ||
          (Platform.isIOS != null && Platform.isIOS)) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              print(Platform.isAndroid);
              return OnlineOrderWebView('profile', "Terms & Conditions",
                  "https://www.cubeoneapp.com/term&conditions.php");
            },
          ),
        );
      } else {
        print("1");
        // html.window.open(url2, "Resto");
      }
    } catch (e) {
      print("2");
    }
  }

  void aboutWebview() {}*/

}

enum REQUEST_TYPE { GET_PROFILE, VERIFY_MOBILE, VERIFY_EMAIL, VERIFY_ADDRESS }
