import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/ui/module/recipe/models/category.dart';
import 'package:sso_futurescape/ui/module/recipe/models/cuisine.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/login_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/tabs_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';

import '../myapp.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen1> {
  List<Recipe> recentRecipesWithLimit = List<Recipe>();
  List<Recipe> recentRecipes = List<Recipe>();
  List<Category> categories = List<Category>();
  List<Cuisine> cuisine = List<Cuisine>();
  List<Recipe> mostCollectedRecipes = List<Recipe>();
  List<Recipe> allRecipes = List<Recipe>();

  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  bool isRetrieving = true;

  String userId;
  String userUid;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _checkAndroidConnectivity();
    } else {
      _retrieveData();
    }

    checkIfLoggedIn().then((value) {
      setState(() {
        userId = value;
      });
    });

    if (userId == null) {
      checkIfLoggedInWithOtherMethods().then((value) {
        setState(() {
          userUid = value;
        });
      });
    }
  }

  Future<String> checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');
    return id;
  }

  Future<String> checkIfLoggedInWithOtherMethods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    return uid;
  }

  Future _checkAndroidConnectivity() async {
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      if (result == ConnectivityResult.none) {
        /*WidgetsBinding.instance.addPostFrameCallback((_) => _showAlert(context,
            'No Internet Connection', 'Please Check Internet Connection'));*/
      } else {
        _retrieveData();
      }
    });
  }

  Future _retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    if (firstTime == null) {
      // first time
      firebaseCloudMessagingListeners();
      prefs.setBool('first_time', false);
    }

    String lang = prefs.getString('lang');

    if (lang == 'en') {
      MyApp.setLocale(context, Locale('en', 'US'));
    } else if (lang == 'zh') {
      MyApp.setLocale(context, Locale('zh', 'CN'));
    }

    // Get all categories
    await HttpService.getCategories().then((c) {
      setState(() {
        categories = c;
        print('Retrieved All Categories');
      });
    });

    // Get all cuisine
    await HttpService.getCuisine().then((c) {
      setState(() {
        cuisine = c;
        print('Retrieved All Cuisine');
      });
    });

    // Get all recipes
    await HttpService.getAllRecipes().then((r) {
      setState(() {
        allRecipes = r;
        print('Retrieved All Recipes');
      });
    });

    // Get most collected recipes
    await HttpService.getMostCollectedRecipes().then((r) {
      setState(() {
        mostCollectedRecipes = r;
        print('Retrieved Most Collected Recipes');
      });
    });

    // Get recent recipes with a limit
    await HttpService.getRecentRecipesWithLimit().then((r) {
      setState(() {
        recentRecipesWithLimit = r;
        print('Retrieved Recent Recipes With Limit');
      });
    });

    // Get all recent recipes
    await HttpService.getRecentRecipes().then((r) {
      setState(() {
        recentRecipes = r;
        print('Retrieved All Recent Recipes');
      });
    });

    setState(() {
      isRetrieving = false;
    });
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      HttpService.addDevice(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/images/logo.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child:
                Text('Food Recipes', style: GoogleFonts.pacifico(fontSize: 26)),
          ),
        ],
      ),
    );
  }

  Widget loadingScreen(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget loadingScreenNoConnection(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  /*_showAlert(BuildContext context, String title, String desc) {
    Alert(
      context: context,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (_connectionStatus == 'ConnectivityResult.wifi' ||
                _connectionStatus == 'ConnectivityResult.mobile') {
              Navigator.pop(context);
            }
          },
          color: FsColor.primaryrecipe,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }*/

  @override
  void dispose() {
    if (Platform.isAndroid) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: (!isRetrieving)
            ? (userId != null || userUid != null)
                ? TabsScreen(
                    allRecipes: allRecipes,
                    mostCollected: mostCollectedRecipes,
                    recentRecipes: recentRecipes,
                    recentRecipesWithLimit: recentRecipesWithLimit,
                    categories: categories,
                    cuisine: cuisine)
                : LoginScreen(
                    allRecipes: allRecipes,
                    mostCollected: mostCollectedRecipes,
                    recentRecipes: recentRecipes,
                    recentRecipesWithLimit: recentRecipesWithLimit,
                    categories: categories,
                    cuisine: cuisine)
            : loadingScreen(context),
      ),
    );
  }
}
