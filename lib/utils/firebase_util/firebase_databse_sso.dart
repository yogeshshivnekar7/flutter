import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/firebase/firebase_util.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class FirebaseDatabaseSSO {
  static Future<void> loginUserStore(data) {
    try {
      final notesReference = FirebaseDatabaseUtils.getInstanceId();
      // print(data);
      //print("ddeeeeeeeeee");
      //String s = "Hello, world! i am 'foo'";
      String userName =
      data["username"].replaceAll(new RegExp(r'[^\w\s]+'), '');
      //print(userName);
      var dataLogin = notesReference.child("login").child(userName);
      return dataLogin.set(data);
    } catch (e) {
      print(e);
    }
    return Future.value(1);
  }

  static Future<void> saveIntrest(dynamic data) async {
    //`
    //
    // var profile = await SsoStorage.getUserProfile(); //.then((profile) {
    final notesReference = FirebaseDatabaseUtils.getInstanceId();
    String userId = await SsoStorage.getUserId();
    return notesReference.child("intrest").child(userId).set(data);
    /* });*/
  }

  static Future<dynamic> getIntrest() async {
    try {
      var platForm = Environment().getCurrentConfig().geCurrentPlatForm();
      if (platForm == FsPlatforms.IOS || platForm == FsPlatforms.ANDROID) {
        var userId = await SsoStorage.getUserId();
        print("rrrrgghg");
        print(userId);
        //.then((profile) {
        // var userId = profile["user_id"].toString();
        return await FirebaseDatabaseUtils.getValues(userId);
      } else {
        return Future.value(null);
      }
    } catch (e) {
      print(e);
      print("gggggggg");
    }
  }

  static Future<dynamic> getUpdateAvailbleVersions() async {
    var platForm = Environment().getCurrentConfig().geCurrentPlatForm();
    if (platForm == FsPlatforms.WEB) {
      return Future.value(null);
    }
    return await FirebaseDatabaseUtils.getUpdates(platForm);
  }
}
