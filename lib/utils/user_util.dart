import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class UserUtils {
  static void pushUserData(profile) {
    String sessionToken = profile["session_token"];
    SsoStorage.setSessionToken(sessionToken);
    var appAccess = profile["app_access"];
    List comAppAccess = profile["com_app_access"];
    // print("__________ssss____________");
    //print(comAppAccess);
    SsoStorage.saveCompanyAccess(comAppAccess);
    //print("__________ssss____________");
    SsoStorage.saveAppAccess(appAccess);
    UserUtils.getHRMSCompanies().then((hrmsCompanies) {
      SsoStorage.setAllHRMSCompany(hrmsCompanies);
    });

    //print(getChsoneCompanies());
    //print("__________ssss____________");
  }

  static Future<dynamic> getDefaultChsoneSoc() async {
    String a = await SsoStorage.getDefaultChsoneSoc();
    if (a == null) {
      List list = getChsoneCompanies();
      if (list != null && list.length != 0) {
        return list[0];
      }
    }
    return Future.value(null);
  }

  static getChsoneCompanies() async {
    List appacess = await SsoStorage.getAppAccess() as List;
    var chsoneAccess = appacess.where((x) =>
    x["app_id"] == Environment()
        .getCurrentConfig()
        .chsoneAppId);
    var companyChsone = [];
    chsoneAccess.toList().forEach((f) => {companyChsone.add(f["company"])});

    return companyChsone;
  }

  static Future getHRMSCompanies() async {
    print('HRMSCompanies');
    List appacess = await SsoStorage.getAppAccess() as List;
    var chsoneAccess = appacess.where(
            (x) =>
        x["app_id"].toString() == Environment()
            .getCurrentConfig()
            .hrmsAppId);
    var companyChsone = [];
    chsoneAccess.toList().forEach((f) => {companyChsone.add(f)});
    return companyChsone;
  }

  static getVizlogCompanies() async {
    List appacess = await SsoStorage.getAppAccess() as List;
    var chsoneAccess = appacess.where(
            (x) =>
        x["app_id"] == Environment()
            .getCurrentConfig()
            .vizlogAppId);
    var companyChsone = [];
    chsoneAccess.toList().forEach((f) => {companyChsone.add(f["company"])});
    return companyChsone;
  }

  /*var getChsoneCompanies

  (){

  }*/

  static Future<void> hasChsoneAccess(comapny) async {
    // var a = await SsoStorage.getAppAccess();
    for (var app in comapny) {
      if (app["aap_id"] == 2) {
        for (var com in comapny["companies"]) {
          if (com["company_id"] == comapny["id"]) {}
        }
      }
    }
  }

  static void hasVizlogAccess(comAppAcces) {}

  static Future<dynamic> getCurrentUnits({String app}) async {
    String a;
    if (app == AppConstant.VIZLOG) {
      a = await SsoStorage.getDefaultVizlogUnit();
      print("getCurrentUnits-----------------------");
      print(a);
    } else {
      a = await SsoStorage.getDefaultChsoneUnit();
    }

    var currentUnit;
    if (a != null) {
      currentUnit = jsonDecode(a);
    }
    return Future.value(currentUnit);
  }

  static String getFullName(member_first_name, member_last_name) {
    if (member_first_name == null) {
      member_first_name = "";
    }
    if (member_last_name == null) {
      member_last_name = "";
    }
    return (member_first_name.toString() + " " + member_last_name.toString())
        .trim();
  }
}
