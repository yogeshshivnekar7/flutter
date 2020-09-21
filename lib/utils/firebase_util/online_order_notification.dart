import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'noomiKeys.dart';

class OnlineOrderNotification {
  OnlineOrderNotification();

  void handleNotifications(Map<String, dynamic> message) {
    String order_status = message['data']['status'];
    String delivery_status = message['data']['delivery_status'];
    print('online_status: $order_status');
    print('delivery: $delivery_status');
    if (order_status == 'in process' && delivery_status == 'undelivered') {
      message['notification']['title'] = 'Order confirmed';
      message['notification']['body'] =
          'Order has confirmed by restaurant in process.';
      print('Order confirmed');
      _showOnlineOrderNotificationWithSound(message);
    } else if (order_status == 'in transit' &&
        delivery_status == 'dispatched') {
      message['notification']['title'] = 'Order Picked Up';
      message['notification']['body'] = 'On the way';
      print('Order Picked Up');
      _showOnlineOrderNotificationWithSound(message);
    } else if ((order_status == 'in transit' ||
            order_status == 'delivered' ||
            order_status == 'completed') &&
        delivery_status == 'delivered') {
      message['notification']['title'] = 'Order Delivered';
      message['notification']['body'] = 'Thank you for order!';
      print('Order Delivered');
      _showOnlineOrderNotificationWithSound(message);
    }
  }

  _showOnlineOrderNotificationWithSound(Map<String, dynamic> message) {
    SsoStorage.getUserProfile().then((profile) {
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      String con = Environment().getCurrentConfig().vezaPlugInUrl;
      String order_id = message['data']['order_id'];
      String comapny_id = message['data']['company_id'];
      String order_tracking = con +
          "confirmed?session_token=$sessionToken&username="
              "$userName&companyId=$comapny_id&orderId=$order_id";
      print(order_tracking);
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = new IOSInitializationSettings();
      var initializationSettings = new InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      var flutterLocalNotificationsPlugin =
          new FlutterLocalNotificationsPlugin();

      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'com.cubeone.app.onlineorder',
          'Online Order',
          'Online Order Description',
          importance: Importance.Max,
          priority: Priority.High);
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      var platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      var titile = message['notification']['title'];
      var body = message['notification']['body'];
      flutterLocalNotificationsPlugin.show(
          0, titile, body, platformChannelSpecifics,
          payload: order_tracking);
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    try {
      if ((Platform.isAndroid != null && Platform.isAndroid) ||
          (Platform.isIOS != null && Platform.isIOS)) {
        await NoomiKeys.navKey.currentState.push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              print(Platform.isAndroid);
              return OnlineOrderWebView(
                  BusinessAppMode.ORDERTRACKING, 'Order Tracking', payload);
            },
          ),
        );
      }
    } catch (e) {
      print("Notification Order Online");
      print(e);
    }
  }

  Future openOrderTrackingUI(String orderTracking) async {
    try {
      if ((Platform.isAndroid != null && Platform.isAndroid) ||
          (Platform.isIOS != null && Platform.isIOS)) {
        await NoomiKeys.navKey.currentState.push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              print(Platform.isAndroid);
              return OnlineOrderWebView(
                  BusinessAppMode.ORDERTRACKING, 'Order Tracking',
                  orderTracking);
            },
          ),
        );
      }
    } catch (e) {
      print("Notification Order Online");
      print(e);
    }
  }
}
