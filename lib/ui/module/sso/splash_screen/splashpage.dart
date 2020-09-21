import 'dart:async';
import 'dart:io';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/environment/production.dart';
import 'package:sso_futurescape/config/environment/stage.dart';
import 'package:sso_futurescape/config/environment/test.dart';
import 'package:sso_futurescape/model/app/app_model.dart';
import 'package:sso_futurescape/presentor/module/sso/splash_screen/slpash_screen.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/module/sso/deep_link/deeplink.dart';
import 'package:sso_futurescape/ui/module/sso/signup/mobile.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_notification.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:uni_links/uni_links.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreenPage> implements IAppUpdate {
  Timer time;
  BuildContext context;
  SplashScreenPresentor splashScreenPresentor;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    Network.context = context;
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Environment().getCurrentConfig().name != "production"
          ? Center(
              child: Container(
                width: 300,
                height: 200,
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          Environment().setCurrentConfig(new Test());
                          doWork();
                        },
                        child:
                            Text("TEST", style: TextStyle(color: Colors.white)),
                      ),
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          Environment().setCurrentConfig(new Stage());
                          doWork();
                        },
                        child: Text(
                          "STAGE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Environment().setCurrentConfig(new Production());
                          doWork();
                        },
                        child: Text(
                          "PRODUCTION",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )),
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'images/logo.png',
                        fit: BoxFit.contain,
                        height: 100.0,
                        width: 250.0,
                      ),
                      Text(
                        'Digital Community'.toLowerCase(),
                        style: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            letterSpacing: 1.0,
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey),
                      )
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'from',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              letterSpacing: 1.0,
                              fontSize: FSTextStyle.h7size,
                              color: FsColor.darkgrey),
                        ),
                        GestureDetector(
                          child: Text(
                            'Futurescape',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                letterSpacing: 1.0,
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.basicprimary),
                          ),
                          onTap: () {
                            /* print("dsdsds");*/
                            // String accessToken = jsonDecode["data"]["access_token"];
                            /*AppModel appModel=new AppModel();
                      appModel.deviceRegister((){
                        print("Device Registre");
                      }, (s){
                        print("Device Fauiled");
                      });*/
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
//    productionEnvironment();
    //  FirebaseDatabaseUtils.applicationStart("455");
  }

  void productionEnvironment() {
    if (Environment().getCurrentConfig().name == "production") {
      doWork();
    }
  }

  void doWork() {
    splashScreenPresentor = new SplashScreenPresentor(this);
    new FirebaseNotifications().setUpFirebase();
    var duration = const Duration(microseconds: 100);
    time = new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    checkStoragePermission();
    //splashScreenPresentor.updateCheck();
    return;
  }

  checkStoragePermission() {
    print("checkStoragePermission");
    try {
      if (Environment().getCurrentConfig().geCurrentPlatForm() ==
          FsPlatforms.ANDROID) {
        PermissionsService1 service = new PermissionsService1();
        service.requestStoragePermission().then((granted) {
          if (!granted) {
            onPermissionDenied();
          } else {
            onPermissionGranted();
          }
        });
      } else {
        print("ios platform");
        updateCheck();
      }
    } catch (e) {
      print(e);
    }
  }

  onPermissionDenied() {
    print("onPermissionDenied");
    updateCheck();
  }

  onPermissionGranted() {
    print("onPermissionGranted");
    updateCheck();
  }

  updateCheck() {
    AppUtils.checkInternetConnection().then((onValue) {
      if (onValue) {
        print("onValue " + onValue.toString());
        //Toasly.warning(context, "Internet Connection Available");
        splashScreenPresentor.updateCheck();
      } else {
        openNoInternetConnectionPage();
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }

  /* showSnackbar(BuildContext context, String msg) {
    SnackBar snackBar = SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: Text(msg,
            style: TextStyle(
                color: FsColor.white,
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold')));
    Scaffold.of(context).showSnackBar(snackBar);
  }*/

  openNoInternetConnectionPage() async {
    Map results = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    if (results != null && results.containsKey('connection')) {
      bool isConnection = results["connection"];
      if (!isConnection) {
        openNoInternetConnectionPage();
      } else {
        splashScreenPresentor.updateCheck();
      }
    } else {
      openNoInternetConnectionPage();
    }
  }

  @override
  void dispose() {
    super.dispose();
    time.cancel();
  }

  @override
  void hasNoUpdate() {
    SsoStorage.isLogin().then((isLOgin) {
      print("isLoginisLogin");
      print(isLOgin);
      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            Platform.isIOS) {
          if (isLOgin == "true") {
            SsoStorage.isMobileUpdated().then((isMobileUpdated) async {
              if (isMobileUpdated == 'true') {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/loading', ModalRoute.withName('/loading'));
              } else {
                var userprofile = await SsoStorage.getUserName();
                if (userprofile != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MobilePage(
                              comingFrom: MobilePage.EXISTING,
                              data: userprofile)),
                      ModalRoute.withName('/'));
                } else {
                  Navigator.of(context).pushNamed('/useronbording');
                }
              }
            });
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/useronbording', ModalRoute.withName('/useronbording'));
          }
        } else {
          if (isLOgin == "true") {
            SsoStorage.isMobileUpdated().then((isMobileUpdated) async {
              if (isMobileUpdated == 'true') {
                Navigator.of(context).pushNamed('/loading');
              } else {
                var userprofile = await SsoStorage.getUserName();
                if (userprofile != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MobilePage(
                              comingFrom: MobilePage.EXISTING,
                              data: userprofile)),
                      ModalRoute.withName('/'));
                } else {
                  Navigator.of(context).pushNamed('/useronbording');
                }
              }
            });
          } else {
            Navigator.of(context).pushNamed('/useronbording');
          }
        }
      } catch (e) {
        print(e);

        if (isLOgin == "true") {
          Navigator.of(context).pushNamed('/loading');
        } else {
          Navigator.of(context).pushNamed('/useronbording');
        }
      }
    }).catchError((e) {
      print(e);
      print("isLoginisLogin");
    });
  }

  //FIXED Me
  @override
  void hasUpdate() {
    print("hasUpdatehasUpdate");
    _launchURL();
  }

  _launchURL() async {
    AppUtils.openAppStore();
  }

  String _latestLink = 'Unknown';
  Uri _latestUri;

  StreamSubscription _sub;

//  UniLinksType _type = UniLinksType.string;
  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
//    if (_type == UniLinksType.string) {
//      await initPlatformStateForStringUniLinks();
//    } else {

    //MARK: ADD YOUR CUSTOM URL AS BELOW LINE AND PASS PARAMETERS IN DICTIONARY FORM
    //FacebookAnalyticsPlugin.logCustomEvent(name: "FB_EVENT",parameters:{'SCREEN':'SPLASH'});

    await initPlatformStateForUriUniLinks();
//    }
  }

  /// An implementation using a [String] link
  initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        _latestLink = link ?? 'Unknown';
        _latestUri = null;
        try {
          if (link != null) _latestUri = Uri.parse(link);
        } on FormatException {}
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestLink = 'Failed to get latest link: $err.';
        _latestUri = null;
      });
    });

    // Attach a second listener to the stream
    getLinksStream().listen((String link) {
      print('got link: $link');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String initialLink;
    Uri initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestLink = initialLink;
      _latestUri = initialUri;
    });
  }

  /// An implementation using the [Uri] convenience helpers
  initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

    // Attach a second listener to the stream
    getUriLinksStream().listen((Uri uri) {
      print('got uri: ${uri?.path} ${uri?.queryParametersAll}');
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest Uri
    Uri initialUri;
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialUri = await getInitialUri();
      print('initial uri: ${initialUri?.path}'
          ' ${initialUri?.queryParametersAll}');
      initialLink = initialUri?.toString();
//      print("intiali ------" + initialLink);
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
      callIntent();
    });
  }

  Future<void> callIntent() async {
    if (_latestLink == null) {
      productionEnvironment();
    } else {
      if (_latestLink != null && _latestLink.contains('fb2683802965068406')) {
        productionEnvironment();
        return;
      } else if (_latestLink != null &&
          _latestLink.trim().contains(Environment.config.meetingDomain)) {
        productionEnvironment();
        return;
      }
      _latestLink = _latestLink + "&in_app=1";
      FsNavigator.push(context, DeepLinkWebView(_latestLink));
    }
  }
}

abstract class IAppRegister {
  void notRegister(String data);

  void register();
}
