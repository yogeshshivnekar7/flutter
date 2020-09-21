import 'dart:collection';

import 'package:common_config/utils/application.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

class FirebaseDatabaseUtils {
  static String environment;


  static Future<void> saveData(var data) async {
    final DatabaseReference notesReference = FirebaseDatabase.instance
        .reference()
        .child('cubeOne')
        .child(environment);
    await notesReference.set(data);
  }

  static DatabaseReference getInstanceId() {
    return FirebaseDatabase.instance
        .reference()
        .child('cubeOne')
        .child(environment);
  }

  static Future<dynamic> getValues(String userId) async {
    try {
      final notesReference = FirebaseDatabaseUtils.getInstanceId();

      print(userId);
      var child = notesReference.child("intrest").child(userId);
      print(child);
      DataSnapshot dataSnapshot = await child.once();
      print(dataSnapshot.value);
      if (dataSnapshot.value != null) {
        List list = dataSnapshot.value;
        print("ddddddddddddddddddddddddd");
        print(list);
        if (list.length != 0) {
          return list;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static void saveErrorLogData(HashMap<String, String> errorMap) {
    errorReport(errorMap);
  }

  static Future<void> errorReport(dynamic data) {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM-dd-HH-mm-ss');
    String formattedDate = formatter.format(now);
    final notesReference = FirebaseDatabaseUtils.getInstanceId();
    return notesReference.child("error").child(formattedDate).set(data);
  }

  static Future<dynamic> getUpdates(FsPlatforms platForm) async {
    try {
      final notesReference = FirebaseDatabaseUtils.getInstanceId();
      HashMap demo = new HashMap();
      /* demo["version_name"] = "ss";
      demo["whats_new"] = ["Line1", "Line2"];
      notesReference.child("app_updates").child("android").child("v_9").set(
          demo);*/
      var child = notesReference.child(
          "app_updates");
      DataSnapshot dataSnapshot = await child.once();
      print(dataSnapshot.key);
      if (dataSnapshot.value != null) {
        LinkedHashMap update = dataSnapshot.value;
        print(dataSnapshot.value);
        var maxVersionCode = 0;
        var currentVersionCode = 0;
        var maxVersionsData = null;
        var currentVersionData = null;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String buildNumber = packageInfo.buildNumber;
        print(buildNumber);
        String am;
        if (platForm == FsPlatforms.ANDROID) {
          am = "android";
        } else if (platForm == FsPlatforms.IOS) {
          am = "ios";
        }
        for (String v in update[am].keys) {
          int version = int.parse(v.replaceAll("v_", ""));
          if (maxVersionCode <= version) {
            maxVersionsData = update[am][v];
            maxVersionCode = version;
          }
          if (buildNumber == version.toString()) {
            currentVersionData = update[am][v];
            currentVersionCode = version;
          }
        }
        var finalUpdateObj = {
          "current_version": currentVersionData,
          "max_version": maxVersionsData,
          "is_update_available": currentVersionCode < maxVersionCode,
          "appName": packageInfo.appName,
          "packageName": packageInfo.packageName,
          "version": packageInfo.version,
        };
        return Future.value(finalUpdateObj);
      }
    } catch (e) {
      print(e);
    }
    return Future.value(null);
  }


  static Future<void> saveComapnayUsers(String companyId, String userId) async {
    try {
      var data = HashMap();
      var now = new DateTime.now();
      var formatter = new DateFormat('dd-MM-yyyy');
      data["date"] = formatter.format(now);
      final DatabaseReference notesReference = FirebaseDatabase.instance
          .reference()

          .child('cubeOne')
          .child(environment);
      await notesReference.child("sells").child(companyId).child(userId).set(
          data);
    } catch (e) {

    }
  }

}
