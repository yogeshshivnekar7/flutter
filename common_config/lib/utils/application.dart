import 'dart:io';

class ApplicationUtil {
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
}

class FsPlatform {
  static bool isAndroid() {
    try {
      if (Platform == null || Platform.isAndroid == null) {
        return false;
      }
      return Platform.isAndroid;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static bool isIos() {
    try {
      if (Platform == null || Platform.isIOS == null) {
        return false;
      }
      return Platform.isIOS;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static bool isWeb() {
    try {
      if (Platform == null ||
          (Platform.isIOS == null && Platform.isAndroid == null)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return true;
    }
  }

  static printPlatFormInfo() {
    print("Android");
    print("Android");
  }

  static FsPlatforms getPlatform() {
    return isAndroid()
        ? FsPlatforms.ANDROID
        : isIos() ? FsPlatforms.IOS : FsPlatforms.WEB;
  }
}

enum FsPlatforms { ANDROID, IOS, WEB }
