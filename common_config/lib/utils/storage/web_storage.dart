/*static final LocalStorage _localStorage = new LocalStorage("sdsd");*/

import 'package:common_config/utils/storage/android_ios_storage.dart';
import 'package:localstorage/localstorage.dart';

class WebStorage extends IStorage {
  LocalStorage _localStorage = new LocalStorage("storage_r");

  Future<void> setItem(String key, String value) async {
    _localStorage.setItem(key, value);
  }

  Future<String> getItem(String key) async {
    String item = _localStorage.getItem(key);
    return Future.delayed(Duration(microseconds: 10), () => item);
  }

  @override
  Future<void> clearAll() async {
    _localStorage.clear();
  }
}
