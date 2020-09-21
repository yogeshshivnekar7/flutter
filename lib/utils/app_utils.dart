import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/formater.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static const String DATE_FORM_DD_MMM_YYYY = "dd MMM yyyy";
  static const String TIME_FORM_HH_MM_A = "hh:mm a";
  static const String TIME_FORM_HH_MM_SS = "HH:mm:SS";
  static const String TIME_FORM_HH_MM = "HH:mm";
  static const String DATE_FORM_DD_MM_YYYY_1 = "dd/MM/yyyy";
  static const String DATE_FORM_DD_MM_YYYY_2 = "dd-MM-yyyy";
  static const String DATE_FORM_YYYY_MM_DD_1 = "yyyy/MM/dd";
  static const String DATE_FORM_YYYY_MM_DD_2 = "yyyy-MM-dd";



  /*static Future<void> _launchUrlWithUrl(String url) async {
    try {
      print(url);
      if (await canLaunch(url)) {
        await launch(url);
      } else {}
    } catch (e) {
      print(e);
    }
  }*/
  static String errorDecoder(var mapError) {
    print(mapError);
//    final Map<String, dynamic> mapError = jsonDecode(error);
    try {
      if (mapError["status_code"] == 422) {
        String response = "";
        var error = mapError["errors"];
        if (error == null) {
          error = mapError["error"];
        }
        if (error != null) {
          try {
            Map errors = error;
            print(errors);
            for (var k in errors.keys) {
              print(k);
              for (var x in errors[k]) {
                print(x);
                response = response + " " + x.toString() + "\n";
              }
            }
          } catch (e) {
            response = response + " " + error.toString() + "\n";
          }
        }

        return response;
      } else {
        /* print("RESOPNIOSE - " + mapError["error"]);*/
        return mapError["error"].toString();
      }
    } catch (e) {
      return mapError.toString();
    }
  }

  static String capitalize(String s, {bool requiredNextAllLowerCase = false}) {
    var substring = s.substring(1);
    if (requiredNextAllLowerCase) {
      substring.toLowerCase();
    }
    String object = '${s[0].toUpperCase()}${substring}';
    //print(object);
    return object;
  }

  static String mergeAddress(dynamic complex) {
    String address = "";
    /*if (complex["address_line_1"] != null) {
      address = complex["address_line_1"];
    }
    if (complex["address_line_2"] != null) {
      if (address
          .trim()
          .length > 0) {
        address = address + ", ";
      }
      address = address + complex["address_line_2"];
    }
    if (complex["zip_code"] != null) {
      if (address
          .trim()
          .length > 0) {
        address = address + ", ";
      }
      address = address + complex["zip_code"];
    }*/
    if (complex["city"] != null) {
      address = complex["city"];
    }
    /* if (complex["state"] != null) {
      address = address + ", " + complex["state"];
    }
    if (complex["country"] != null) {
      address = address + ", " + complex["country"];
    }*/
    return address;
  }

  static String mergeAddress12(var complex) {
    String address = "";
    print(complex["address_line_1"]);
    print(complex["address_line_2"]);
    if (complex["address_line_1"] != null) {
      address = complex["address_line_1"];
    }
    if (complex["address_line_2"] != null) {
      if (address
          .trim()
          .length > 0) {
        address = address + ", ";
      }
      address = address + complex["address_line_2"];
    }
    return address;
  }

  static int getCurrentCurrency() {
    return 0xf156;
  }

  static setCurrentCurrency() {}

  /*soc_id	65
role	"admin,member"
soc_name	"Root Complex"
soc_address_1	"test address"
soc_address_2	" "
soc_landmark	" gandhi nagar"
soc_city_or_town	"Vashi"
soc_state	"Maharashtra"
soc_pincode	*/

  static mergeAddressSSO(complex) {
    String address = "";
    /* if (!AppUtils.isBlankORNull(complex["soc_address_1"])) {
      address = complex["soc_address_1"];
    }
    if (AppUtils.isBlankORNull(complex["soc_address_2"])) {
      if (address.trim().length > 0) {
        address = address + ", ";
      }
      address = address + complex["soc_address_2"];
    }
    if (AppUtils.isBlankORNull(complex["soc_landmark"])) {
      address = address + ", " + complex["soc_landmark"];
    }*/
    print(complex["soc_city_or_town"]);
    if (!AppUtils.isBlankORNull(complex["soc_city_or_town"])) {
      address = complex["soc_city_or_town"];
    }
    /*if (AppUtils.isBlankORNull(complex["soc_state"])) {
      address = address + ", " + complex["soc_state"];
    }
    if (AppUtils.isBlankORNull(complex["soc_pincode"])) {
      address = address + ", " + complex["soc_pincode"].toString();
    }*/
    return address;
  }

  static bool isBlankORNull(complex) {
    return complex == null
        ? true
        : complex.toString().trim() == "" ? true : false;
  }

  static String getTimeStamp() {
    return new DateFormat("yyyy-MM-dd HH:mm:ss").format(new DateTime.now());
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  static String getCurrentDate({String date_format}) {
    String format =
        new DateFormat(date_format == null ? "yyyy-MM-dd" : date_format)
            .format(new DateTime.now());
    print("date -- $format");
    return format;
  }

  static String getCurrentHour() {
    String format =
        new DateFormat("yyyy-MM-dd HH:mm:ss").format(new DateTime.now());
    print("date -- $format");
    var now = new DateTime.now();
    return now.hour.toString();
//    return format;
  }

  static String getConvertDate(String date_time,
      {String date_from_format, String date_to_formate}) {
    DateFormat dateFormat = DateFormat(
        date_from_format == null ? "yyyy-MM-dd HH:mm:ss" : date_from_format);
    DateTime dateTime = dateFormat.parse(date_time);
    String format =
    new DateFormat(date_to_formate == null ? "yyyy-MM-dd" : date_to_formate)
        .format(dateTime);
    print("date -- $format");
    return format;
  }

  static String generatePassData(var profileView) {
    String name = profileView["first_name"] != null
        ? profileView["first_name"].toString()
        : "";
    String lastName = profileView["last_name"] != null
        ? profileView["last_name"].toString()
        : "";
    String gender =
        profileView["gender"] != null ? profileView["gender"].toString() : "";
    String mobile =
        profileView["mobile"] != null ? profileView["mobile"].toString() : "";
    String city =
        profileView["city"] != null ? profileView["city"].toString() : "";
    String zipcode = profileView["zip_code"] != null
        ? profileView["zip_code"].toString()
        : "";

//    var lastName = profileView["last_name"];
//    print(lastName);
//    var gender = profileView["gender"];
//    print(gender);
//    var mobileNo = profileView["mobile"];
//    print(mobileNo);
    print(mergeAddress12(profileView));
//    var city = profileView["city"];
//    var zipcode = profileView["zip_code"];
    return "[0" +
        ",0" +
        ",0" +
        ",\"" +
        name +
        "\",\"" +
        lastName +
        "\",\"" +
        gender +
        "\",\"" +
        mobile +
        "\",\"" +
        "\",\"" +
        "\",\"" +
        "\",\"" +
        "\",\"" +
        "\",\"" +
        mergeAddress12(profileView) +
        "\",\"" +
        city +
        "\",\"" +
        "\",\"" +
        "\",\"" +
        zipcode +
        "\"," +
        ",\"" +
        "\"]";
  }

  static String encrypt(String data) {
    print("plane text --  $data");
    Key key = Key.fromUtf8('rahultoSecretKey');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
    return encrypter
        .encrypt(data, iv: iv)
        .base64;

//      String dc = encrypter.decrypt16(da,iv: iv);
//      print(encrypter.encrypt(s,iv: iv).base64);
//      print(encrypter.decrypt64(da));
  }

  static HashMap<Name, String> splitFullName(String fullName) {
    HashMap<Name, String> name = new HashMap();
//    first_name = "";
//    last_name = "";
//    fullName = fullNameController.text;
    List<String> splitString = fullName.split(" ");
    int size = splitString.length;
    if (size > 1) {
      String lastName = "";
      for (int i = 0; i < size; i++) {
        if (i == 0) {
          print("first_name" + splitString[i]);
          name[Name.FIRST_NAME] = splitString[i];
        } else {
          if (lastName.length > 0) {
            lastName = lastName + " ";
          }
          lastName = lastName + splitString[i];
          print("last_name" + lastName);
        }
      }
      name[Name.LAST_NAME] = lastName;
    } else if (size == 1) {
//      first_name = fullNameController.text;
//      lastName = "";
      name[Name.FIRST_NAME] = fullName;
      name[Name.LAST_NAME] = "";
    }
    return name;
  }

  static mergeAddressSSOVizlog(var complex) {
    print(complex["city"]);
    String address;
    if (!AppUtils.isBlankORNull(complex["city"])) {
      address = complex["city"];
    }
    return address;
    /* "company_id": 29,
                "complex_name": "M Nexzone",
                "address_line_1": "Vashi",
                "address_line_2": "Navi mumbai",
                "near_landmark": null,
                "pincode": "400705",
                "city": "Navi mumbai",
                "state": null,
                "country": null*/
  }

  static String getDeviceCode() {
    var code = "android";
    try {
      if (Platform == null) {
        code = "web";
      } else if (Platform.isIOS != null && Platform.isIOS) {
        code = "ios";
      } else if (Platform.isAndroid != null && Platform.isAndroid) {
        code = "android";
      }
    } catch (e) {
      code = "web";
    }
    return code;
  }

  static String getTime(String time) {
    print("---------------------------time----------------------- $time");

    if (time != null) {
      DateFormat display = new DateFormat("hh:mm a");
      return display.format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(time));
    } else {
      return "";
    }
  }

  static String getTimeDiff(String inTime, String outTime) {
    print("start date - $inTime+----------------out time --------$outTime");

    try {
      if (inTime == null || inTime.length <= 0) {
//        print("-------------------------------------------------------------------------innull-----------");
        return "";
      }
      if (outTime == null || outTime.length <= 0) {
        return "still in";
      } else {
        DateTime inDateTime = AppConstant.dateFormat.parse(inTime);
        DateTime outDateTime = AppConstant.dateFormat.parse(outTime);
        Duration d = outDateTime.difference(inDateTime);
        return timeConvert(d.inMinutes);
      }
      /*if (inTime != null && inTime.length > 0 && outTime != null &&
          outTime.length > 0) {
        print(
            "--------------timessssssssss difference-------------------------");
        DateTime outDateTime = AppConstant.dateFormat.parse(outTime);
        Duration d = outDateTime.difference(inDateTime);
        return timeConvert(d.inMinutes);
      } else if (outTime == null || outTime.length <= 0) {
        print(
            "--------------timessssssssss stillstillstillstill diffsssssssssssssserence-------------------------");
        return "still in";
      }else{
        print(
            "--------------timessssssssss diffsssssssssssssserence-------------------------");
        return "";
      }*/
    } catch (e) {
      return "";
    }
  }

  static String timeConvert(int time) {
    double d = time / 24 / 60;
    String days = "";
    if (d > 1) {
      days = d.toInt().toString() + " days ";
    }
    double hrs = (time / 60 % 24);
    String hr = "";
    if (hrs.toInt() > 1) {
      hr = hrs.toInt().toString() + " hrs ";
    } else if (hrs.toInt() == 1) {
      hr = hrs.toInt().toString() + " hr ";
    } else {
      hr = "0 hr ";
    }
//    =hrs.toString()+" hrs";
    return days + hr + (time % 60).toString() + " min";
  }

  static RegExInputFormatter getAmountFormatter() {
    return RegExInputFormatter.withRegex(
        '^\$|^(([1-9][0-9]{0,6}))(\\.[0-9]{0,2})?\$');
  }

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  static String reverseString(String value, String separator) {
    var input = value;
    return input.split(separator).reversed.join();
  }

  static String changeDateFormat(
      String date, String fromFormat, String toFormat) {
    String dateInString;
    if (date == "0000-00-00") {
      return null;
    }
    try {
      DateFormat inputFormat = DateFormat(fromFormat);
      DateTime dateTime = inputFormat.parse(date);
      DateFormat outputFormat = DateFormat(toFormat);
      dateInString = outputFormat.format(dateTime);
      print("formatter" + dateInString);
    } catch (e) {
      dateInString = "";
      print("in side Exception");
      print(e.toString());
    }
    print("formatted ${date} to ${dateInString} using ${toFormat}");
    return dateInString;
  }

  static String doubleFormat(var n) {
    try {
      if (double.tryParse(n.toString()) != null) {
      } else {
        print(n);
        n = 0.0;
      }
      return n.toStringAsFixed(2);
    } catch (e) {
      print(e);
      print(n);
    }
  }

  static showComminigSoonToast(context) {
    Toasly.warning(context, "Coming soon");
  }

  static Future<bool> checkInternetConnection() async {
    if (Environment().getCurrentConfig().geCurrentPlatForm() ==
        FsPlatforms.WEB) {
      return Future.value(true);
    }
    bool isAvavailble = false;
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.none) {
      print("Internet Connection NONE");
      isAvavailble = false;
    } else if (result == ConnectivityResult.mobile) {
      print("Internet Connection mobile");
      isAvavailble = true;
    } else if (result == ConnectivityResult.wifi) {
      print("Internet Connection wifi");
      isAvavailble = true;
    }
    return Future.value(isAvavailble);
    /*String _connectionStatus = 'Unknown';
    final Connectivity _connectivity = Connectivity();
    StreamSubscription<ConnectivityResult> _connectivitySubscription =_connectivity.onConnectivityChanged.listen(_updateConnectionStatus);*/

    /*try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        return true;
      } else {
        print('Internet Not connected');
        return false;
      }
    } on SocketException catch (_) {
      print('Internet not connected');
    }*/
  }

  static Future<void> launchUrlWithUrl(String url) async {
    try {
      print(url);
      if (await AppUtils.canLaunchUrl(url)) {
        await AppUtils.launchUrl(url);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> canLaunchUrl(String url) async {
    //return true;
    return await canLaunch(url);
  }

  static int getDateDiffOfYears(String dob1) {
    DateTime dob = DateTime.parse(dob1);
    Duration dur = DateTime.now().difference(dob);
    int differenceInYears = (dur.inDays / 365).floor();
    print(differenceInYears);
    return differenceInYears;
  }

  static Future<String> callIntent(String number) async {
    if (number != null && number.length > 0) {
      String url = "tel:${number.trim()}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        return "calling not supported";
//        Toasly.error(context, 'calling not supported.');
      }
    } else {
      return "Could not launch $number";
//      Toasly.error(context, 'Could not launch $number');
    }
  }

  static downloadFile(String url) async {
//    if (Environment().getCurrentConfig().geCurrentPlatForm() ==
//        FsPlatforms.ANDROID) {
//      DownloadUtils downloadUtils = await DownloadUtils.getDownloadInstance();
//      downloadUtils.startDownload(url);
//    } else {
//    }
    launchUrlWithUrl(url);
  }

  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } catch (e) {
      print('Failed to get platform version');
      return ["web", "web", "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"];
    }
    return [deviceName, deviceVersion, identifier];
  }

  static String getDateTime(String time,
      {String requiredFormat, String sourceFormat}) {
    print("---------------------------time----------------------- $time");

    if (time != null) {
      String dateFormat = "yyyy-MM-dd HH:mm:ss";
      if (requiredFormat != null && requiredFormat.length > 0) {
        dateFormat = requiredFormat;
      }
      DateFormat display;
      try {
        display = new DateFormat(dateFormat);
      } catch (e) {
        display = new DateFormat("yyyy-MM-dd HH:mm:ss");
      }

//      String sourceFormat="dd-MM-yyyy hh:mm a";
      if (sourceFormat == null || sourceFormat.length <= 0) {
        sourceFormat = "dd-MM-yyyy HH:mm:ss";
      }

      var sdfFormat;
      try {
        sdfFormat = DateFormat(sourceFormat);
      } catch (e) {
        sdfFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      }

      return display.format(sdfFormat.parse(time));
    } else {
      return "";
    }
  }

  static Future<void> openAppStore() async {
    var platForm = Environment().getCurrentConfig().geCurrentPlatForm();
    var url;
    if (platForm == FsPlatforms.IOS) {
      url = 'https://apps.apple.com/in/app/cube-one-app/id1492930711';
    } else {
      url = 'https://play.google.com/store/apps/details?id=com.cubeone.app';
    }
    AppUtils.launchUrlWithUrl(url);
    /*if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }*/
  }

  static String getCompanyImage(Map place) {
    print("company_code");
    print(place["company_code"]);
    if (place == null || place['company_code'] == null) {
      return null;
    } else {
      String code = place['company_code'];
      return Environment()
          .getCurrentConfig()
          .tiffin_image_logo +
          '/$code/images/logo.png';
    }
  }

  static String getDefultImage(businessAppMode) {
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      return "images/default_restaurant.png";
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      return "images/default_tiffin.png";
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      /*_restaurantPresenter.getGrocery();*/
      return "images/default_grocery.png";
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      return "images/default_grocery.png";
    } else {
      return "images/default_grocery.png";
    }
  }

  static String getDetails(String key, var place) {
    String result = "";
    List details = place["details"];

    if (details != null && details.length > 0) {
      for (int i = 0; i < details.length; i++) {
        if (key == details[i]["company_key"]) {
          return details[i]["company_value"];
        }
      }
    }
    return result;
  }

  static bool getViewMenuOrderOnlineStatus(Map place, var address,
      {isCheckInRangeOrNot = true}) {
    print("getViewMenuOrderOnlineStatus");
    print(place);
    print(place["in_range"]);
    bool enable = true;
    if (isCheckInRangeOrNot) {
      bool enable =
      (place["in_range"] != null && place["in_range"].toString() == "1")
          ? true
          : false;
      print("getViewMenuOrderOnlineStatus ------------enable ---  $enable");
      if (!enable) return false;
    }
    if (place["is_wizard_setup"] == null ||
        place["is_wizard_setup"].toString() == 'no') {
      print(false);
      return false;
    }
    if (place['online_ordering_enabled'].toString() != null &&
        place['online_ordering_enabled'] == 'yes' &&
        enable) {
      print(true);
      return true;
    } else {
      if (place['LISTING_VIEWMENU_ENABLED'].toString() != null &&
          place['LISTING_VIEWMENU_ENABLED'] == 'yes' &&
          enable) {
        print(true);

        return true;
      } else {
        print(false);
        return false;
      }
    }
  }

  static String getFullName(var profileView) {
    String name = profileView["first_name"] != null
        ? profileView["first_name"].toString()
        : "";
    String lastName = profileView["last_name"] != null
        ? profileView["last_name"].toString()
        : "";
    if (lastName != null && lastName.length > 0) {
      return name + " " + lastName;
    } else {
      return name;
    }
  }

  static bool isDeliveryOpionAvaile(Map place, String key) {
    var valueFromKey = AppUtils.getValueFromKey("delivery_type", place);
    if (valueFromKey != null) {
      var a =
      valueFromKey.where((element) => element.toString() == key).toList();
      print(a);
      return a != null && a.length > 0;
    } else {
      return false;
    }
  }

  static List getCallNumber(Map place) {
    print(place['details']);
    if (place == null || place['details'] == null) {
      return null;
    } else {
      List list = place['details'];
      print(list);
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'] == 'SUPPORT_CONTACT_NO' ||
              list[i]['company_key'] == 'support_no') {
            var split = list[i]['company_value']
                .toString()
                .split(',')
                .where((element) =>
            element.toString() != null &&
                element
                    .toString()
                    .trim()
                    .isNotEmpty)
                .toList();
            print(split);
            if (split == null || split.length == 0) {
              return null;
            }
            try {
              print(split[1].trim());
              List list1 = new List();
              list1.add(split[1]);
              return list1;
            } catch (e) {
              return split;
            }
          }
        }
      } else {
        return null;
      }
    }
  }

  static List getValueFromKey(String key, Map place) {
    print(place['details']);
    if (place == null || place['details'] == null) {
      return null;
    } else {
      List list = place['details'];
      print(list);
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'].toString().toUpperCase() ==
              key.toUpperCase()) {
            var split = list[i]['company_value'].toString().split(',');
            return split.length > 0 ? split : null;
          }
        }
      } else {
        return null;
      }
    }
  }

  static String convertStringToDouble(String strAmount) {
    try {
      double.tryParse(strAmount);

      if (strAmount != null) {
        return double.parse(strAmount).toString();
      }
    } catch (e) {
      return "0";
    }
    return "0";
  }

  static launchUrl(String url, {bool forceSafariVC}) {
    launch(url, forceSafariVC: forceSafariVC);
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    lat1 = double.parse(lat1.toString());
    lat2 = double.parse(lat2.toString());
    lon1 = double.parse(lon1.toString());
    lon2 = double.parse(lon2.toString());
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}

enum Name { FIRST_NAME, LAST_NAME }
