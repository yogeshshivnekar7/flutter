import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class QrDemo extends StatelessWidget {
  String _data;

  QrDemo(var userProfiew) {
//    _data=data;
    print("userProfiel -- $userProfiew");
    print("-----------------------------------------------------------------");
    _data = AppUtils.generatePassData(userProfiew);
//    String s =
//        "[84549568055954796,160,160,\"Amit\",\"\",\"M\",\"918055954796\",\"\",\"\",\"\",\"\",\"\",\"\",\"Navi Mumbai\",\"guest\",\"\",\"\",,\"\"]";
    _data = AppUtils.encrypt(_data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImage(
              data: _data,
              version: QrVersions.auto,
              size: 200.0,
            )
          ]),
    );
  }
}
