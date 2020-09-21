import 'dart:convert';

import 'package:sso_futurescape/utils/storage/sso_storage.dart';

/*class TempProfileResponse {
  static dynamic getProfileResponse() {
    return {
      "app": {"version": "v1", "name": "CHSONE Auth"},
      "status_code": 200,
      "data": {
        "user_id": 2,
        "username": "918149229032",
        "email": "demo@gmail.com",
        "email_verified": 0,
        "first_name": "Demo",
        "last_name": "Bcbcncng",
        "salutation": null,
        "gender": "M",
        "mobile": "919898898998",
        "mobile_verified": 0,
        "dob": "2017-07-06",
        "address_line_1": "Demo",
        "address_line_2": "Bcbcncng",
        "zip_code": "441103",
        "city": "Nagpur",
        "state": "Andhra Pradesh",
        "country": "India",
        "address_verified": 0,
        "profile_visiblity": "private",
        "created_at": "2018-12-07 10:44:55",
        "updated_at": "2019-11-13 12:27:29",
        "avatar": null,
        "com_app_access": [
          {
            "apps": [
              {
                "app_id": 2,
                "app_name": "Society App",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 2,
            "company_name": "New Jawahar Housing Society",
            "address_line_1": null,
            "address_line_2": null,
            "country": "India",
            "state": "Maharashtra",
            "zip_code": "45465"
          },
          {
            "apps": [
              {
                "app_id": 2,
                "app_name": "Society App",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 102,
            "company_name": "Om Sai",
            "address_line_1": null,
            "address_line_2": null,
            "country": "India",
            "state": "Maharashtra",
            "zip_code": null
          },
          {
            "apps": [
              {
                "app_id": 2,
                "app_name": "Society App",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              },
              {
                "app_id": 5,
                "app_name": "Vizlog",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 101,
            "company_name": "Akash ",
            "address_line_1": null,
            "address_line_2": null,
            "country": "India",
            "state": "Maharashtra",
            "zip_code": null
          },
          {
            "apps": [
              {
                "app_id": 5,
                "app_name": "Vizlog",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 1094,
            "company_name": "FS stage vizlog",
            "address_line_1": "vashi sector 30 A 1905 cyber one",
            "address_line_2": null,
            "country": "India",
            "state": "Maharashtra",
            "zip_code": "400605"
          },
          {
            "apps": [
              {
                "app_id": 1,
                "app_name": "CHSONE Auth",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              },
              {
                "app_id": 3,
                "app_name": "FS Admin",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              },
              {
                "app_id": 5,
                "app_name": "Vizlog",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              },
              {
                "app_id": 2,
                "app_name": "Society App",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              },
              {
                "app_id": 8,
                "app_name": "FS Dashboard",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 1,
            "company_name": "CHSONE Pvt Ltd",
            "address_line_1": null,
            "address_line_2": null,
            "country": null,
            "state": null,
            "zip_code": null
          },
          {
            "apps": [
              {
                "app_id": 2,
                "app_name": "Society App",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 65,
            "company_name": "Root Complex",
            "address_line_1": "test address",
            "address_line_2": null,
            "country": null,
            "state": null,
            "zip_code": null
          },
          {
            "apps": [
              {
                "app_id": 2,
                "app_name": "Society App",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              },
              {
                "app_id": 5,
                "app_name": "Vizlog",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 1103,
            "company_name": "Phoenix  Complex",
            "address_line_1": "Vashi plaza",
            "address_line_2": "",
            "country": "India",
            "state": "Maharashtra",
            "zip_code": "400200"
          },
          {
            "apps": [
              {
                "app_id": 2,
                "app_name": "Society App",
                "api_version": null,
                "api_end_point": null,
                "ui_end_point": null
              }
            ],
            "company_id": 1137,
            "company_name": "MBP Complex",
            "address_line_1": "vashi",
            "address_line_2": "navi mumbai",
            "country": "India",
            "state": "Maharashtra",
            "zip_code": "400521"
          }
        ],
        "app_access": [
          {
            "app_id": 2,
            "app_name": "Society App",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 2,
              "company_name": "New Jawahar Housing Society",
              "address_line_1": null,
              "address_line_2": null,
              "country": "India",
              "state": "Maharashtra",
              "zip_code": "45465"
            },
            "api_keys": {
              "web": {
                "api_key":
                    "f8da3daf041d941b196f2d6fa7e8abebd7c4d4e2c43634ba8e8a5b5a3c35ea03",
                "expiry": "2030-10-23 00:00:00",
                "is_expired": 0
              },
              "android": {"api_key": null, "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 2,
            "app_name": "Society App",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 102,
              "company_name": "Om Sai",
              "address_line_1": null,
              "address_line_2": null,
              "country": "India",
              "state": "Maharashtra",
              "zip_code": null
            },
            "api_keys": {
              "web": {
                "api_key":
                    "f8da3daf041d941b196f2d6fa7e8abebd7c4d4e5c43634ba8e8a5b593c35ea96",
                "expiry": "2030-10-23 00:00:00",
                "is_expired": 0
              },
              "android": {"api_key": null, "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 2,
            "app_name": "Society App",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 101,
              "company_name": "Akash ",
              "address_line_1": null,
              "address_line_2": null,
              "country": "India",
              "state": "Maharashtra",
              "zip_code": null
            },
            "api_keys": {
              "web": {
                "api_key":
                    "f8da3daf041d941b196f2d6fa7e8abebd7c4d4e2c43634ba8e8a5b5a3c35ea96",
                "expiry": "2030-10-23 00:00:00",
                "is_expired": 0
              },
              "android": {"api_key": null, "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 5,
            "app_name": "Vizlog",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 1094,
              "company_name": "FS stage vizlog",
              "address_line_1": "vashi sector 30 A 1905 cyber one",
              "address_line_2": null,
              "country": "India",
              "state": "Maharashtra",
              "zip_code": "400605"
            },
            "api_keys": {
              "web": {
                "api_key":
                    "139d6d486e64668cc8fba69b6cd8d4f97a87c49b85d324b595145c7b57faf3c5",
                "expiry": "2030-10-23 00:00:00",
                "is_expired": 0
              },
              "android": {
                "api_key":
                    "19897c6f36cb6a9f884250923e189fdbc063c5327536bbd4a1eb9ad1a747d825",
                "expiry": "2030-10-23 00:00:00",
                "is_expired": 0
              },
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 5,
            "app_name": "Vizlog",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 101,
              "company_name": "Akash ",
              "address_line_1": null,
              "address_line_2": null,
              "country": "India",
              "state": "Maharashtra",
              "zip_code": null
            },
            "api_keys": {
              "web": {
                "api_key":
                    "f8da3daf041d941b196f2d6fa7e8abebd7c4d4e2c43634ba8e8d5b5a3c35ea96",
                "expiry": "2030-10-23 00:00:00",
                "is_expired": 0
              },
              "android": {"api_key": null, "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 2,
            "app_name": "Society App",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 1,
              "company_name": "CHSONE Pvt Ltd",
              "address_line_1": null,
              "address_line_2": null,
              "country": null,
              "state": null,
              "zip_code": null
            },
            "api_keys": {
              "web": {
                "api_key": "rCIIolAYyNrbWSD4WSlt6SPLxGq036U3s3pSZhgbkayGeacuMg",
                "expiry": "2022-08-22 11:29:46",
                "is_expired": 0
              },
              "android": {"api_key": null, "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 2,
            "app_name": "Society App",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 65,
              "company_name": "Root Complex",
              "address_line_1": "test address",
              "address_line_2": null,
              "country": null,
              "state": null,
              "zip_code": null
            },
            "api_keys": {
              "web": {
                "api_key":
                    "a1da3daf041d941b196f2d6fa7e8abebd7c4d4e2c87964ba8e8a5b5a3c35e6t2",
                "expiry": "2030-10-23 00:00:00",
                "is_expired": 0
              },
              "android": {"api_key": "", "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 2,
            "app_name": "Society App",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 1103,
              "company_name": "Phoenix  Complex",
              "address_line_1": "Vashi plaza",
              "address_line_2": "",
              "country": "India",
              "state": "Maharashtra",
              "zip_code": "400200"
            },
            "api_keys": {
              "web": {
                "api_key": "7SPk3gCK25hXCDnytxl9qHZMpfsf5tzPUzZSMQvUZsaXdKFve0",
                "expiry": "2022-07-29 11:47:28",
                "is_expired": 0
              },
              "android": {"api_key": null, "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          },
          {
            "app_id": 2,
            "app_name": "Society App",
            "product_code": null,
            "api_version": null,
            "is_premium": null,
            "is_preferred": null,
            "role": null,
            "status": "active",
            "company": {
              "company_id": 1137,
              "company_name": "MBP Complex",
              "address_line_1": "vashi",
              "address_line_2": "navi mumbai",
              "country": "India",
              "state": "Maharashtra",
              "zip_code": "400521"
            },
            "api_keys": {
              "web": {
                "api_key": "rLKqM6oKYNxYsql8Ob4kxnpUthJNPSBh0iGUQT0quyHaXo3mqb",
                "expiry": "2022-10-03 06:08:55",
                "is_expired": 0
              },
              "android": {"api_key": null, "expiry": null, "is_expired": 1},
              "ios": {"api_key": null, "expiry": null, "is_expired": 1}
            },
            "is_setup": 0,
            "api_end_point": null,
            "ui_end_point": null
          }
        ],
        "session_token":
            "JDJ5JDEwJDJmdnFYakxsVjQzY2hkV29kTlU3SXUvdWtZeC5TbVpjM2g3SlE0bS5sU3NKMlNtTTRkME02",
        "avatar_large": null,
        "avatar_medium": null,
        "avatar_small": null,
        "companies": [],
        "addresses": [],
        "social_profiles": []
      }
    };
  }

  static void getComapies() {
    var profile = getProfileResponse()["data"];
    var sessionToken = profile["session_token"];
    var appAccess = profile["app_access"];
    List comAppAccess = profile["com_app_access"];

    print("______________________");
    */ /* print(appAccess);*/ /*

    UserComapnyUtils.saveCompanyAccess(comAppAccess);
    print("______________________");
    UserComapnyUtils.saveAppAccess(appAccess);
    print("__________ssss____________");
    UserComapnyUtils.hasChsoneAccess(comAppAccess[0]);
    print("__________ssss____________");
    print("______________________");
    UserComapnyUtils.hasVizlogAccess(comAppAccess[0]);
  }
}*/

class UserComapnyUtils {
  static void saveCompanyAccess(List comAppAccess) {
    SsoStorage.saveCompanyAccess(comAppAccess);
  }

  static void saveAppAccess(appAccess) {
    SsoStorage.saveAppAccess(appAccess);
  }

  static Future<void> hasChsoneAccess(comapny) async {
    var a = await SsoStorage.getAppAccess();
    for (var app in comapny) {
      if (app["aap_id"] == 2) {
        for (var com in comapny["companies"]) {
          if (com["company_id"] == comapny["id"]) {}
        }
      }
    }
    print(a);
  }

  static void hasVizlogAccess(comAppAcces) {}
}

class Company {
  int companyId;
  String companyName;
  String addressLine1;
  String addressLine2;
  String country;
  String state;
  String zipCode;

  Company({
    this.companyId,
    this.companyName,
    this.addressLine1,
    this.addressLine2,
    this.country,
    this.state,
    this.zipCode,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        companyId: json["company_id"],
        companyName: json["company_name"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        country: json["country"],
        state: json["state"],
        zipCode: json["zip_code"]);
  }

  @override
  Map toJson() {
    var a = {
      "company_id": companyId,
      "company_name": companyName,
      "address_line_1": addressLine1,
      "address_line_2": addressLine2,
      "country": country,
      "state": state,
      "zip_code": zipCode
    };
    return a;
  }

  static String encondeToJson(List<Company> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return json.encode(jsonList);
  }
}

class App {
  int appId;

  String appName;

  String productCode;

  String apiVersion;

  String isPremium;

  String isPreferred;

  String role;

  String status;

  int isSetup;

  String apiEndPoint;

  String uiEndPoint;

  App({
    this.appId,
    this.appName,
    this.productCode,
    this.apiVersion,
    this.isPremium,
    this.isPreferred,
    this.role,
    this.status,
    this.isSetup,
    this.apiEndPoint,
    this.uiEndPoint,
  });

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
        appId: json["app_id"],
        appName: json["app_name"],
        productCode: json["product_code"],
        apiVersion: json["api_version"],
        isPremium: json["is_premium"],
        isPreferred: json["is_preferred"],
        role: json["role"],
        status: json["status"],
        isSetup: json["is_setup"],
        apiEndPoint: json["api_end_point"],
        uiEndPoint: json["ui_end_point"]);
  }
}
