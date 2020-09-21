import 'dart:async';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/style_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

/*void main() => runApp(MyApp());*/

class OnlineOrderWebView extends StatefulWidget {
  String order_url;
  String user_name;
  String session_token;
  String resto_any_details;
  String resto_name;
  BusinessAppMode calling_from;
  String url;

  var restrodata;

  @override
  State<StatefulWidget> createState() {
    /* return OnlineOrderWebViewState(this.order_url, this.user_name,
        this.session_token, this.resto_any_details, this.resto_name);*/
    return OnlineOrderWebViewState(this.calling_from, this.resto_name, this.url,
        restrodata: restrodata);
  }

  /*OnlineOrderWebView(this.resto_name,
      {this.order_url = "http://stgdemo.vezaone.com/vz-store",
      this.user_name = "test@vezaone.com",
      this.session_token =
          "JDJ5JDEwJDFaWkpManZLVHJMeWlrTzdwdkxzMS5TcHJ5YnZIeC44M2lKL2c5OWdWbWM1NzlwY1hoMXJD",
      this.resto_any_details = "resto_any_details"});*/
  OnlineOrderWebView(this.calling_from, this.resto_name, this.url,
      {this.restrodata});
}

class OnlineOrderWebViewState extends State<OnlineOrderWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String orderUrl;
  String userName;
  String sessionToken;
  String restoAnyDetails;
  String restoName;
  String url;
  BusinessAppMode callingFrom;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<String> _onUrlChanged;

  var restrodata;

  List getCallNumber(Map place) {
    if (place == null || place['details'] == null) {
      return null;
    } else {
      List list = place['details'];
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'] == 'SUPPORT_CONTACT_NO') {
            var split = list[i]['company_value'].toString().split(',');
            print(split);
            return split;
          }
        }
      } else {
        return null;
      }
    }
  }

  Future<void> callIntent(Map place) async {
    List number = getCallNumber(place);
    if (number.length == 1) {
      var number2 = number[0];
      String url = "tel:${number2}";
      if (await AppUtils.canLaunchUrl(url)) {
        await AppUtils.launchUrl(url);
      } else {
        Toasly.error(context, 'Could not launch $url');
      }
    } else {
      Toasly.error(context, 'Could not launch $number');
    }
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("url");
      print(url);

      /*http://devwebsite.chsone.in/payment/success
        http://devwebsite.chsone.in/payment/failed*/
    });
    /*flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
    });*/
    /*_onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        //http://stgdemo.vezaone.com/confirmed/205?order_no=ORD%2F191227%2F007
        */
    /*String order_tracking = con +
            "confirmed?session_token=$sessionToken&username="
                "$userName&companyId=$comapny_id&orderId=$order_id";*/
    /*
        print("Current URLChanges: $url");
        String s = Environment().getCurrentConfig().vezaPlugInUrl + 'confirmed/';
        print(s);
        if (url.contains(s)) {
          print('order is confirm');
          print("Current URL: $url");
          String order_detail = s.substring(s.indexOf(s));
          print(order_detail);
        }
      }
    });*/
  }

  @override
  void dispose() {
    try {
      _onUrlChanged.cancel();
      flutterWebviewPlugin.dispose();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  static Color backgroundColor(BusinessAppMode callingFrom) {
    if (callingFrom == null) {
      return FsColor.white;
    }
    if (callingFrom == BusinessAppMode.TIFFIN) {
      return FsColor.primarytiffin;
    } else if (callingFrom == BusinessAppMode.DAILY_ESSENTIALS) {
      return FsColor.primarydailyessential;
    } else if (callingFrom == BusinessAppMode.GROCERY) {
      return FsColor.primarygrocery;
    } else if (callingFrom == BusinessAppMode.RESTAURANT) {
      return FsColor.primaryrestaurant;
    } else if (callingFrom == BusinessAppMode.WINESHOP) {
      return FsColor.primarywineshop;
    } else
      return FsColor.white;
  }

  @override
  Widget build(BuildContext context) {
    print("sssssssss");
    print(url);
    return WillPopScope(
      onWillPop: () {
        try {
          MainDashboardState.cart_icon.updateValue();
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
      },
      child: WebviewScaffold(
        key: scaffoldKey,
        url: url,
        clearCache: false,
        clearCookies: false,
        withJavascript: true,
        geolocationEnabled: true,

        // run javascript
        withZoom: false,
        // if you want the user zoom-in and zoom-out
        hidden: false,
        // put it true if you want to show CircularProgressIndicator while waiting for the page to load
        appCacheEnabled: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close, size: 18.0),
            color: FsAppBarStyle.iconColor(callingFrom),
            onPressed: () {
              try {
                MainDashboardState.cart_icon.updateValue();
              } catch (e) {
                print(e);
              }
              //              exit_Alert();
              // _exitDialog();
              Navigator.pop(context);
            },
          ),

          /*FsBackButton(backEvent: (context) async {
              bool cabBack=await flutterWebviewPlugin.canGoBack();
              if(cabBack)
              {
                flutterWebviewPlugin.goBack();
              }else{
                Navigator.pop(context);
              }
            },),*/
          backgroundColor: backgroundColor(callingFrom),
          title: Text(AppUtils.capitalize(restoName),
              style: FsAppBarStyle.getAppStyle(callingFrom)),
          centerTitle: false,
          elevation: 1,
          // give the appbar shadows
          iconTheme: IconThemeData(color: Colors.white),
          /* actions: <Widget>
            print("fffffff");
        // put it true if you want to show CircularProgressIndicator while waiting for the page to load
        appCacheEnabled: true,
        appBar: AppBar(
          /*leading: FsBackButton(backEvent: (context) async {
          bool cabBack=await flutterWebviewPlugin.canGoBack();
            if(cabBack)
            {
              flutterWebviewPlugin.goBack();
            }else{
              Navigator.pop(context);
            }
          },),*/
          backgroundColor: backgroundColor(),
          title: Text(
            AppUtils.capitalize(restoName),
            style: FSTextStyle.appbartextlight,
          ),
          centerTitle: false,
          elevation: 1,

          // give the appbar shadows
          iconTheme: IconThemeData(color: Colors.white),

          */

          actions: <Widget>[
            /*print("fffffff");
            print( getCallNumber(restrodata));*/
            getCallNumber(restrodata) == null
                ? Container()
                : Container(
                    width: 48,
                    child: FlatButton(
                      child: Icon(Icons.call,
                          color: FsAppBarStyle.iconColor(callingFrom)),
                      onPressed: () {
                        callIntent(restrodata);
                        //flutterWebviewPlugin.reload();
                        // flutterWebviewPlugin.reloadUrl(); // if you want to reloade another url
                      },
                    ),
                  )
          ],
          /*actions: <Widget>[
              InkWell(
                child: Icon(Icons.refresh),
                onTap: () {
                  flutterWebviewPlugin.reload();
                  // flutterWebviewPlugin.reloadUrl(); // if you want to reloade another url
                },
              ),
              InkWell(
                child: Icon(Icons.stop),
                onTap: () {
                  flutterWebviewPlugin.stopLoading(); // stop loading the url
                },
              ),
              InkWell(
                child: Icon(Icons.remove_red_eye),
                onTap: () {
                  flutterWebviewPlugin.show(); // appear the webview widget
                },
              ),
              InkWell(
                child: Icon(Icons.close),
                onTap: () {
                  flutterWebviewPlugin.hide(); // hide the webview widget
                },
              ),
              InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  flutterWebviewPlugin.goBack(); // for going back
                },
              ),
              InkWell(
                child: Icon(Icons.forward),
                onTap: () {
                  flutterWebviewPlugin.goForward(); // for going forward
                },
              ),
            ],*/
        ),

        /* initialChild: Container(
            // but if you want to add your own waiting widget just add InitialChild
            color: Colors.white,
            child: */ /*const Center(
              child: Text('waiting...')*/ /*
            PageLoader(),
          )*/
      ),
    );
  }

  /*OnlineOrderWebViewState(this.order_url, this.user_name, this.session_token,
      this.resto_any_details, this.resto_name);*/
  OnlineOrderWebViewState(this.callingFrom, this.restoName, this.url,
      {this.restrodata});

  /*void exit_Alert() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                "Close",
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.white),
              ),
              color: FsColor.basicprimary,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();

                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  void _exitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: Container(
              height: 480.0,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 1, color: FsColor.lightgrey.withOpacity(0.8)),
                    )),
                    child: Text(
                      'Exit Page',
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h3size,
                          color: FsColor.basicprimary),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
