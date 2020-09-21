import 'dart:convert';
import 'package:common_config/utils/firebase/firebase_dynamiclink.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/utils/UriUtils.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:uri/uri.dart';

class MeetVoteUtils {
  static Map<String, String> getJoinMeetingUrlParams(String url) {
    return UriUtils.parseUrl(
        url, UriTemplate(UriUtils.isHttpsUrl(url)
            ? AppConstant.URL_TEMPLATE_JOIN_MEETING_HTTPS
            : AppConstant.URL_TEMPLATE_JOIN_MEETING_HTTP));
  }

  static String getMeetingIdFromUrl(String url) {
    Map<String, String> params = getJoinMeetingUrlParams(url);
    return params != null ? params["meeting_id"] : null;
  }

  static String getMeetingLink(int meetingId) {
    String meetingLink;
    try {
      meetingLink = UriTemplate(AppConstant.URL_TEMPLATE_JOIN_MEETING_HTTPS).expand({
            "meeting_id": meetingId
          });
    } catch (e) {
      print(e);
      return "";
    }
    return meetingLink;
  }

  static String getFullName(String firstName, String lastName) {
    return ((firstName?.trim() ?? "") + " " +
        (lastName?.trim() ?? ""))?.trim() ?? "";
  }

  static Function onBackPressed(BuildContext context) {
    return (obj) {
      Navigator.of(context).pop();
    };
  }

  static Future<int> getDefaultSocietyIfInvalid(int societyId) {
    if (societyId > 0) {
      return Future.value(societyId);
    } else {
      Future<int> future = Future(() async {
        dynamic socObj = await SsoStorage.getDefaultChsoneUnit();
        if (socObj != null) {
          socObj = jsonDecode(socObj);
        }
        String socIdStr = socObj != null ? socObj["soc_id"] : "-1";
        return (socIdStr != null && socIdStr.trim().isNotEmpty) ? int.parse(socIdStr) : 0;
      });
      return future;
    }
  }

  static Future<String> getDefaultMeetingSocietyIfInvalid(var societyId) {
    if (societyId != null && societyId.toString().trim().isNotEmpty) {
      return Future.value(societyId);
    } else {
      Future<String> future = Future(() async {
        dynamic socObj = await SsoStorage.getMeetingSociety();
        if (socObj != null) {
          socObj = jsonDecode(socObj);
        }
        String socIdStr = socObj != null ? socObj["soc_id"] : "";
        return (socIdStr != null && socIdStr.trim().isNotEmpty) ? socIdStr : "";
      });
      return future;
    }
  }

  static Future<String> getMeetingToken() {
    Future<String> future = Future(() async {
      String accessToken = await SsoStorage.getMeetingToken();
      return accessToken?.trim() ?? "";
    });
      return future;
  }

  static String generateMeetingSocietyId(int userId) {
    return (userId > 0) ? "10000$userId" : "";
  }
}








