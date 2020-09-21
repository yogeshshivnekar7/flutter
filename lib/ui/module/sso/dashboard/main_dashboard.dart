import 'dart:io';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/firebase/firebase_dynamiclink.dart';
import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:facebook_deeplinks/facebook_deeplinks.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_app_links/flutter_facebook_app_links.dart';
import 'package:package_info/package_info.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/member_invitation/member_invitation_presenter.dart';
import 'package:sso_futurescape/presentor/module/member_invitation/member_invitation_view.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_invitees.dart';
import 'package:sso_futurescape/ui/module/meeting/card/meeting_card.dart';
import 'package:sso_futurescape/ui/module/ipl/ipl_card.dart';
import 'package:sso_futurescape/ui/module/ipl/ipl_main.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meetvote_main.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/ui/module/orders/cart/cart_icon_action.dart';
import 'package:sso_futurescape/ui/module/orders/store_detail_helper.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/corona_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/grocery_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/pyna_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/recipe_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/restaurant_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/society_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/tiffin_card.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/vizlog_card.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/signup/dob_dialog.dart';
import 'package:sso_futurescape/ui/module/sso/signup/interest.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_databse_sso.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_notification.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

import 'my_business.dart';

class MainDashboard extends StatefulWidget {
  bool isDirectToNotification = true;

  MainDashboard({this.isDirectToNotification = true}) {}

  @override
  MainDashboardState createState() => new MainDashboardState();
}

class MainDashboardState extends State<MainDashboard>
    implements MemberInvitationView {
  String profileUrl;
  var profilePojo;
  DashbaordCard v;
  int counter = 0;
  bool isBusinessMode = false;
  static bool isWineShow = false;
  static CartIcon cart_icon;
  int notifications = 0;
  bool _flexibleUpdateAvailable = false;

  Future<void> handleLinkData(String type, Map map, String link) async {
    if (!mounted) return;
    /*if (type.toLowerCase() == 'store detail'.toLowerCase()) {
      if (!mounted) return;
      //onRedirected(url);
    }*/
    if (widget.isDirectToNotification) {
      if (map["card"] != null) {
        if (map["card"] == "society") {
          SocietyCard.staticGlobalKey.currentState.societyIntroduction();
        } else if (map["card"] == "ipl") {
          Map value = await SsoStorage.getUserProfile();
          List<UserProfile> list = [];
          //list.add(userprofile);
          list.add(UserProfile(
            email: value['email'],
            firstname: value['first_name'],
            lastname: value['last_name'],
            mobile: value['mobile'],
            userid: value['user_id'],
          ));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IplMain(
                userprofile: list,
              ),
            ),
          );
          /*SsoStorage.getUserProfile().then((userprofile) {

          });*/
          //SocietyCard.staticGlobalKey.currentState.societyIntroduction();
        } else if (map["card"] == "gate") {
          VizlogCard.staticGlobalKey.currentState.openDashboard();
        } else {
          StoreDetailHelper(context).handleDynamicLink(map, link);
        }
      } else {
        StoreDetailHelper(context).handleDynamicLink(map, link);
      }

      // StoreDetailHelper(context).handleDynamicLink(map);
    } else {
      widget.isDirectToNotification = true;
    }
  }

  static const platform_channel =
      const MethodChannel('app.channel.shared.data');

  Future<String> getSharedText() async {
    if (Environment().getCurrentConfig().geCurrentPlatForm() ==
        FsPlatforms.ANDROID) {
      print("sharedData");
      final sharedData = await platform_channel.invokeMethod("getSharedText");
      print("sharedData");
      print(sharedData);
      if (sharedData != null) onRedirected(sharedData);
    } else {
      print("Not implemented node features");
    }
  }

  //String _deeplinkUrl = 'Unknown';

  Future<void> initPlatformState() async {
    String deeplinkUrl;
    var facebookDeeplinks = FacebookDeeplinks();
    facebookDeeplinks.onDeeplinkReceived.listen(onRedirected);
    deeplinkUrl = await facebookDeeplinks.getInitialUrl();
    print('deeplinkUrl');
    print(deeplinkUrl);
    if (!mounted) return;
    onRedirected(deeplinkUrl);
  }

  void onRedirected(String uri) {
    print("uri12345");
    print(uri);
    //catchFBDeferredDeeplinks();
    /* setState(() {
      print(uri);
     String _deeplinkUrl = uri;
    });*/
    if (!mounted) return;

    if(uri != null && uri.trim().contains(Environment.config.meetingDomain)) {
      print("OPEN MEETING URI = $uri");
      String meetingIdStr = MeetVoteUtils.getMeetingIdFromUrl(uri);
      if (meetingIdStr != null && meetingIdStr.trim().isNotEmpty) {
        _openMeetingDetailsScreen(int.parse(meetingIdStr));
      }
      return;
    }

    Map map = Uri.parse(uri).queryParameters;
    /* if (map['c_id'] != null) {
      print(map);

    }*/
    handleLinkData(null, map, uri);
    // StoreDetailHelper(context).handleDynamicLink(map);
  }

  void _openMeetingDetailsScreen(int meetingId) {
    print("Meeting ID - $meetingId");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MeetVoteMain(meetingId)));
  }

  void catchFBDeferredDeeplinks() async {
    try {
      Map<String, String> data = await FlutterFacebookAppLinks.initFBLinks();
      print("catchFBDeferredDeeplinks");
      print(data);
      if (data != null &&
          data['deeplink'] != null &&
          data['deeplink'].isNotEmpty) {
        onRedirected(data['deeplink']);
        /*Map map = Uri.parse(data['deeplink']).queryParameters;
        if (map['c_id'] != null) {
          print(map);
          StoreDetailHelper(context).handleDynamicLink(map);
        }*/

        /// do stuffs with the deeplink
      }

      if (data != null &&
          data['promotionalCode'] != null &&
          data['promotionalCode'].isNotEmpty) {
        /// do stuffs with the promo code
      }
    } catch (e) {
      print('Error on FB APP LINKS');
    }
  }

  @override
  void initState() {
    _passNodeUrl();
    checkToshowPynaShow();

    super.initState();
    //catchFBDeferredDeeplinks();
    getNotificationCount();
    SsoStorage.getUserProfile().then((profile) {
      profilePojo = profile;
      try {
        UserUtils.getHRMSCompanies().then((hrmsCompanies) {
          print(hrmsCompanies);
          hrmsCompanies == null || hrmsCompanies.length <= 0
              ? isBusinessMode = false
              : isBusinessMode = true;
          setState(() {});
        });
      } catch (e) {
        print(e);
      }

      setState(() {
        profileUrl = profile["avatar_small"];
        profileUrl += "?dummy=${counter++}";
        print(profileUrl);
      }); // profile["avatar_small"];
    }).catchError((e) {
      print(e);
    });
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    MainDashboardState.cart_icon = CartIcon(BusinessAppMode.APP_THEME);
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FirebaseNotifications().firebaseCloudMessaging_Listeners(context,
            onRedirected: onRedirected);
        FirebaseDynamicLink.handleDynamikLinks(context, handleLinkData);
        initPlatformState();
        getSharedText();
      });
    }
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });*/
  }

  static const APP_STORE_URL =
      'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.cubeone.app';

  versionCheck(context) async {
    /*if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((info) {
        _updateInfo = info;
        print(_updateInfo);
        if (_updateInfo.updateAvailable) {
          showVersionDialog(context);
        }
        */ /*setState(() {

          print(_updateInfo);
        });*/ /*
      }).catchError((e) => null);
    } else {*/
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      double newVersion;
      if (Platform.isIOS) {
        newVersion = double.parse(remoteConfig
            .getString('cubeone_force_update_current_version_ios')
            .trim()
            .replaceAll(".", ""));
      } else {
        newVersion = double.parse(remoteConfig
            .getString('cubeone_force_update_current_version_android')
            .trim()
            .replaceAll(".", ""));
      }
      if (newVersion > currentVersion) {
        showVersionDialog(context);
      }
    } on FetchThrottledException catch (exception) {
      print(exception);
    } catch (exception) {
      print("exception");
      print(exception);
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    //  }
  }

  showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New update available";
        String message =
            "There is a newer version of this application available. \nclick on update to upgrade now.";
        String btnLabel = "Update";
        String btnLabelCancel = "Not Now";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () {
                      AppUtils.openAppStore();
                    },
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => AppUtils.openAppStore(),
                  )
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  MethodChannel platform = const MethodChannel('com.cubeone.app/MainActivity');

  Future<Null> _passNodeUrl() async {
    if (Environment().getCurrentConfig().geCurrentPlatForm() ==
        FsPlatforms.ANDROID) {
      await platform.invokeMethod('node_url', {
        "node_url_key": Environment().getCurrentConfig().nodeUrl.toString()
      });
    } else {
      print("Not implemented node features");
    }
  }

  SocietyCard societyCard;
  VizlogCard vizlogCard;

  @override
  Widget build(BuildContext context) {
    print("update Cart COunt -------------------buildbuildbuildbuild");
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: new Text(
          'dashboard',
          style: FSTextStyle.appbartext,
        ),
        automaticallyImplyLeading: true,
        leading: Material(
          color: FsColor.white,
          child: GestureDetector(
            onTap: () {
              openProfileView();
              /*FirebaseDatabaseSSO.getUpdateAvailbleVersions().then((update) {
                print(update);
                showUpdateDailog(update);
                });*/
            },
            child: Container(
              height: 150,
              width: 150,
              margin: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                // shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover, image: buildNetworkImage()),
              ),
            ),
          ),
        ),

        actions: <Widget>[
          IconButton(
              icon: Icon(FlutterIcon.bell,
                  color: FsColor.basicprimary, size: FSTextStyle.h5size),
              onPressed: () {
                openNotification();
              }),
          notifications != 0
              ? Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
//                  width:24, height: 24,
                    padding: EdgeInsets.all(3),
                    decoration: new BoxDecoration(
                      color: FsColor.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      notifications.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h7size,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container(),
          MainDashboardState.cart_icon,
        ],

//         actions: <Widget>[
//           GestureDetector(
//             onTap: () {
//               openProfileView();
//               /*FirebaseDatabaseSSO.getUpdateAvailbleVersions().then((update) {
//                 print(update);
//                 showUpdateDailog(update);
//               });*/

//             },
//             child: Container(
//               height: 40,
//               width: 40,
//               margin: const EdgeInsets.only(left: 0.0, right: 10.0, top: 7.0, bottom: 7.0),
//               decoration: new BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20.0),
//                   // shape: BoxShape.circle,
//                   image: new DecorationImage(fit: BoxFit.cover, image: buildNetworkImage()),
//                   ),
// //                color: Colors.white,
// //                height: 10,
// //                margin: const EdgeInsets.only(
// //                    left: 0.0, right: 10.0, top: 5.0, bottom: 5.0),
//               //     child: ClipRRect(
//               //       borderRadius: BorderRadius.circular(40.0),
//               //       child: profileUrl != null
//               //           ? buildNetworkImage()
//               //           : Image.asset(
//               //         'images/default.png',
//               //         fit: BoxFit.cover,
//               //       ),
//               //  ),
//             ),
//           ),
//         ],
      ),
      //drawer: navigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            IplCard(
              profileurl: profileUrl,
            ),

            buildMyBusinessCard(),
            // buildCoronaCard(),
            MeetingCard(),
            societyCard = new SocietyCard(onSelect: () {
              print("CSONE call backkkkkkkkkkkkkkk");
              v.onUpdate();
            }),
            vizlogCard = new VizlogCard(
              onInitialUpdate: (DashbaordCard a) {
                v = a;
              },
            ),
            new RecipeCard(),
            new GroceryCard(),
            new RestaurantCard(),
            isWineShow ? new PynaCard() : Container(),
            // new WineShopCard(),
            new TiffinCard(),
            /* new DailyEssentialCard(),*/
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkToshowPynaShow() async {
    print("checkToshowPynaShow");
    isWineShow = false;
    List _companies = await SsoStorage.getOneAppInterest();
    print(_companies);
    if (_companies == null) {
      FirebaseDatabaseSSO.getIntrest().then((x) {
        print("xxxxxxxxxxxxxxxxxxxx");
        print(x);
        if (x == null) {
          _alchoholInterestDialog();
        } else {
          List list1 = x as List;
          var list =
              list1.where((element) => element['key'] == "Pyna Wines").toList();
          if (list.length > 0) {
            var list2 = list1
                .where((element) =>
                    element['key'] == "Pyna Wines" && element['isSelected'])
                .toList();
            if (list2.length > 0) {
              SsoStorage.setOneAppInterest(x);
              isWineShow = true;
              setState(() {});
            }
          } else {
            _alchoholInterestDialog();
          }
        }
      }).catchError((e) {
        _alchoholInterestDialog();
      });
    } else {
      var list = _companies
          .where((element) =>
              element['key'] == "Pyna Wines" && element['isSelected'])
          .toList();
      if (list.length > 0) {
        isWineShow = true;
        setState(() {});
      }
    }
  }

  Widget buildCoronaCard() {
    try {
      if (FsPlatform.isAndroid()) {
        return new CoronaCard();
      } else {
        return Container();
      }
    } catch (e) {
      return Container();
    }
  }

  void _alchoholInterestDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
              "Are you interested in finding wine shop near you?".toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey)),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: new Text(
                          "No",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.darkgrey),
                        ),
                        onPressed: () {
                          closePopAndSave(context, "no");
                        },
                      ),
                      RaisedButton(
                        child: new Text(
                          "Yes",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.white),
                        ),
                        color: FsColor.basicprimary,
                        onPressed: () {
                          closePopAndSave(context, "yes");
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> closePopAndSave(BuildContext context, String action) async {
    Navigator.of(context).pop('dialog');
    if (action == 'yes') {
      //Case 1:Yes
      var profilePojo2 = profilePojo["dob"];
      if (profilePojo2 != null) {
        if (AppUtils.getDateDiffOfYears(profilePojo2) >= 21) {
          setInterstInLocal(true);
        } else {
          InterestPageState.showUnderAgeAlertDialog(context);
          setInterstInLocal(false);
        }
      } else {
        var result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => CheckBoxAletDialog()));
        if (result == null) {
          _alchoholInterestDialog();
        } else if (result['result'] != null) {
          setInterstInLocal(false);
        } else {
          setInterstInLocal(true);
        }
      }
    } else {
      setInterstInLocal(false);
    }
  }

  void setInterstInLocal(bool status) {
    FirebaseDatabaseSSO.getIntrest().then((x) {
      if (x == null) {
        InterestPageState.intrestArray.where((element) {
          if (element['key'] == "Pyna Wines") {
            element['isSelected'] = status;
          }
        });
        SsoStorage.setOneAppInterest(InterestPageState.intrestArray);
        FirebaseDatabaseSSO.saveIntrest(InterestPageState.intrestArray);
      } else {
        List x1 = x as List;
        var a11 = InterestPageState.intrestArray
            .singleWhere((element) => element['key'] == "Pyna Wines");
        a11["isSelected"] = status;
        x1.add(a11);
        print("xddddddddddd");
        print(x1);

        FirebaseDatabaseSSO.saveIntrest(x1 as List);
        SsoStorage.setOneAppInterest(x1 as List);
      }
    }).catchError((e) {
      InterestPageState.intrestArray.where((element) {
        if (element['key'] == "Pyna Wines") {
          element['isSelected'] = status;
        }
      });
      SsoStorage.setOneAppInterest(InterestPageState.intrestArray);
      FirebaseDatabaseSSO.saveIntrest(InterestPageState.intrestArray);
    });
    isWineShow = status;
    setState(() {});
  }

  ImageProvider buildNetworkImage() {
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
  }

  Widget buildMyBusinessCard() {
    return isBusinessMode ? new MyBusinessCard() : new Container();
  }

  void openProfileView() {
    AppUtils.checkInternetConnection().then((onValue) async {
      if (onValue) {
        /*Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => ProfileView()),
        );*/
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProfileView(
                notifyFunction: () {
                  print("calllllllllllllllllllll");
                  setState(() {});
                },
              );
            },
          ),
        );
      } else {
        print("No Internet Available");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }

  showUpdateDailog(maxMersion) {
    _appFeatureUpdateDialog(maxMersion);
    /*if (maxMersion == null || maxMersion["is_update_available"] == null ||
        !maxMersion["is_update_available"]) {
      return;
    }*/
//    print(maxMersion["is_update_available"]);
    /* return showDialog<void>(
      context: context, // user must tap button!
      builder: (BuildContext context) {
        var isUpdateAvailable = maxMersion["is_update_available"];
        return AlertDialog(
          title: Text('One App Features'),
          content: SingleChildScrollView(
            child: ListBody(
              children: getWhatnewLines(maxMersion["max_version"]["whats_new"]),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            isUpdateAvailable
                ? FlatButton(
              child: Text('Update'),
              onPressed: () {
                AppUtils.openAppStore();
                Navigator.of(context).pop();
              },
            )
                : Container(),
          ],
        );
      },
    );*/
  }

  List<Widget> getWhatnewLines(List maxMersion) {
    List<Widget> widgetLines = [];
    for (var maz in maxMersion) {
      var txt = Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          maz,
          style: TextStyle(
              fontFamily: 'Gilroy-Regular',
              fontSize: FSTextStyle.h6size,
              color: FsColor.darkgrey),
        ),
      );
      widgetLines.add(txt);
    }
    return widgetLines;
  }

  @override
  void onError(error) {
    notifications = 0;
    setState(() {});
  }

  @override
  void onFailure(failure) {
    notifications = 0;
    setState(() {});
  }

  @override
  void onRespondSuccess(success) {}

  @override
  void onSuccess(success) {
    if (success != null)
      notifications = success.length;
    else
      notifications = 0;
    setState(() {});
  }

  void getNotificationCount() {
    MemberInvitationPresenter invitationPresenter =
        new MemberInvitationPresenter(this);
    invitationPresenter.getMemberInvitation();
  }

  void _appFeatureUpdateDialog(updateApp) {
    print("fffffffff");
    print(updateApp);
    if (updateApp == null ||
        updateApp["is_update_available"] == null ||
        !updateApp["is_update_available"]) {
      return;
    }

    /*maxMersion["max_version"]["whats_new"]*/
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: <Widget>[
                Text("What's New".toLowerCase(),
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h4size,
                        color: FsColor.darkgrey)),
                updateApp["max_version"]["version_name"] != null
                    ? Text(
                        "Version : ${updateApp["max_version"]["version_name"]}"
                            .toLowerCase(),
                        style: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey))
                    : Container(),
              ],
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    getWhatnewLines(updateApp["max_version"]["whats_new"]),
                /* <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text("1.   Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text("2.   Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text("3.   Lorem Ipsum is simply dummy text of the printing and typesetting industry. ipsu doloro sit ause",
                      style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text("4.   Lorem Ipsum is simply dummy text of the printing and typesetting industry. ipsu doloro sit ause",
                      style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    ),
                  ),*/

                /*],*/
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.darkgrey),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
              ),
              RaisedButton(
                child: new Text(
                  "Update Now",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.white),
                ),
                color: FsColor.basicprimary,
                onPressed: () {
                  Navigator.of(context).pop();
                  AppUtils.openAppStore();
                },
              ),
            ],
          );
        });
  }

  Future<void> openNotification() async {
    var event = await FsNavigator.push(context, MyFlatsInvitees());
  }
}
