import 'dart:io';

import 'package:common_config/utils/application.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class FirebaseNotifications {
  static String online_order_notification_type = "Online Order";
  static FirebaseMessaging firebaseMessaging;

//  Notifier _notifier;

  FirebaseNotifications() {
    firebaseMessaging = FirebaseMessaging();
  }

  void setUpFirebase() {
//    firebaseMessaging = FirebaseMessaging();
//    firebaseCloudMessaging_Listeners();
//    localNotifications();
  }

  Future<String> getFcmToken() async {
    String ftoken = null;
    return await firebaseMessaging.getToken();
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    print("myBackgroundMessageHandler1111111");
    print(message);
    if (message['data'] != null) {
      final data = message['data'];
      final title = data['title'];
      final body = data['message'];
      print("myBackgroundMessageHandler22222222");
      print("data--------" + data);
      print("title--------" + title);
      print("title--------" + body);
      //  await _showNotificationWithDefaultSound(title, message);
    }
    return Future<void>.value();
  }

  bool isConfigured = false;

  void firebaseCloudMessaging_Listeners(BuildContext context,
      {Function onRedirected}) {
    if (Environment().getCurrentConfig().geCurrentPlatForm() !=
        FsPlatforms.IOS) {
      return;
    }
    if (!isConfigured) {
      if (Environment().getCurrentConfig().geCurrentPlatForm() ==
          FsPlatforms.IOS) firebaseMessaging.requestNotificationPermissions();
      isConfigured = false;
      print("firebaseCloudMessaging_Listeners--------------configure");
      firebaseMessaging.configure(
          // onBackgroundMessage: myBackgroundMessageHandler,
          onMessage: (Map<String, dynamic> message) {
        print("onMessage:------- $message");
        handleMs(context, message,
            type: "onMessage", onRedirected: onRedirected);
      }, onResume: (Map<String, dynamic> message) {
        print('onResume: $message');
        handleMs(context, message,
            type: "onResume", onRedirected: onRedirected);
      }, onLaunch: (Map<String, dynamic> message) {
        print('onLaunch: $message');
        handleMs(context, message,
            type: "onLaunch", onRedirected: onRedirected);
      });
    } else {
      print("firebaseCloudMessaging_Listeners--------------");
      isConfigured = true;
    }
  }

  void handleMs(BuildContext context, var message,
      {var type, Function onRedirected}) {
    //onResume   in Android: {notification: {}, data: {collapse_key: com.cubeone.app, google.original_priority: high,
    // google.sent_time: 1592306857025, google.delivered_priority: high, google.ttl: 2419200,
    // from: 1087730653023, click_action: FLUTTER_NOTIFICATION_CLICK,
    // google.message_id: 0:1592306857039186%47f373d747f373d7}}
    try {
      if (Environment().getCurrentConfig().geCurrentPlatForm() ==
          FsPlatforms.IOS) {
        if (message['aps'] != null) {
          print("iOS:---------- ${message['aps']['alert']}");
          message['notification'] = message['aps']['alert'];
        }
      }
      Map notification = message["notification"];
      if (notification == null ||
          notification.isEmpty ||
          notification.length == 0) {
        print("------------------Notificiation");
        print(message["data"]);
        message['notification']["title"] = message["data"]["title"];
        message['notification']["body"] = message["data"]["body"];
        // return;
      }
      var title = message['notification']['title'].toString();
      var body = message['notification']['body'].toString();
      print("title: ${title}");
      print("body: ${body}");
      if (title == null) {
        return;
      }
      if (title.toLowerCase() == "Update available.".toLowerCase()) {
        return;
      }
      try {
        print("message['push_notification_redirect']");
        print(message['push_notification_redirect']);
        if (message['push_notification_redirect'] == null &&
            message['data'] != null &&
            message['data']['push_notification_redirect'] != null) {
          message['push_notification_redirect'] =
              message['data']['push_notification_redirect'];
          print(message['push_notification_redirect']);
        }
        if (message['push_notification_redirect'] != null) {
          if (type != 'onMessage') {
            onRedirected(message['push_notification_redirect']);
            return;
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                    backgroundColor: Colors.white,
                    title: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: 24,
                          height: 24,
                          child:
                              Icon(FlutterIcon.bell, size: FSTextStyle.h4size),
                        ),
                        SizedBox(width: 10),
                        Text(title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h4size,
                                color: FsColor.darkgrey)),
                      ],
                    ),
                    shape: new RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: new BorderRadius.circular(7.0),
                    ),
                    content: Wrap(
                      children: <Widget>[
                        Text(body,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h6size,
                                color: Colors.grey[600])),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          onRedirected(message['push_notification_redirect']);
                        },
                        child: Text(
                          "Check Now",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h5size,
                              color: FsColorStepper.active),
                        ),
                      )
                    ],
                  );
                });
            return;
          }
        }
        /*else {
          return;
        }*/
      } catch (e) {
        print(e);
      }
      if (type != 'onMessage') {
        return;
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
              backgroundColor: Colors.white,
              title: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 24,
                    height: 24,
                    child: Icon(FlutterIcon.bell, size: FSTextStyle.h4size),
                  ),
                  SizedBox(width: 10),
                  Text(title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h4size,
                          color: FsColor.darkgrey)),
                ],
              ),
              shape: new RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: new BorderRadius.circular(7.0),
              ),
              content: Wrap(
                children: <Widget>[
                  Text(body,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          color: Colors.grey[600])),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h5size,
                        color: FsColorStepper.active),
                  ),
                )
              ],
            );
          });
    } catch (e) {
      print(e);
    }
  }

  void showNotification(message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'com.cubeone.app' : 'com.cubeone.app',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['title'].toString(),
      message['body'].toString(),
      platformChannelSpecifics,
      /*payload: json.encode(message)*/
    );
  }

  void iOS_Permission() {
    firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  //TODO Give abhijeet with data of this code production
  _showNotificationWithSound(Map<String, dynamic> message) async {
    print(message);
    var s = message['notification']['title'];
    print("------------------------$s");
    print(message['notification']['body']);
//    var initializationSettingsAndroid =
//    new AndroidInitializationSettings('@mipmap/ic_launcher');
//    var initializationSettingsIOS = new IOSInitializationSettings();
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//    flutterLocalNotificationsPlugin.initialize(initializationSettings);
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        /*  sound: 'slow_spring_board',*/
//        importance: Importance.Max,
//        priority: Priority.High);
//    var iOSPlatformChannelSpecifics =
//    new IOSNotificationDetails(
//      /*sound: "slow_spring_board.aiff"*/);
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    flutterLocalNotificationsPlugin.show(
//      0,
//      message['notification']['title'],
//      /*message['notification']['body'].toString()+" || "+*/
//      message['notification']['body'],
//      platformChannelSpecifics,
//      payload: 'Custom_Sound',
//    );
    //await showNotification(message, general: 1);
  }

/* static const AndroidNotificationChannel channel =
  const AndroidNotificationChannel(
    id: 'some_channel_id',
    name: 'My app feature that requires notifications',
    description:
    'Grant this app the ability to show notifications for this app feature',
    importance: AndroidNotificationChannelImportance.HIGH,
    // default value for constructor
    vibratePattern:
    AndroidVibratePatterns.DEFAULT, // default value for constructor
  );*/

/*static var receivedData;

  static localNotification(var data) async {
    print("--------notification_received--------------");
    print(data);
    receivedData = data["data"];
    print(receivedData);
    await showNotification(data);
  }*/

/*static Future showNotification(data, {int general}) async {
    await LocalNotifications.createAndroidNotificationChannel(channel: channel);
    if (general != null && general == 1) {
      await LocalNotifications.createNotification(
        title: data['notification']['title'],
        content: data['notification']['body'],
        id: 0,
        iOSSettings: new IOSSettings (
          presentWhileAppOpen: true, // default value for constructor

        ),

        androidSettings: new AndroidSettings(
          channel: channel,
          priority: AndroidNotificationPriority.HIGH,
          // default value for constructor
          vibratePattern:
          AndroidVibratePatterns.DEFAULT, // default value for constructor
        ),

      );
    } else {
     */ /* await LocalNotifications.createNotification(
          title: "Hello member",
          content: "You have a new visitor " +
              data["data"]["visitor_details"]["visitor_name"],
          id: 0,
          iOSSettings: new IOSSettings (
            presentWhileAppOpen: true, // default value for constructor

          ),
          imageUrl: data["data"]["visitor_details"]["image_url"],
          androidSettings: new AndroidSettings(
            channel: channel,
            priority: AndroidNotificationPriority.HIGH,
            // default value for constructor
            vibratePattern:
            AndroidVibratePatterns.DEFAULT, // default value for constructor
          ),
          actions: [
            new NotificationAction(
              actionText: "Allow",
              callback: handleCustomActionClick,
              payload: "allowAction",
            ),
            new NotificationAction(
                actionText: "Always Allow",
                callback: handleCustomActionClick,
                payload: "alwaysAllowAction"),
            new NotificationAction(
              actionText: "Reject",
              callback: handleCustomActionClick,
              payload: "rejectAction",
            )
          ]
      );*/ /*
    }
  }

*/
/*static handleCustomActionClick(String payload) {
    LocalNotifications.removeNotification(0);
    print("handleCustomActionClick payload----------------- " + payload);
    List list = [];
    var emitData;
    if (payload == "allowAction") {
      emitData = {"status": "allowed", "state": 1, "data": receivedData};
    } else if (payload == "alwaysAllowAction") {
      emitData = {"status": "always_allowed", "state": 2, "data": receivedData};
    } else if (payload == "rejectAction") {
      emitData = {"status": "denied", "state": 2, "data": receivedData};
    }
    list.add(jsonEncode(emitData));
    FsSocket.emit(list);
  }*/

/*
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
  0, 'plain title', 'plain body', platformChannelSpecifics,
  payload: 'item x');*/

}
