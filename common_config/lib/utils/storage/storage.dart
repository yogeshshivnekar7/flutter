/*import 'package:shared_preferences/shared_preferences.dart';*/

import 'package:common_config/utils/application.dart';

import 'android_ios_storage.dart';
import 'web_storage.dart';

class LocalStorage {
  static IStorage _iStorage;

  static IStorage getStorage() {
    try {
      var android = FsPlatform
          .isAndroid(); // Platform.isAndroid != null && Platform.isAndroid;
      var iOS = FsPlatform.isIos();
      if (android || iOS) {
        _iStorage = new AndroidIosStorage();
      } else {
        _iStorage = new WebStorage() as IStorage;
      }
    } catch (e) {
      // print("eeee");
      print(e);
      _iStorage = new WebStorage() as IStorage;
    }
    // print("ssss");
    return _iStorage;
  }

  Future<void> setItem(String key, String value) async {
    _iStorage.setItem(key, value);
  }

  Future<String> getItem(String key) async {
    return _iStorage.getItem(key);
  }
}
