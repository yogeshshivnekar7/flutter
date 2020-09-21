import 'package:shared_preferences/shared_preferences.dart';

class AndroidIosStorage extends IStorage {
  Future<void> setItem(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var string = prefs.getString(key);
    return string;
  }

  @override
  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

abstract class IStorage {
  Future<void> setItem(String key, String value);
  Future<String> getItem(String key);

  void clearAll();
}
