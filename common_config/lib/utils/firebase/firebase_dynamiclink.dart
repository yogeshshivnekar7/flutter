import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class FirebaseDynamicLink {
  static BuildContext context;

  static Future handleDynamikLinks(
      BuildContext context, Function handleLinkData) async {
    FirebaseDynamicLink.context = context;
    PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDynamikLinks(data, handleLinkData);
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      _handleDynamikLinks(dynamicLinkData, handleLinkData);
    }, onError: (OnLinkErrorException e) {
      print(e);
    });
  }

  static Future<Uri> getLink(String title, String subtitle, String campaign,
      {String link, Map data, String childLink}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print(packageName);
    print(buildNumber);
    print(version);
    int i = int.parse(buildNumber);

    var uri;
    if (childLink == null || childLink.trim().isEmpty) {
      uri = 'https://cubeoneapp.com/';
      uri += "?" + "campaign=" + campaign.toString();
      if (data != null) {
        print("Firebase Dynamic Links data !=null ");
        print(data);
        List keys_list = data.keys.toList();
        for (int i = 0; i < keys_list.length; i++) {
          var keys_name = keys_list[i];
          uri += "&" + keys_name + "=" + data[keys_name].toString();
        }
      }
    } else {
      uri = childLink;
    }

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: (link == null) ? 'https://cubeone.page.link' : link,
        link: Uri.parse(uri),
        androidParameters: AndroidParameters(
          packageName: packageName,
          minimumVersion: i,
        ),
        iosParameters: IosParameters(
          bundleId: packageName,
          minimumVersion: "1.1.17",
          appStoreId: "1492930711",
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: title,
          description: subtitle,
          imageUrl: new Uri.https("cubeoneapp.com", "/img/logo/logo-icon.png"),
        ));

    //  Uri dynamicUrl = await parameters.buildUrl();
    //  return dynamicUrl;
    //print(dynamicUrl);
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    print(shortLink.shortUrl);
    return shortLink.shortUrl;
  }

  static void _handleDynamikLinks(
      PendingDynamicLinkData data, Function handleLinkData) {
    print(data);
    Uri deeplink = data?.link;
    print("_handleDynamikLinks| deeplink value :${deeplink}");
    if (deeplink != null) {
      Map map = deeplink.queryParameters;
      print(map);
      if (map != null) {
        List keys_list = map.keys.toList();
        for (int i = 0; i < keys_list.length; i++) {
          var keys_name = keys_list[i];
          var keys_value = map[keys_name];
          print(keys_name + "====" + keys_value);
        }
        //if (map['c_id'] != null) {
        //Store Detail Page Case
        handleLinkData('Store Detail', map, deeplink.toString());
        // }
      }
    }
  }
}
