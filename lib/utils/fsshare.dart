import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import 'package:device_info/device_info.dart';

class FsShare {
  Future<void> myShare(BuildContext context, String msg,
      {String subject = ""}) async {
    bool a = await isIpad();
    //final RenderBox box = context.findRenderObject();
    if (a) {
      Share.share(
        msg,
        subject: subject,
        sharePositionOrigin:
            Rect.fromCenter(center: Offset(730, 200), width: 100, height: 100),
      );
    } else {
      Share.share(msg, subject: subject)
          /*    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size)*/;
    }
  }

  static Future<bool> isIpad() async {
    try {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      return iosInfo.name.toLowerCase().contains('ipad');
    } catch (e) {
      return false;
    }
  }
}
