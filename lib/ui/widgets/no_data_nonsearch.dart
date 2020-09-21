import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class FsNoData extends StatelessWidget {
  var message;

  var title;

  FsNoData({this.title, this.message});

  @override
  Widget build(BuildContext context) {
    bool name = true;
    if (title.toString() == "false" || title.toString() == "true") {
      name = !title;
    } else {
      title = true;
    }

    return Container(
        height: 350.0,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Image.asset('images/empty-list.png',
            //   fit: BoxFit.contain,
            //   width: 150.0, height: 150.0,
            // ),
            title != null && name
                ? Container()
                : Text(
                    title != null ? title : 'No Result'.toLowerCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        letterSpacing: 1.0,
                        fontSize: FSTextStyle.h3size,
                        height: 1.5,
                        color: FsColor.darkgrey),
                  ),
            Text(
              message != null ? message : 'Sorry, no data found!'.toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  letterSpacing: 1.0,
                  height: 1.5,
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey),
            ),
          ],
        ));
  }
}
