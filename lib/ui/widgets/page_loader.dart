import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class PageLoader extends StatelessWidget {
  String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SpinKitCubeGrid(
      color: FsColor.primary,
        size: 60.0,
      ),
         /* SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(FsColor.darkgrey),
              strokeWidth: 3.0,
            ),
          ),*/
          SizedBox(
            height: 30.0,
          ),
//          Text(title == null || title.isEmpty ? "CubeOne is loading..." : title,
//              style: TextStyle(
//                fontSize: FSTextStyle.h4size,
//                color: FsColor.darkgrey,
//                fontFamily: 'Gilroy-SemiBold',
//              )),
        ],
      ),
    );
  }

  PageLoader({this.title});
}
